//
//  MenuTableView5.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MenuTableView5.h"

#import "MenuInputCell.h"
@interface MenuTableView5 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation MenuTableView5

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
    return [MenuModel new].menuArray5.count;
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
    NSArray *nameArray = [MenuModel new].menuArray5;
    
    cell.leftStr = nameArray[indexPath.row];
    
    
    cell.placStr = [NSString stringWithFormat:@"请输入%@",nameArray[indexPath.row]];
    
    
    
    NSString *carFunds3;
    if ([self.model.carFunds3 floatValue] == 0) {
        NSDictionary *bankLoan = self.model.bankLoan;
        
        NSString *totalRate = bankLoan[@"totalRate"];
        NSString *loanAmount = [BaseModel Chu1000:bankLoan[@"loanAmount"]];
        
        NSString *rebateRate = bankLoan[@"rebateRate"];
//        银行利率
        NSString *bankRate = bankLoan[@"bankRate"];
        carFunds3 = [NSString stringWithFormat:@"%.2f",([totalRate floatValue] - [rebateRate floatValue] - [bankRate floatValue]) * [loanAmount floatValue]];
    }
    else
    {
        carFunds3 = [BaseModel Chu1000:self.model.carFunds3];
    }
    NSString *repointAmount;
    if ([self.model.repointAmount floatValue] == 0) {
        NSDictionary *bankLoan = self.model.bankLoan;
        NSString *loanAmount = [BaseModel Chu1000:bankLoan[@"loanAmount"]];
        NSString *bankRate = bankLoan[@"rebateRate"];
        NSString *totalRate = bankLoan[@"totalRate"];
        NSString *rebateRate = bankLoan[@"rebateRate"];
        repointAmount = [NSString stringWithFormat:@"%.2f",([totalRate floatValue] - [rebateRate floatValue]) * [loanAmount floatValue]];
    }
    else
    {
        repointAmount = [BaseModel Chu1000:self.model.repointAmount];
    }
    
    NSArray *ary = @[[BaseModel Chu1000:self.model.gpsFee],
                     [BaseModel Chu1000:self.model.fxAmount],
                     [BaseModel Chu1000:self.model.lyDeposit],
                     [BaseModel Chu1000:self.model.otherFee],
                     [BaseModel Chu1000:self.model.loanAmount],
                     repointAmount,
                     carFunds3,
                     [BaseModel Chu1000:self.model.carFunds4],
                     [BaseModel Chu1000:self.model.carFunds5]
                     ];
    
    if (indexPath.row == 4) {
        cell.type = MenuShowType;
        cell.rightLbl.text = ary[indexPath.row];
    }else
    {
        if (self.isDetails == YES) {
            cell.type = MenuShowType;
            cell.rightLbl.text = ary[indexPath.row];
        }else
        {
            cell.type = MenuInputType;
            if (indexPath.row == 5) {
                cell.rightTF.text = ary[indexPath.row];
            }else
            if (indexPath.row == 6) {
                cell.rightTF.text = ary[indexPath.row];
            }else
            {
                if ([cell.rightTF.text isEqualToString:@""]) {
                    cell.rightTF.text = ary[indexPath.row];
                }
            }
            
        }
    }
    cell.rightTF.tag = 5000 + indexPath.row;
    
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
    if (section == 2) {
        return 10;
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
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

@end
