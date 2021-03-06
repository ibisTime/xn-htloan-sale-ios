//
//  InputLendingDetailsTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/7.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "InputLendingDetailsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
@implementation InputLendingDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
//        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        
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
    }else if (section == 1){
        return 6;
    }
    return 2;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
//        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        static NSString *rid=@"cell1";
        
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        
        if(cell==nil){
            
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务归属",@"指派归属",@"当前状态"];
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
        
        NSArray *detailsArray = @[[NSString stringWithFormat:@"%@",_model.code],
                                  [NSString stringWithFormat:@"%@",_model.creditUser[@"userName"]],
                                  [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull:self.model.loanBankName],[BaseModel convertNull:self.model.subbranchBankName]],
                                  [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000],
                                  bizType,
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                                  [BaseModel convertNull:[[BaseModel user]note:self.model.curNodeCode]]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
//        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        if (indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 5) {
            static NSString *rid=@"cell";
            
            TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            
            if(cell==nil){
                
                cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
                
            }
            switch (indexPath.row) {
                case 0:{
                    cell.name = @"*卡号";
                    NSString * str = self.model.repayCardNumber;
                    if (str.length > 0) {
                        cell.TextFidStr = str;
                    }
                    cell.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
                }
                    break;
                case 4:{
                    cell.name = @"*首期月供金额";
                    cell.nameTextField.keyboardType = UIKeyboardTypeDecimalPad;
                }
                    
                    break;
                case 5:{
                    cell.name = @"*每期月供金额";
                    cell.nameTextField.keyboardType = UIKeyboardTypeDecimalPad;
                }
                    
                    break;
                default:
                    break;
            }
//            cell.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tag = 100 + indexPath.row;
            return cell;
        }
        else{
            ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.row == 1) {
                cell.name =@"*账单还款日";
                cell.details = self.day1;
            }
            else if (indexPath.row == 2){
                cell.name = @"*银行还款日";
                cell.details = self.day2;
            }
            else{
                cell.name = @"*公司还款日";
                cell.details = self.day3;
            }
            
            return cell;
        }
       
    }
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.name = @"*放款日期";
        cell.details = self.date;
    }else{
        cell.name = @"*首期还款日期";
        cell.details = self.date1;
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
    
    return 50;
    
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    else if (section == 2){
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
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}
@end
