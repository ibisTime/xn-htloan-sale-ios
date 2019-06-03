//
//  ToApplyForRightTableView7.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForRightTableView7.h"

@interface ToApplyForRightTableView7 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation ToApplyForRightTableView7
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
    NSMutableArray * dic = [NSMutableArray array];
    for (int i = 0; i < self.model.creditUserList.count; i ++) {
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"3"]) {
            [dic addObject:self.model.creditUserList[i]];
        }
    }
    NSLog(@"%@",dic);
    return 2 * dic.count;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 11;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 11;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        ToApplyForEncapsulationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[ToApplyForEncapsulationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 ) {
            cell.type = ShowType;
            cell.showLbl.tag = 70000 + indexPath.row;
        }else if (indexPath.row == 4 || indexPath.row == 5)
        {
            cell.type = ChooseType;
            cell.chooseLbl.tag = 70000 + indexPath.row;
        }else
        {
            cell.type = InputType;
            cell.inputTextField.tag = 70000 + indexPath.row;
        }
        if (indexPath.row == 7) {
            cell.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
        }
        if (indexPath.row == 10) {
            cell.inputTextField.keyboardType = UIKeyboardTypePhonePad;
        }
        cell.topLbl.text = [TopModel user].ary7[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        ToApplyForUpdateImgCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[ToApplyForUpdateImgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *topArray = @[@"担保人1其他资料"];
        cell.name = topArray[indexPath.row];
        
        cell.muArray = [NSMutableArray array];
        cell.muArray = [NSMutableArray arrayWithArray:self.otherPic];
        
        MJWeakSelf;
        cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
            
            weakSelf.returnAryBlock(imgAry, name);
            if ([name isEqualToString:@"担保人1其他资料"]) {
                weakSelf.otherPic = imgAry;
            }
            if ([name isEqualToString:@"担保人2其他资料"]) {
                weakSelf.otherPic1 = imgAry;
            }
            
            [self reloadData];
        };
        return cell;
    }
    if (indexPath.section == 2) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        ToApplyForEncapsulationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[ToApplyForEncapsulationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 ) {
            cell.type = ShowType;
            cell.showLbl.tag = 71000 + indexPath.row;
        }else if (indexPath.row == 4 || indexPath.row == 5)
        {
            cell.type = ChooseType;
            cell.chooseLbl.tag = 71000 + indexPath.row;
        }else
        {
            cell.type = InputType;
            cell.inputTextField.tag = 71000 + indexPath.row;
        }
        cell.topLbl.text = [TopModel user].ary7[indexPath.row];
        return cell;
        
    }
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        ToApplyForUpdateImgCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[ToApplyForUpdateImgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *topArray = @[@"担保人2其他资料"];
        cell.name = topArray[indexPath.row];
        
        cell.muArray = [NSMutableArray array];
        cell.muArray = [NSMutableArray arrayWithArray:self.otherPic1];
        
        MJWeakSelf;
        cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
            
            weakSelf.returnAryBlock(imgAry, name);
            if ([name isEqualToString:@"担保人1其他资料"]) {
                weakSelf.otherPic = imgAry;
            }
            if ([name isEqualToString:@"担保人2其他资料"]) {
                weakSelf.otherPic1 = imgAry;
            }
            [self reloadData];
        };
        return cell;
    
    
    
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
    if (indexPath.section == 0 || indexPath.section == 2) {
        return 53;
    }
    float numberToRound;
    int result;
    numberToRound = (1.0 + self.otherPic.count)/3.0;
    result = (int)ceilf(numberToRound);
    return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 58;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 107 - 15, 58) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = @"担保人信息";
        [headView addSubview:nameLbl];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 57, SCREEN_WIDTH - 107, 1)];
        lineView.backgroundColor = kLineColor;
        [headView addSubview:lineView];
        
        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}




@end
