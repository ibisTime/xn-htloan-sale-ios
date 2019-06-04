//
//  CreditReviewTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CreditReviewTableView.h"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "CreditReportingPersonInformationCell.h"
#define CreditReportingPersonInformation @"CreditReportingPersonInformationCell"
#import "SurverCertificateCell.h"
#define SurverCertificate @"SurverCertificateCell"
#import "UsedCarInformationCell.h"
#define UsedCarInformation @"UsedCarInformationCell"
@interface CreditReviewTableView ()<UITableViewDataSource,UITableViewDelegate,CreditReportingPersonInformationDelegate>

@end
@implementation CreditReviewTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[CreditReportingPersonInformationCell class] forCellReuseIdentifier:CreditReportingPersonInformation];
        [self registerClass:[SurverCertificateCell class] forCellReuseIdentifier:SurverCertificate];
        [self registerClass:[UsedCarInformationCell class] forCellReuseIdentifier:UsedCarInformation];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
        return 8;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"业务种类",@"贷款金额",@"业务归属",@"指派归属",@"当前状态"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSString *bizType;
        if ([self.model.bizType integerValue] == 0) {
            bizType = @"新车";
        }
        else
        {
            bizType = @"二手车";
        }
        
        NSArray *rightAry = @[[BaseModel convertNull:self.model.code],
                              [NSString stringWithFormat:@"%@",self.model.creditUser[@"userName"]],
                              [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull:self.model.loanBankName],[BaseModel convertNull:self.model.subbranchBankName]],
                              bizType,
                              [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000],
                              [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                              [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                              [BaseModel convertNull:[[BaseModel user]note:self.model.curNodeCode]]];
        
        cell.TextFidStr = rightAry[indexPath.row];
        cell.nameTextField.hidden = YES;
        cell.nameTextLabel.hidden = NO;
        return cell;
    }
    
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"*审核意见";
    cell.nameText = @"请输入审核意见";
    cell.nameTextField.tag = 3000;
    return cell;
}



-(void)CreditReportingPersonInformationButton:(UIButton *)sender
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
//    if (indexPath.section == 2) {
//        return 15 + 135 * self.model.creditUserList.count + (self.model.creditUserList.count - 1) * 10;
//    }
    return 50;
    
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
    if (section == 1) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        
        UIButton *throughButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        throughButton.frame = CGRectMake(20, 30, (SCREEN_WIDTH - 60)/2, 50);
        [throughButton setTitle:@"通过" forState:(UIControlStateNormal)];
        throughButton.backgroundColor = MainColor;
        kViewRadius(throughButton, 5);
        throughButton.titleLabel.font = HGfont(18);
        throughButton.tag = 100;
        [throughButton addTarget:self action:@selector(auditButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:throughButton];
        
        UIButton *notThroughButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        notThroughButton.frame = CGRectMake(SCREEN_WIDTH/2 + 10, 30, (SCREEN_WIDTH - 60)/2, 50);
        [notThroughButton setTitle:@"不通过" forState:(UIControlStateNormal)];
        notThroughButton.backgroundColor = MainColor;
        kViewRadius(notThroughButton, 5);
        notThroughButton.titleLabel.font = HGfont(18);
        notThroughButton.tag = 101;
        [notThroughButton addTarget:self action:@selector(auditButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:notThroughButton];
        
        return headView;
    }
    return nil;
}

-(void)auditButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"audit"];
        
    }
}
@end
