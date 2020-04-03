//
//  MakeAuditTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MakeAuditTableView.h"

#import "MenuInputCell.h"
#import "InstructionsCell.h"
@interface MakeAuditTableView ()<UITableViewDataSource,UITableViewDelegate>



@end
@implementation MakeAuditTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
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
        return 1;
    }
    if (section == 1) {
        if ([BaseModel isBlankString:self.isPay] == YES) {
            return 3;
        }else if ([self.isPay isEqualToString:@"是"])
        {
            return 7;
        }else
        {
            return 5;
        }
        
        return 6;
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
    
    if (indexPath.section == 1) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*是否同时支付车款2",@"添加任务",@"*是否继续垫资"];
        
        
        if ([BaseModel isBlankString:self.isPay] == YES) {
            nameArray = @[@"*是否同时支付车款2",@"添加任务",@"*是否继续垫资"];
            
            
            if (indexPath.row == 0 || indexPath.row == 2) {
                cell.type = MenuChooseType;
            }else if(indexPath.row == 1)
            {
                cell.type = MenuPushType;
            }
        
            if (indexPath.row == 0 || indexPath.row == 2) {
                cell.type = MenuChooseType;
            }else if(indexPath.row == 1)
            {
                cell.type = MenuPushType;
            }
            
            NSArray *ary = @[
                             [BaseModel convertNull:self.isPay],
                             @"",
                             [BaseModel convertNull:self.isContinueAdvance]];
            cell.rightStr = ary[indexPath.row];
            
            
        }else if ([self.isPay isEqualToString:@"是"])
        {
            nameArray = @[@"*是否同时支付车款2",@"车款1",@"车款2",@"GPS费用",@"支付合计",@"添加任务",@"*是否继续垫资"];
    
            if (indexPath.row == 0 || indexPath.row == 6) {
                cell.type = MenuChooseType;
                
            }else if(indexPath.row == 5)
            {
                cell.type = MenuPushType;
            }else
            {
                cell.type = MenuShowType;
            }
            
            NSArray *ary = @[
                             [BaseModel convertNull:self.isPay],
                             [BaseModel Chu1000:self.model.loanAmount],
                             [BaseModel Chu1000:self.model.repointAmount],
                             [BaseModel Chu1000:self.model.gpsFee],
                             [BaseModel JIANGmult1:[BaseModel JIAmult1:[BaseModel Chu1000:self.model.loanAmount] mult2:[BaseModel Chu1000:self.model.repointAmount] scale:2] mult2:[BaseModel Chu1000:self.model.gpsFee] scale:2],
                             @"",
                             [BaseModel convertNull:self.isContinueAdvance]];
            cell.rightStr = ary[indexPath.row];
            
        }else
        {
            nameArray = @[@"*是否同时支付车款2",@"车款1",@"支付合计",@"添加任务",@"*是否继续垫资"];
            if (indexPath.row == 0 || indexPath.row == 5) {
                cell.type = MenuChooseType;
            }else if(indexPath.row == 4)
            {
                cell.type = MenuPushType;
            }else
            {
                cell.type = MenuShowType;
            }
            
            NSArray *ary = @[
                             [BaseModel convertNull:self.isPay],
                             [BaseModel Chu1000:self.model.loanAmount],
                             [BaseModel Chu1000:self.model.loanAmount],
                             @"",
                             [BaseModel convertNull:self.isContinueAdvance]];
            cell.rightStr = ary[indexPath.row];
        }
        
        if (indexPath.row == 0) {
//            cell.rightStr = self.isPay;
            [cell.rightLbl mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(150);
            }];
            
        }
        
        
        cell.leftStr = nameArray[indexPath.row];
        cell.placStr = [NSString stringWithFormat:@"请输入%@",nameArray[indexPath.row]];
        return cell;
    }
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    InstructionsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[InstructionsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.placeHolderLabel.text = @"请输入审核说明";
    cell.textView.tag = 1000;
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
    if (indexPath.section == 2) {
        return 125;
    }
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
