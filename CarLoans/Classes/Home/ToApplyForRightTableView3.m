//
//  ToApplyForRightTableView3.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForRightTableView3.h"

@interface ToApplyForRightTableView3 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation ToApplyForRightTableView3
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
    return 3;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 18;
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
        
//        NSArray *topArray = @[@"*姓名",@"*电话",@"*身份证",@"*性别",@"*年龄",@"*民族",@"*政治面貌",@"*学历",@"职业",@"职称",@"*有无驾照",@"现有车辆",@"*主要收入来源"];
        cell.topLbl.text = [TopModel user].ary3[indexPath.row];
        
        if (indexPath.row == 5 ||indexPath.row == 6 ||indexPath.row == 8 ||  indexPath.row == 12 || indexPath.row == 14|| indexPath.row == 16) {
            cell.type = InputType;
            cell.inputTextField.tag = 30000 + indexPath.row;
            if (indexPath.row == 4) {
//                cell.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
            }
        }else if (indexPath.row >= 0 && indexPath.row <= 4)
        {
            cell.type = ShowType;
            cell.showLbl.tag = 30000 + indexPath.row;
        }
        else
        {
            cell.type = ChooseType;
            cell.chooseLbl.tag = 30000 + indexPath.row;
        }

        
        return cell;
    }
    if (indexPath.section == 1) {
        // 定义cell标识  每个cell对应一个自己的标识
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        // 通过不同标识创建cell实例
        ToApplyForEncapsulationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
        if (!cell) {
            cell = [[ToApplyForEncapsulationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        NSArray *topArray = @[@"*紧急联系人1",@"*与主贷人关系",@"*手机号码"];
        cell.topLbl.text = [TopModel user].ary3[indexPath.row + 18];
        
        if (indexPath.row == 0 || indexPath.row == 3) {
            cell.type = InputType;
            cell.inputTextField.tag = 30018 + indexPath.row;
            if (indexPath.row == 2) {
                cell.inputTextField.keyboardType = UIKeyboardTypePhonePad;
            }
        }else
        {
            cell.type = ChooseType;
            cell.chooseLbl.tag = 30018 + indexPath.row;
        }
        
        return cell;
    }
    // 定义cell标识  每个cell对应一个自己的标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    // 通过不同标识创建cell实例
    ToApplyForEncapsulationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[ToApplyForEncapsulationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    NSArray *topArray = @[@"紧急联系人2",@"与主贷人关系",@"手机号码"];
    cell.topLbl.text = [TopModel user].ary3[indexPath.row + 22];;
    
    if (indexPath.row == 0 || indexPath.row == 3) {
        cell.type = InputType;
        cell.inputTextField.tag = 30022 + indexPath.row;
        if (indexPath.row == 2) {
            cell.inputTextField.keyboardType = UIKeyboardTypePhonePad;
        }
    }else
    {
        cell.type = ChooseType;
        cell.chooseLbl.tag = 30022 + indexPath.row;
    }
    
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
    return 53;
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
    return 23;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 107 - 15, 58) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = @"客户信息";
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
    if (section == 0 || section == 1) {
        UIView *footView = [[UIView alloc]init];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 13, SCREEN_WIDTH - 107, 10)];
        lineView.backgroundColor = kBackgroundColor;
        [footView addSubview:lineView];
        
        return footView;
    }
    return nil;
}





@end
