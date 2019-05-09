//
//  CheckInstallationTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckInstallationTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"

#define SurveyPeople @"SurveyPeopleTableViewCell"
#import "GPSInformationListCell.h"
#define GPSInformationList @"GPSInformationListCell"
#import "AddGPSPeopleCell.h"
#define AddGPSPeople @"AddGPSPeopleCell"

#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
@implementation CheckInstallationTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[SurveyPeopleTableViewCell class] forCellReuseIdentifier:SurveyPeople];
        [self registerClass:[GPSInformationListCell class] forCellReuseIdentifier:GPSInformationList];
        [self registerClass:[AddGPSPeopleCell class] forCellReuseIdentifier:AddGPSPeople];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
        
        
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
        return 8;
    }
    if (section == 2) {
        return 1;
    }
    return _peopleAray.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务归属",@"指派归属",@"当前状态"];
        NSString *bizType;
        if ([self.model.bizType integerValue] == 0) {
            bizType = @"新车";
        }
        else
        {
            bizType = @"二手车";
        }
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSDictionary * dic = _model.creditUserList[0];
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@", _model.code],
                                  [NSString stringWithFormat:@"%@", dic[@"userName"]],
                                  [NSString stringWithFormat:@"%@", _model.loanBankName],
                                  [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",bizType],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                                  [BaseModel convertNull:[[BaseModel user]note:self.model.curNodeCode]]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    
    if (indexPath.section == 1) {
        GPSInformationListCell *cell = [tableView dequeueReusableCellWithIdentifier:GPSInformationList forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.Dicionary = _peopleAray[indexPath.row];
        [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.deleteBtn.tag = indexPath.row;
        return cell;
    }
    InputBoxCell * cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"审核意见";
    cell.nameText = @"请输入审核意见";
    cell.symbolLabel.hidden = YES;
    cell.tag = 400;
//    AddGPSPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:AddGPSPeople forIndexPath:indexPath];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)deleteBtnClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@""];
    }
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
    if (indexPath.section == 1) {
        
        return 145;
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 50;
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
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        
        UILabel *headLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:[UIColor blackColor]];
        headLabel.text = @"GPS";
        [backView addSubview:headLabel];
        
        return headView;
    }
    return nil;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section == 1) {
//        UIView *headView = [[UIView alloc]init];
//
//        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
//        [confirmButton setTitle:@"确定" forState:(UIControlStateNormal)];
//        confirmButton.backgroundColor = MainColor;
//        kViewRadius(confirmButton, 5);
//        confirmButton.titleLabel.font = HGfont(18);
//        [confirmButton addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
//        confirmButton.tag = 100;
//        [headView addSubview:confirmButton];
//
//        return headView;
//    }
//    return nil;
//}

@end
