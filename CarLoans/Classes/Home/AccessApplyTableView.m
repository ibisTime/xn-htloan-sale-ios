//
//  AccessApplyTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AccessApplyTableView.h"

#import "InformationCell.h"
#import "CustomTableViewCell.h"
#define CustomTableView @"CustomTableViewCell"

#define Information @"InformationCell"
#import "SurveyACreditVC.h"

@interface AccessApplyTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation AccessApplyTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[InformationCell class] forCellReuseIdentifier:Information];
        [self registerClass:[CustomTableViewCell class] forCellReuseIdentifier:CustomTableView];
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.model.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomTableView forIndexPath:indexPath];
    cell.isXin = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.model.count > 0) {
        cell.surveyModel = self.model[indexPath.row];
    }
    
    SurveyModel *model = self.model[indexPath.row];
    if ([model.curNodeCode isEqualToString:@"b1"] || [model.curNodeCode isEqualToString:@"b1x"]) {
        cell.isXin = YES;
        [cell.button setTitle:@"录入" forState:(UIControlStateNormal)];
        cell.button.hidden = NO;
    }else if ([model.curNodeCode isEqualToString:@"b2"]) {
        [cell.button setTitle:@"区域总审" forState:(UIControlStateNormal)];
        cell.isXin = YES;
        cell.button.hidden = NO;
    }else if ([model.curNodeCode isEqualToString:@"b3"]) {
        [cell.button setTitle:@"风控一审" forState:(UIControlStateNormal)];
        cell.isXin = YES;
        cell.button.hidden = NO;
    }else if ([model.curNodeCode isEqualToString:@"b4"]) {
        [cell.button setTitle:@"风控二审" forState:(UIControlStateNormal)];
        cell.isXin = YES;
        cell.button.hidden = NO;
    }else if ([model.curNodeCode isEqualToString:@"b5"]) {
        [cell.button setTitle:@"风控终审" forState:(UIControlStateNormal)];
        cell.isXin = YES;
        cell.button.hidden = NO;
    }else if ([model.curNodeCode isEqualToString:@"b6"]) {
        [cell.button setTitle:@"业务总监审核" forState:(UIControlStateNormal)];
        cell.isXin = YES;
        cell.button.hidden = NO;
    }else if ([model.curNodeCode isEqualToString:@"b6"]) {
        [cell.button setTitle:@"业务总监审核" forState:(UIControlStateNormal)];
        cell.isXin = YES;
        cell.button.hidden = NO;
    }else if ([model.curNodeCode isEqualToString:@"b7"]) {
        [cell.button setTitle:@"财务总监审核" forState:(UIControlStateNormal)];
        cell.isXin = YES;
        cell.button.hidden = NO;
    }else
    {
        cell.button.hidden = YES;
    }
    [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.button.tag = indexPath.row;
    return cell;
}

//添加证信人
-(void)buttonClick:(UIButton *)sender
{
    
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
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
//    SurveyModel *model = self.model[indexPath.row];
    return 330;
}



#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
