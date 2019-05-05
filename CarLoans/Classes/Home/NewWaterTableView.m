//
//  NewWaterTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/2.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "NewWaterTableView.h"
#import "NewWaterCell.h"
#import "CollectionViewCell.h"
@interface NewWaterTableView ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>

@end
@implementation NewWaterTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        //        [self registerClass:[ToApplyForEncapsulationCell class] forCellReuseIdentifier:ToApplyForEncapsulation];
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [TopModel user].newWaterAry.count;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        NewWaterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[NewWaterCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.topLbl.text = [TopModel user].newWaterAry[indexPath.row];
        NSString *type;

//        if (indexPath.row == 0) {
//            cell.type = ShowType;
////            cell.showLbl.text = self.model.creditUser[@"userName"];
//        }else
            if (indexPath.row <= 5) {
            
            if ([BaseModel isBlankString:self.waterDic[@"code"]] == NO) {
                if ([_waterDic[@"type"] isEqualToString:@"1"]) {
                    type = @"微信";
                }else if ([_waterDic[@"type"] isEqualToString:@"2"])
                {
                    type = @"支付宝";
                }else
                {
                    type = @"银行";
                }
                if (indexPath.row == 0) {
                    cell.chooseLbl.text = _waterDic[@"userName"];
                }
                if (indexPath.row == 1) {
                    cell.chooseLbl.text = type;
                }
                if (indexPath.row == 2) {
                    cell.chooseLbl.text = [_waterDic[@"datetimeStart"] convertDate];
                }
                if (indexPath.row == 3) {
                    cell.chooseLbl.text = [_waterDic[@"datetimeEnd"] convertDate];
                }
                if (indexPath.row == 4) {
                    cell.chooseLbl.text = _waterDic[@"jourInterest1"];
                }
                if (indexPath.row == 5) {
                    cell.chooseLbl.text = _waterDic[@"jourInterest2"];
                }
            }
            cell.type = UIChooseType;
            cell.chooseLbl.tag = 10000 + indexPath.row;
        }
        else
        {
            if (indexPath.row == 6) {
                cell.inputTextField.text = [NSString stringWithFormat:@"%.2f",[_waterDic[@"interest1"] floatValue]/1000];
            }
            if (indexPath.row == 7) {
                cell.inputTextField.text = [NSString stringWithFormat:@"%.2f",[_waterDic[@"interest2"] floatValue]/1000];
            }
            if (indexPath.row == 8) {
                cell.inputTextField.text = [NSString stringWithFormat:@"%.2f",[_waterDic[@"income"] floatValue]/1000];
            }
            if (indexPath.row == 9) {
                cell.inputTextField.text = [NSString stringWithFormat:@"%.2f",[_waterDic[@"expend"] floatValue]/1000];
            }
            if (indexPath.row == 10) {
                cell.inputTextField.text = [NSString stringWithFormat:@"%.2f",[_waterDic[@"monthIncome"] floatValue]/1000];
            }
            if (indexPath.row == 11) {
                cell.inputTextField.text = [NSString stringWithFormat:@"%.2f",[_waterDic[@"monthExpend"] floatValue]/1000];
            }
            if (indexPath.row == 12) {
                cell.inputTextField.text = [NSString stringWithFormat:@"%.2f",[_waterDic[@"balance"] floatValue]/1000];
            }
            if (indexPath.row == 13) {
                cell.inputTextField.text = _waterDic[@"remark"];
            }
            cell.type = UIInputType;
            cell.inputTextField.tag = 10000 + indexPath.row;
        }
        return cell;
    }
    
    static NSString *CellIdentifier = @"Cell";
    CollectionViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[CollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    cell.collectDataArray = self.picArray;
    return cell;
}

-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:[str integerValue] selectRowState:@"add"];
    }
}

-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:[str integerValue] selectRowState:@"delete"];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        float numberToRound;
        int result;
        numberToRound = (self.picArray.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
    }
    return 53;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 50;
    }
    return 40;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 100;
    }
    return 23;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = @"流水";
        [headView addSubview:nameLbl];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [headView addSubview:lineView];
        
        return headView;
    }
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = @"流水图片";
        [headView addSubview:nameLbl];
        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];

        UIButton *initiateButton = [UIButton buttonWithTitle:@"确定" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
        initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH - 30, 50);
        kViewRadius(initiateButton, 5);
        [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
//        initiateButton.tag = 100;
        [headView addSubview:initiateButton];
        
        return headView;
    }
    return nil;
}

-(void)confirmButtonClick:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:100 selectRowState:@"confirm"];
}


@end
