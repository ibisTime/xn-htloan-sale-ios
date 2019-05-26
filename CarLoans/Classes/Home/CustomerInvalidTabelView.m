//
//  CustomerInvalidTabelView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/1.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CustomerInvalidTabelView.h"
#import "CustomerInvalidCell.h"
#define CustomerInvalid @"CustomerInvalidCell"


@interface CustomerInvalidTabelView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation CustomerInvalidTabelView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CustomerInvalidCell class] forCellReuseIdentifier:CustomerInvalid];

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
    CustomerInvalidCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomerInvalid forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.model.count > 0) {
        cell.model = self.model[indexPath.row];
    }
//    [[BaseModel user]note:self.model[indexPath.row].cancelNodeCode];
    [cell.button setTitle:[[BaseModel user]note:self.model[indexPath.row].cancelNodeCode] forState:(UIControlStateNormal)];
    cell.button.tag = indexPath.row;
    [cell.button addTarget:self action:@selector(clickbutton:) forControlEvents:(UIControlEventTouchUpInside)];
//    cell.hidden = NO;
    if ([self.model[indexPath.row].cancelNodeCode isEqualToString:@"i3"]) {
        cell.button.hidden = YES;
    }
    return cell;
}
-(void)clickbutton:(UIButton *)sender{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"select"];
    }
}
//添加证信人
-(void)photoBtnClick:(UIButton *)sender
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
   
    if ([self.model[indexPath.row].cancelNodeCode isEqualToString:@"i3"]) {
        return 340;
    }
    return 380;
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
