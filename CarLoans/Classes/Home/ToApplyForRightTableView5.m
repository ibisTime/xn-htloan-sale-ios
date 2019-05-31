//
//  ToApplyForRightTableView5.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForRightTableView5.h"

@interface ToApplyForRightTableView5 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation ToApplyForRightTableView5
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
        return [TopModel user].ary5.count;
    }
    return 4;
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
        
//        NSArray *topArray = @[@"*是否自己单位",@"所属行业",@"*单位经济性质",@"*工作单位名称",@"*工作单位地址",@"工作单位电话",@"何时进入该单位",@"职务",@"*月收入",@"工作描述及还款来源分析"];
        cell.topLbl.text = [TopModel user].ary5[indexPath.row];
        
        if (indexPath.row == 0 || indexPath.row == 1 ||indexPath.row == 3 || indexPath.row == 6 || indexPath.row == 7) {
            cell.type = ChooseType;
            cell.chooseLbl.tag = 50000 + indexPath.row;
            
        }
        else
        {
            cell.type = InputType;
            cell.inputTextField.tag = 50000 + indexPath.row;
        }
        if (indexPath.row == 5 || indexPath.row == 8 || indexPath.row == 10 || indexPath.row == 11) {
//            cell.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
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
    NSArray *topArray = @[@"收入证明",@"单位前台照片",@"办公场地照片",@"签约员与客户合影"];
    cell.muArray = [NSMutableArray array];
    cell.name = topArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.muArray = [NSMutableArray arrayWithArray:self.improvePdf];
    }else if (indexPath.row == 1)
    {
        cell.muArray = [NSMutableArray arrayWithArray:self.frontTablePic];
    }else if (indexPath.row == 2)
    {
        cell.muArray = [NSMutableArray arrayWithArray:self.workPlacePic];
    }else if (indexPath.row == 3)
    {
        cell.muArray = [NSMutableArray arrayWithArray:self.salerAndcustomer];
    }
    MJWeakSelf;
    cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        
        weakSelf.returnAryBlock(imgAry, name);
        if ([name isEqualToString:@"收入证明"]) {
            weakSelf.improvePdf = imgAry;
        }
        if ([name isEqualToString:@"单位前台照片"]) {
            weakSelf.frontTablePic = imgAry;
        }
        if ([name isEqualToString:@"办公场地照片"]) {
            weakSelf.workPlacePic = imgAry;
        }
        if ([name isEqualToString:@"签约员与客户合影"]) {
            weakSelf.salerAndcustomer = imgAry;
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
    if (indexPath.row == 0) {
        float numberToRound;
        int result;
        numberToRound = (self.improvePdf.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
    }
    if (indexPath.row == 1) {
        float numberToRound;
        int result;
        numberToRound = (self.frontTablePic.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
    }
    if (indexPath.row == 2) {
        float numberToRound;
        int result;
        numberToRound = (self.workPlacePic.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
    }
    if (indexPath.row == 3) {
        float numberToRound;
        int result;
        numberToRound = (self.salerAndcustomer.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
    }
    return 50;
    
    
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
        nameLbl.text = @"工作情况";
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
