//
//  DetailsMenuTableView12.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/31.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DetailsMenuTableView12.h"

#import "InstructionsCell.h"

#import "MenuInputCell.h"
@interface DetailsMenuTableView12 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation DetailsMenuTableView12

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MenuInputCell class] forCellReuseIdentifier:@"MenuInputCell"];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 7;
    }
    return 2;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        NSArray *nameArray = @[@"收件时间",@"收件说明"];
        cell.leftStr = nameArray[indexPath.row];
        cell.type = MenuShowType;
        NSArray *ary = @[
                         [BaseModel convertNull:self.model.bankLoan[@"bankFkDate"]],
                         [BaseModel convertNull:self.model.bankLoan[@"bankFkNote"]]
                         ];
        cell.rightStr = ary[indexPath.row];
    }
    if (indexPath.section == 1) {
        NSArray *nameArray = @[@"提交时间",@"提交说明"];
        cell.leftStr = nameArray[indexPath.row];
        cell.type = MenuShowType;
        NSArray *ary = @[
                         [BaseModel convertNull:[self.model.bankLoan[@"bankCommitDatetime"] convertToDetailDate]],
                         [BaseModel convertNull:self.model.bankLoan[@"bankCommitNote"]]
                         ];
        cell.rightStr = ary[indexPath.row];
    }
    if (indexPath.section == 2) {
        NSArray *nameArray = @[@"贷款编号",@"银行还款日",@"账单日",@"卡号",@"放款备注",@"放款日期",@"收款备注"];
        cell.leftStr = nameArray[indexPath.row];
        cell.type = MenuShowType;
        NSArray *ary = @[
                         [BaseModel convertNull:self.model.bankLoan[@"loanNumber"]],
                         [NSString stringWithFormat:@"%ld",[self.model.bankLoan[@"repayBankDate"] integerValue]],
                         [NSString stringWithFormat:@"%ld",[self.model.bankLoan[@"repayBillDate"] integerValue]],
                         [BaseModel convertNull:self.model.bankLoan[@"repayBankcardNumber"]],
                         [BaseModel convertNull:self.model.bankLoan[@"bankFkRemark"]],
                         [BaseModel convertNull:[self.model.bankLoan[@"bankFkDatetime"] convertToDetailDate]],
                         [BaseModel convertNull:self.model.bankLoan[@"receiptRemark"]]
                         
                         ];
        cell.rightStr = ary[indexPath.row];
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
    
    return 55;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 3) {
        return 45;
    }
    return 0.01;
}
#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 3) {
        UIView *headView = [[UIView alloc]init];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        NSArray *ary = @[@"收件信息",@"提交银行信息",@"放款信息"];
        nameLbl.text = ary[section];
        [headView addSubview:nameLbl];
        return headView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
@end
