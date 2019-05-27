//
//  CheckProtectTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/5.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckProtectTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"

@implementation CheckProtectTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
//        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
//        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
    }
    return self;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务归属",@"指派归属",@"当前状态",@"保单开始日期",@"保单到期日期"];
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
                              [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000],
                              bizType,
                              [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                              [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                              [BaseModel convertNull:[[BaseModel user]note:self.model.fbhgpsNode]],
                              [BaseModel convertNull:[self.model.carInfoRes[@"policyDatetime"] convertDate]],
                              [BaseModel convertNull:[self.model.carInfoRes[@"policyDueDate"] convertDate]]];
        
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
        if (indexPath.row == 0) {
            cell.collectDataArray = self.carInvoice;
            cell.selectStr = @"发票";
        }
        if (indexPath.row == 1) {
            cell.collectDataArray = self.carJqx;
            cell.selectStr = @"交强险";
        }
        if (indexPath.row == 2) {
            cell.collectDataArray = self.carSyx;
            cell.selectStr = @"商业险";
        }
        if (indexPath.row == 3) {
            cell.collectDataArray = self.carHgzPic;
            cell.selectStr = @"绿大本扫描件";
        }
//        cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"red_card_pic"] componentsSeparatedByString:@"||"];
//        cell.selectStr = @"红卡照片";
        return cell;
    }
    
    InputBoxCell * cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"审核意见";
    cell.nameText = @"请输入审核意见";
    cell.symbolLabel.hidden = YES;
    cell.tag = 400;
    return cell;
    
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 4;
    }
    if (section == 2) {
        return 1;
    }
        return 10;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
                float numberToRound;
                int result;
                numberToRound = (self.carInvoice.count)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
        }
        if (indexPath.row == 1) {
            float numberToRound;
            int result;
            numberToRound = (self.carJqx.count)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
        }
        if (indexPath.row == 2) {
            float numberToRound;
            int result;
            numberToRound = (self.carSyx.count)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
        }
        if (indexPath.row == 3) {
            float numberToRound;
            int result;
            numberToRound = (self.carHgzPic.count)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
        }
    }
        return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
@end
