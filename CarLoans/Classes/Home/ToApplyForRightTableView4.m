//
//  ToApplyForRightTableView4.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForRightTableView4.h"

@interface ToApplyForRightTableView4 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation ToApplyForRightTableView4
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
        return [TopModel user].ary4.count;
    }
    return 7;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 定义cell标识  每个cell对应一个自己的标识
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        // 通过不同标识创建cell实例
        ToApplyForEncapsulationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
        if (!cell) {
            cell = [[ToApplyForEncapsulationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        

        cell.topLbl.text = [TopModel user].ary4[indexPath.row];
        
        if (indexPath.row == 0 || indexPath.row == 5 || indexPath.row == 8) {
            cell.type = ChooseType;
            cell.chooseLbl.tag = 40000 + indexPath.row;
        }
        else
        {
            cell.type = InputType;
            cell.inputTextField.tag = indexPath.row + 40000;
        }
        
        return cell;
    }
    // 定义cell标识  每个cell对应一个自己的标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    // 通过不同标识创建cell实例
    ToApplyForUpdateImgCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[ToApplyForUpdateImgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *topArray = @[@"户口本",@"结婚证/离婚证",@"购房合同/房产本",@"购房发票",@"居住证明",@"自建房证明",@"家访照片"];
    cell.name = topArray[indexPath.row];
    
    cell.muArray = [NSMutableArray array];
    if (indexPath.row == 0) {
        
        cell.muArray = [NSMutableArray arrayWithArray:self.hkBookPdf];
    }else if (indexPath.row == 1)
    {
        cell.muArray = [NSMutableArray arrayWithArray:self.marryPdf];
    }else if (indexPath.row == 2)
    {
        cell.muArray = [NSMutableArray arrayWithArray:self.houseContract];
    }else if (indexPath.row == 3)
    {
        cell.muArray = [NSMutableArray arrayWithArray:self.houseInvoice];
    }else if (indexPath.row == 4)
    {
        cell.muArray = [NSMutableArray arrayWithArray:self.liveProvePdf];
    }else if (indexPath.row == 5)
    {
        cell.muArray = [NSMutableArray arrayWithArray:self.buildProvePdf];
    }else if (indexPath.row == 6)
    {
        cell.muArray = [NSMutableArray arrayWithArray:self.housePictureApply];
    }
    
    MJWeakSelf;
    cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        
        weakSelf.returnAryBlock(imgAry, name);
        if ([name isEqualToString:@"户口本"]) {
            weakSelf.hkBookPdf = imgAry;
        }
        if ([name isEqualToString:@"结婚证/离婚证"]) {
            weakSelf.marryPdf = imgAry;
        }
        if ([name isEqualToString:@"购房合同/房产本"]) {
            weakSelf.houseContract = imgAry;
        }
        if ([name isEqualToString:@"购房发票"]) {
            weakSelf.houseInvoice = imgAry;
        }
        if ([name isEqualToString:@"居住证明"]) {
            weakSelf.liveProvePdf = imgAry;
        }
        if ([name isEqualToString:@"自建房证明"]) {
            weakSelf.buildProvePdf = imgAry;
        }
        if ([name isEqualToString:@"家访照片"]) {
            weakSelf.housePictureApply = imgAry;
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
    if (indexPath.section == 0) {
        return 53;
    }
    NSInteger num = 0;
    if (indexPath.row == 0) {
        num = self.hkBookPdf.count;
    }
    if (indexPath.row == 1) {
        num = self.marryPdf.count;
    }
    if (indexPath.row == 2) {
        num = self.houseContract.count;
    }
    if (indexPath.row == 3) {
        num = self.houseInvoice.count;
    }
    if (indexPath.row == 4) {
        num = self.liveProvePdf.count;
    }
    if (indexPath.row == 5) {
        num = self.buildProvePdf.count;
    }
    if (indexPath.row == 6) {
        num = self.housePictureApply.count;
    }
    float numberToRound;
    int result;
    numberToRound = (1.0 + num)/3.0;
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
        nameLbl.text = @"家庭情况";
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
