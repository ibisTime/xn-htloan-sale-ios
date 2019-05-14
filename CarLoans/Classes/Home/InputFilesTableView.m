//
//  InputFilesTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/8.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "InputFilesTableView.h"
#import "InformationCell.h"
#define Information @"InformationCell"
@implementation InputFilesTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[InformationCell class] forCellReuseIdentifier:Information];
        
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
    static NSString *CellIdentifier = @"Cell";
    InformationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isCar = self.isCar;
    if (cell == nil) {
        cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AccessSingleModel *model = self.model[indexPath.row];
    cell.CarMortgageModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.button setTitle:[[BaseModel user]note:model.enterNodeCode] forState:(UIControlStateNormal)];
    
    if ([self.model[indexPath.row].enterNodeCode isEqualToString:@"e9"] || [self.model[indexPath.row].enterNodeCode isEqualToString:@"f13"] || [self.model[indexPath.row].enterNodeCode isEqualToString:@"f14"]) {
        if ([self.model[indexPath.row].enterNodeCode isEqualToString:@"e9"]) {
            [cell.button setTitle:@"第一次待入档" forState:(UIControlStateNormal)];
        }
        if ([self.model[indexPath.row].enterNodeCode isEqualToString:@"f13"]) {
            [cell.button setTitle:@"第二次待入档" forState:(UIControlStateNormal)];
        }
        if ([self.model[indexPath.row].enterNodeCode isEqualToString:@"f14"]) {
            [cell.button setTitle:@"确认入档" forState:(UIControlStateNormal)];
        }
        cell.button.hidden = NO;
    }
    else
        cell.button.hidden = YES;
    
    
    
//    [cell.button setTitle:[[BaseModel user]note:model.enterNodeCode] forState:(UIControlStateNormal)];
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
