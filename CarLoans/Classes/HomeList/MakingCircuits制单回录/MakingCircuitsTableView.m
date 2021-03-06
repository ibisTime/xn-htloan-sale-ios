//
//  MakingCircuitsTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MakingCircuitsTableView.h"

#import "MenuInputCell.h"
#import "InstructionsCell.h"
@interface MakingCircuitsTableView ()<UITableViewDataSource,UITableViewDelegate>



@end
@implementation MakingCircuitsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        if ([self.model.isPay isEqualToString:@"1"]) {
            return 7;
        }
        return 5;
    }
    return [MenuModel new].detailsInfoArray.count;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = [MenuModel new].detailsInfoArray;
        cell.leftStr = nameArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.type = MenuCheckDetailsType;
            cell.rightLbl.text = self.model.code;
        }else
        {
            cell.type = MenuShowType;
            NSString *bizType;
            if ([self.model.bizType isEqualToString:@"0"]) {
                bizType = @"新车";
            }else
            {
                bizType = @"二手车";
            }
            NSArray *ary = @[@"",
                             [BaseModel convertNull:self.model.creditUser[@"userName"]],
                             [BaseModel convertNull:self.model.loanBankName],
                             bizType,
                             [BaseModel Chu1000:self.model.loanAmount],
                             [[BaseModel user]note:self.model.curNodeCode],
                             [self.model.applyDatetime convertToDetailDate],
                             [NSString stringWithFormat:@"%@（%@）",self.model.saleUserName,self.model.teamName]
                             ];
            cell.rightLbl.text = ary[indexPath.row];
        }
        return cell;
    }
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray;
    NSArray *ary = @[
                     [BaseModel Chu1000:self.model.loanAmount],
                     [BaseModel Chu1000:self.model.repointAmount],
                     [BaseModel JIAmult1:[BaseModel Chu1000:self.model.loanAmount] mult2:[BaseModel Chu1000:self.model.repointAmount] scale:2]];
    if ([self.model.isPay isEqualToString:@"1"]) {
        nameArray = @[@"车款1",@"车款2",@"PGS费用",@"支付合计",@"*收款账号选择",@"收款账号户名",@"收款账号"];
        ary = @[
                [BaseModel Chu1000:self.model.loanAmount],
                [BaseModel Chu1000:self.model.repointAmount],
                [BaseModel Chu1000:self.model.gpsFee],
                [BaseModel JIANGmult1:[BaseModel JIAmult1:[BaseModel Chu1000:self.model.loanAmount] mult2:[BaseModel Chu1000:self.model.repointAmount] scale:2] mult2:[BaseModel Chu1000:self.model.gpsFee] scale:2]];
        if (indexPath.row < 4) {
            cell.rightStr = ary[indexPath.row];
        }
        if (indexPath.row == 4) {
            cell.type = MenuChooseType;
        }else
        {
            cell.type = MenuShowType;
            //        cell.rightTF.tag = 100 + indexPath.row;
        }
        if (indexPath.row >= 4) {
            if ([BaseModel isBlankString:_advanceCardCodeDic[@"code"]] == NO) {
                NSArray *ary = @[[NSString stringWithFormat:@"%@-%@",_advanceCardCodeDic[@"companyName"],_advanceCardCodeDic[@"bankName"]],
                                 [BaseModel convertNull:_advanceCardCodeDic[@"realName"]],
                                 [BaseModel convertNull:_advanceCardCodeDic[@"bankcardNumber"]]];
                cell.rightStr = ary[indexPath.row - 4];
            }
        }
    }else
    {
        nameArray = @[@"车款1",@"支付合计",@"*收款账号选择",@"收款账号户名",@"收款账号"];
        ary = @[[BaseModel Chu1000:self.model.loanAmount],
                [BaseModel Chu1000:self.model.loanAmount]];
        if (indexPath.row < 2) {
            cell.rightStr = ary[indexPath.row];
        }
        if (indexPath.row == 2) {
            cell.type = MenuChooseType;
        }else
        {
            cell.type = MenuShowType;
            //        cell.rightTF.tag = 100 + indexPath.row;
        }
        if (indexPath.row >= 2) {
            if ([BaseModel isBlankString:_advanceCardCodeDic[@"code"]] == NO) {
                NSArray *ary = @[[NSString stringWithFormat:@"%@-%@",_advanceCardCodeDic[@"companyName"],_advanceCardCodeDic[@"bankName"]],
                                 [BaseModel convertNull:_advanceCardCodeDic[@"realName"]],
                                 [BaseModel convertNull:_advanceCardCodeDic[@"bankcardNumber"]]];
                cell.rightStr = ary[indexPath.row - 2];
            }
        }
    }
    
    
    cell.leftStr = nameArray[indexPath.row];
    
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
    if (section == 1) {
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
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = kHexColor(@"#F5F5F5");
        [headView addSubview:lineView];
        return headView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

@end
