//
//  MakeCardEntryTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/2.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MakeCardEntryTableView.h"


#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "CreditReportingPersonInformationCell.h"
#define CreditReportingPersonInformation @"CreditReportingPersonInformationCell"
#import "SurverCertificateCell.h"
#define SurverCertificate @"SurverCertificateCell"
#import "UsedCarInformationCell.h"
#define UsedCarInformation @"UsedCarInformationCell"
#import "ChooseCell.h"
@interface MakeCardEntryTableView ()<UITableViewDataSource,UITableViewDelegate,CreditReportingPersonInformationDelegate>

@end
@implementation MakeCardEntryTableView


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
    return 3;
    
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 9;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"业务种类",@"贷款金额",@"业务归属",@"指派归属",@"当前状态",@"卡邮寄地址"];
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
                              [BaseModel convertNull:self.model.loanBankName],
                              bizType,
                              [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000],
                              [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                              [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                              [BaseModel convertNull:[[BaseModel user]note:self.model.makeCardNode]],
                              [NSString stringWithFormat:@"%@-%@-%@-%@",[BaseModel convertNull:self.model.cardPostProvince],[BaseModel convertNull:self.model.cardPostCity],[BaseModel convertNull:self.model.cardPostArea],[BaseModel convertNull:self.model.cardPostAddress]]];
        
        cell.TextFidStr = rightAry[indexPath.row];
        cell.nameTextField.hidden = YES;
        cell.nameTextLabel.hidden = NO;
        return cell;
    }
    if (indexPath.section == 1) {
        static NSString *rid=@"PhotoCell";
        PhotoCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"red_card_pic"] componentsSeparatedByString:@"||"];
        if (cell.collectDataArray.count > 0) {
            cell.selectStr = @"红卡照片";
        }
        
        return cell;
    }
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"卡号";
    cell.nameText = @"请输入卡号";
    cell.nameTextField.tag = 10000;
    cell.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
    return cell;
}

-(void)ReferenceInputButton:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag - 1000 selectRowState:@"录入"];
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
    if (indexPath.section == 1) {
        float numberToRound;
        int result;
        numberToRound = ([[[BaseModel user]FindUrlWithModel:self.model ByKname:@"red_card_pic"] componentsSeparatedByString:@"||"].count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
    }
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
    if (section == 2) {
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
    if (section == 2) {
        UIView *headView = [[UIView alloc]init];
        
        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
        [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
        confirmButton.backgroundColor = MainColor;
        kViewRadius(confirmButton, 5);
        confirmButton.titleLabel.font = HGfont(18);
        [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:confirmButton];
        
        return headView;
    }
    return nil;
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"confirm"];
        
    }
}

@end
