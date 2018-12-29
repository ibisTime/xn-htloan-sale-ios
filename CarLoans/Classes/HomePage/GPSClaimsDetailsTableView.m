//
//  GPSClaimsDetailsTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSClaimsDetailsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"

@interface GPSClaimsDetailsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GPSClaimsDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];

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
    if (section == 0) {
        return 7;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"状态",@"客户姓名",@"手机号",@"申请个数",@"有线个数",@"无线个数",@"申请说明"];
    cell.name = nameArray[indexPath.row];
    cell.isInput = @"0";
    NSString *state;
    if (_model.status == 0) {
        state = @"待审核";
    }else if (_model.status == 1)
    {
        state = @"审核通过,待发货";
    }
    else if (_model.status == 2)
    {
        state = @"审核不通过";
    }
    else if (_model.status == 3)
    {
        state = @"已发货,待收货";
    }else
    {
        state = @"已收货";
    }
    NSArray *textFidArray = @[
             state,
             [NSString stringWithFormat:@"%@",_model.customerName],
             [NSString stringWithFormat:@"%@",_model.mobile],
             [NSString stringWithFormat:@"%@个",_model.applyCount],
             [NSString stringWithFormat:@"%@个",_model.applyWiredCount],
             [NSString stringWithFormat:@"%@个",_model.applyWirelessCount],
             [NSString stringWithFormat:@"%@",_model.applyReason]
                              ];
    cell.TextFidStr = textFidArray[indexPath.row];
    return cell;
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
    return 50;
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
