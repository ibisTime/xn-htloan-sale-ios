//
//  ToApplyForVCTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForVCTableView.h"

#import "AdmissionDetailsCell.h"

@interface ToApplyForVCTableView ()<UITableViewDataSource,UITableViewDelegate>


@end
@implementation ToApplyForVCTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[AdmissionDetailsCell class] forCellReuseIdentifier:@"AdmissionDetailsCell"];

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
    return 8;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AdmissionDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdmissionDetailsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {//指定第一行为选中状态
        [self selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
    NSArray *array = @[@"贷款信息",@"车辆信息",@"客户信息",@"家庭情况",@"工作情况",@"共还人信息",@"担保人信息",@"流水信息"];
    cell.nameLbl.text = array[indexPath.row];
    if (cell.height == 0) {
        cell.nameLbl.hidden = YES;
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
    if (indexPath.row != 5 && indexPath.row != 6) {
        return 40;
    }
    for (int i = 0; i < self.model.creditUserList.count; i ++) {
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"2"]) {
            if (indexPath.row == 5) {
                return 40;
            }
        }
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"3"]) {
            if (indexPath.row == 6) {
                return 40;
            }
        }
    }
    return 0;
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
