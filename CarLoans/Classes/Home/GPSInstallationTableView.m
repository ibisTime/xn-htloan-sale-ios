//
//  GPSInstallationTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSInstallationTableView.h"

#import "GPSClaimsCell.h"
#define GPSClaims @"GPSClaimsCell"

#import "InformationCell.h"
#define Information @"InformationCell"

@interface GPSInstallationTableView ()<UITableViewDataSource,UITableViewDelegate>

@end


@implementation GPSInstallationTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[GPSClaimsCell class] forCellReuseIdentifier:GPSClaims];
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

    
    InformationCell * cell = [tableView dequeueReusableCellWithIdentifier:Information forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.isGps = YES;
    cell.gpsInstallationModel = self.model[indexPath.row];
    cell.button.tag = indexPath.row;
    [cell.button addTarget:self action:@selector(buttonClick1:) forControlEvents:(UIControlEventTouchUpInside)];
    if ([self.model[indexPath.row].fbhgpsNode isEqualToString:@"d4"]) {
        cell.button.hidden = YES;
    }
    return cell;


}
-(void)buttonClick1:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"select1"];
    }
}
-(void)buttonClick2:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"select2"];
    }
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
//    GPSInstallationModel *model = [GPSInstallationModel new];
//    model = self.model[indexPath.row];
//    if ([model.advanfCurNodeCode isEqualToString:@"002_09"] || [model.advanfCurNodeCode isEqualToString:@"002_12"]) {
//        return 225;
//    }
    if ([self.model[indexPath.row].fbhgpsNode isEqualToString:@"d4"]) {
        return 280;
    }
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
