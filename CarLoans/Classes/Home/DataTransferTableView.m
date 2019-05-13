//
//  DataTransferTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "DataTransferTableView.h"
#import "InformationCell.h"
#import "GPSInfomationCell.h"
#import "GPSDetailaCell.h"
#import "CLTextFiled.h"
#define GPSDetail @"GPSDetailaCell"

#define Information @"InformationCell"
#define GPSInformation @"GPSInfomationCell"
#import "TransferCell.h"

@interface DataTransferTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DataTransferTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;

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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    
    // 定义cell标识  每个cell对应一个自己的标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    // 通过不同标识创建cell实例
    TransferCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[TransferCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.dataTransferModel = self.model[indexPath.row];
    [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.button.tag = indexPath.row;
    return cell;
}


//发件
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
    DataTransferModel *dataTransferModel = self.model[indexPath.row];
//    无按钮状态
    if ([dataTransferModel.status isEqualToString:@"2"])
    {
        if (!dataTransferModel.sendType) {
            return 70 + 35 * 6;
        }else if ([dataTransferModel.sendType isEqualToString:@"1"]){
            return 70 + 35 * 9;
        }else if ([dataTransferModel.sendType isEqualToString:@"2"]){
            return 70 + 35 * 11;
        }
        return 70 + 35 * 11;
    }else
    {
        if (!dataTransferModel.sendType) {
            return 70 + 35 * 6 + 50;
        }else if ([dataTransferModel.sendType isEqualToString:@"1"]){
            return 70 + 35 * 9 + 50;
        }else if ([dataTransferModel.sendType isEqualToString:@"2"]){
            return 70 + 35 * 11 + 50;
        }
        return 70 + 35 * 11 + 50;
    }
    
    
    

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
