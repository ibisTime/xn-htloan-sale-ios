//
//  AdmissionDetailsTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView.h"
#import "AdmissionDetailsCell.h"

@interface AdmissionDetailsTableView ()<UITableViewDataSource,UITableViewDelegate>


@end
@implementation AdmissionDetailsTableView
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
    
    return 18;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AdmissionDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdmissionDetailsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==_row) {//指定第一行为选中状态
        
        [self selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }

    NSArray *array = @[@"基本信息",@"征信列表",@"面签",@"贷款车辆信息",@"申请人基本信息",@"工作情况",@"其他基本信息",@"共还人信息",@"担保人信息",@"财务垫资",@"银行放款",@"车辆抵押",@"发保合",@"GPS安装列表",@"流转日志",@"还款计划",@"附件池",@"流水"];
    cell.nameLbl.text = array[indexPath.row];
    
    if (cell.height < 40) {
        cell.nameLbl.hidden = YES;
    }else
    {
        cell.nameLbl.hidden = NO;
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
    if (indexPath.row != 7 && indexPath.row != 8) {
        return 40;
    }
    for (int i = 0; i < self.model.creditUserList.count; i ++) {
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"2"]) {
            if (indexPath.row == 7) {
                return 40;
            }
        }
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"3"]) {
            if (indexPath.row == 8) {
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
