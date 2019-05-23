//
//  MakeCardTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/2.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MakeCardTableView.h"

#import "InformationCell.h"
#import "CustomTableViewCell.h"
#define CustomTableView @"CustomTableViewCell"

#define Information @"InformationCell"
#import "SurveyACreditVC.h"

@interface MakeCardTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MakeCardTableView

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
        cell.makeCardModel = self.model[indexPath.row];
    }
    if ([self.model[indexPath.row].makeCardNode isEqualToString:@"h1"]) {
        [cell.button setTitle:@"填写制卡单" forState:(UIControlStateNormal)];
        cell.button.hidden = NO;
    }else if ([self.model[indexPath.row].makeCardNode isEqualToString:@"h2"])
    {
        cell.button.hidden = NO;
        [cell.button setTitle:@"手工制卡" forState:(UIControlStateNormal)];
    }else
    {
        cell.button.hidden = YES;
    }
    
    cell.isXin = YES;
    
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
    if ([self.model[indexPath.row].makeCardNode isEqualToString:@"h1"] || [self.model[indexPath.row].makeCardNode isEqualToString:@"h2"]) {
        return 330;
    }
    return 280;
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
