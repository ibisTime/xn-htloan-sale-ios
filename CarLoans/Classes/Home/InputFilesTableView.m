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
    //    InformationCell *cell = [tableView dequeueReusableCellWithIdentifier:Information forIndexPath:indexPath];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    static NSString *CellIdentifier = @"Cell";
    InformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    cell.isCar = self.isCar;
    if (cell == nil) {
        cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AccessSingleModel *model = self.model[indexPath.row];
    cell.CarMortgageModel = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.button setTitle:[[BaseModel user]note:model.curNodeCode] forState:(UIControlStateNormal)];
    
    if ([self.model[indexPath.row].curNodeCode isEqualToString:@"e6"] || [self.model[indexPath.row].curNodeCode isEqualToString:@"f1"] || [self.model[indexPath.row].curNodeCode isEqualToString:@"f4"] || [self.model[indexPath.row].curNodeCode isEqualToString:@"f9"]) {
        cell.button.hidden = NO;
    }
    else
        cell.button.hidden = YES;
    
    [cell.button.titleLabel sizeToFit];
    
    cell.button.frame = CGRectMake(SCREEN_WIDTH - cell.button.titleLabel.width - 25, 290, cell.button.titleLabel.width + 10, 30);
    
    [cell.button setTitle:[[BaseModel user]note:model.curNodeCode] forState:(UIControlStateNormal)];
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
    AccessSingleModel *model = self.model[indexPath.row];
    //    if ([model.curNodeCode isEqualToString:@"002_31"]) {
    //        return 300;
    //
    //    }else
    //    {
    //        return 330;
    //
    //    }
    if ([self.model[indexPath.row].curNodeCode isEqualToString:@"e6"] || [self.model[indexPath.row].curNodeCode isEqualToString:@"f1"] || [self.model[indexPath.row].curNodeCode isEqualToString:@"f4"] || [self.model[indexPath.row].curNodeCode isEqualToString:@"f9"]) {
        return 330;
    }
    return 300;
    
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
