//
//  CreditDetailsTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CreditDetailsTableView.h"

#import "CustomerDetailsCell.h"
#import "CustomerDetailsChooseCell.h"
#import "CreditDetailsCell.h"
@interface CreditDetailsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation CreditDetailsTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CustomerDetailsCell class] forCellReuseIdentifier:@"CustomerDetailsCell"];
        
        [self registerClass:[CreditDetailsCell class] forCellReuseIdentifier:@"CreditDetailsCell"];
        
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
    if (section == 0) {
        return 6;
    }
    return [self.model.credit[@"creditUserList"] count];
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CustomerDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *leftAry = @[@"业务编号",@"主贷人",@"经办银行",@"业务种类",@"贷款金额",@"当前节点"];
        NSString *bizType;
        if ([self.model.credit[@"bizType"] integerValue] == 0) {
            bizType = @"新车";
        }
        else
        {
            bizType = @"二手车";
        }

        NSArray *rightAry = @[[BaseModel convertNull:self.model.code],
                              [BaseModel convertNull:self.model.credit[@"creditUser"][@"userName"]],
                              [BaseModel convertNull:self.model.credit[@"loanBankName"]],
                              bizType,
                              [NSString stringWithFormat:@"%.2f万",[self.model.dkAmount floatValue]/10000],
                              [BaseModel convertNull:self.state]
                              ];
        cell.leftLbl.text = leftAry[indexPath.row];
        cell.rightLbl.text = rightAry[indexPath.row];
        
        return cell;
    }
    CreditDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreditDetailsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
    cell.creditUser = self.model.credit[@"creditUserList"][indexPath.row];
   
    
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
    if (indexPath.section == 1) {
        return 100;
    }
    return 45;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 55;
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
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 45)];
        backView.backgroundColor = kWhiteColor;
        [headView addSubview:backView];
        
        UILabel *titleLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kTextColor];
        titleLbl.text = @"征信人列表";
        [backView addSubview:titleLbl];
        
        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

@end
