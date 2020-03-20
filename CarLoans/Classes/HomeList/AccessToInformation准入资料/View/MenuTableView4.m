//
//  MenuTableView4.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MenuTableView4.h"

#import "MenuInputCell.h"
@interface MenuTableView4 ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSString *code;
    NSMutableArray *_writeArray;
    NSInteger lastIndex;
}
@end
@implementation MenuTableView4

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        _writeArray = [NSMutableArray array];
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
    if ([self.model.bizType isEqualToString:@"1"]) {
        return [MenuModel new].menuArray4usedCar.count;
    }
    return [MenuModel new].menuArray4.count;
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
    NSArray *nameArray = [MenuModel new].menuArray4;
    if ([self.model.bizType isEqualToString:@"1"]) {
        nameArray = [MenuModel new].menuArray4usedCar;
    }
    cell.leftStr = nameArray[indexPath.row];
    cell.rightTF.tag = 4000 + indexPath.row;
    cell.rightLbl.tag = 4000 + indexPath.row;
    NSDictionary *bankLoan = self.model.bankLoan;

    if (indexPath.row == 1 || indexPath.row == 5 || indexPath.row == 13 || indexPath.row == 14 || indexPath.row == 16) {
        if (self.isDetails == YES) {
            cell.type = MenuShowType;
        }
        else
        {
            cell.type = MenuChooseType;
        }
        if (indexPath.row == 1) {
            if ([self.periods integerValue] > 0) {
                cell.rightStr = [NSString stringWithFormat:@"%ld",[self.periods integerValue]];
            }
            else
            {
                cell.rightStr = @"";
            }
        }
        if (indexPath.row == 5) {
            NSString *str;
            if ([self.isAdvanceFund isEqualToString:@"1"]) {
                str = @"是";
            }else if ([self.isAdvanceFund isEqualToString:@"0"])
            {
                str = @"否";
            }else
            {
                str = @"";
            }
            cell.rightStr = str;
        }
        if (indexPath.row == 13) {
            cell.rightStr = [BaseModel convertNull:self.wanFactor];
        }
        if (indexPath.row == 14) {
            NSString *str;
            if ([self.rateType isEqualToString:@"1"]) {
                str = @"传统";
            }else if ([self.rateType isEqualToString:@"2"])
            {
                str = @"直客";
            }else
            {
                str = @"";
            }
            cell.rightStr = str;
        }
        
        if (indexPath.row == 16) {
            NSString *str;
            if ([self.isDiscount isEqualToString:@"1"]) {
                str = @"是";
            }else if ([self.isDiscount isEqualToString:@"0"])
            {
                str = @"否";
            }else
            {
                str = @"";
            }
            cell.rightStr = str;
        }
    }else
    {
        
        cell.placStr = [NSString stringWithFormat:@"请输入%@",nameArray[indexPath.row]];
        if (self.isDetails == YES) {
            if (_writeArray.count > 0) {
                cell.rightStr = _writeArray[indexPath.row];
            }
            cell.type = MenuShowType;
        }else
        {
            if (indexPath.row == 2 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 12 || indexPath.row == 15 || indexPath.row == 18) {
                cell.type = MenuInputNotEnterType;
            }else
            {
                cell.type = MenuInputType;
            }
            
//            if ([cell.rightTF.text isEqualToString:@""]) {
//                cell.rightTF.text = _writeArray[indexPath.row];
//            }
            if (_writeArray.count > 0) {
                cell.rightStr = _writeArray[indexPath.row];
            }
        }
        cell.rightTF.delegate = self;
        
        
    }
    if (indexPath.row == 2) {
        cell.rightStr = [BaseModel Cheng100:self.bankRate];
    }
    
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 11) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rightNumberTfDidChangeOneCI:) name:UITextFieldTextDidChangeNotification object:cell.rightTF];
    }
    if (indexPath.row == 0 || indexPath.row == 11) {
//        贷款层数
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rightNumberTfDidChangeOneCI2:) name:UITextFieldTextDidChangeNotification object:cell.rightTF];
    }
    if (indexPath.row == 15) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(rightNumberTfDidChangeOneCI1:) name:UITextFieldTextDidChangeNotification object:cell.rightTF];
    }
    return cell;
}



-(void)setBankRate:(NSString *)bankRate
{
    _bankRate = bankRate;
    [_writeArray replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%.4f",[[BaseModel Cheng100:self.bankRate] floatValue]]];
    [self reloadData];
}

-(void)setModel:(SurveyModel *)model
{
    _model = model;
    NSDictionary *bankLoan = self.model.bankLoan;
    NSString *loanRatio = @"";
    if ([bankLoan[@"loanAmount"] floatValue] != 0 && [self.model.carInfo[@"invoicePrice"] floatValue] != 0) {
        
        loanRatio = [NSString stringWithFormat:@"%@",[BaseModel CHUmult1:[BaseModel Chu1000:bankLoan[@"loanAmount"]] mult2:[BaseModel Chu1000:self.model.carInfo[@"invoicePrice"]] scale:2]];
    }
    
    
    
    
//    NSDictionary *carInfo = self.model.carInfo;
    
    
    
    _writeArray = [NSMutableArray arrayWithArray:@[[BaseModel Chu1000:bankLoan[@"loanAmount"]],
                                                   @"",
                                                   [BaseModel Cheng100:self.bankRate],
                                                   [BaseModel Cheng100:bankLoan[@"totalRate"]],
                                                   @"",
                                                   @"",
                                                   [BaseModel Chu1000:bankLoan[@"monthAmount"]],
                                                   [BaseModel Chu1000:bankLoan[@"repayFirstMonthAmount"]],
                                                   [BaseModel Chu1000:bankLoan[@"openCardAmount"]],
                                                   [BaseModel Cheng100:bankLoan[@"discountRate"]],
                                                   [BaseModel Chu1000:bankLoan[@"discountAmount"]],
                                                   [BaseModel Chu1000:self.model.carInfo[@"invoicePrice"]],
                                                   loanRatio,
                                                   [BaseModel convertNull:self.wanFactor],
                                                   @"",
                                                   [BaseModel Chu1000:bankLoan[@"fee"]],
                                                   @"",
                                                   [BaseModel Chu1000:bankLoan[@"highCashAmount"]],
                                                   [BaseModel Chu1000:bankLoan[@"totalFee"]],
                                                   [BaseModel Cheng100:bankLoan[@"customerBearRate"]],
                                                   [BaseModel Cheng100:bankLoan[@"surchargeRate"]],
                                                   [BaseModel Chu1000:bankLoan[@"surchargeAmount"]],
                                                   [BaseModel convertNull:bankLoan[@"notes"]]
                                                   ]];
    [self reloadData];
    

    
    
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"630047";
    http.parameters[@"key"] = @"rebate_rate";
    http.showView = self;
    [http postWithSuccess:^(id responseObject) {
        
        NSString *rebateRate;
        if ([[BaseModel Cheng100:bankLoan[@"rebateRate"]] floatValue] == 0) {
            rebateRate = [BaseModel Cheng100:responseObject[@"data"][@"cvalue"]];
        }else
        {
            rebateRate = [BaseModel Cheng100:bankLoan[@"rebateRate"]];
        }
        
        [_writeArray replaceObjectAtIndex:4 withObject:rebateRate];
        [self reloadData];
    } failure:^(NSError *error) {
        
    }];
    
    
}


//3.对输入的文本插入到数组中
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [_writeArray replaceObjectAtIndex:textField.tag - 4000 withObject:textField.text];
}

//4.获取lastIndex
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    lastIndex = textField.tag;
    return YES;
}

-(void)rightNumberTfDidChangeOneCI:(NSNotification *)notification
{
//    UITextField *textfield=[notification object];
    [self notification];
    
}

-(void)rightNumberTfDidChangeOneCI1:(NSNotification *)notification
{
    //    UITextField *textfield=[notification object];
//    [self notification];
//    贷款金额
    UITextField *textField4000 = [self viewWithTag:4000];
//    服务费
    UITextField *textField4015 = [self viewWithTag:4015];
    //    费用总额=贷款本金+服务费
    UITextField *tf18 = [self viewWithTag:4018];
    
    tf18.text = [NSString stringWithFormat:@"%@",[BaseModel JIAmult1:textField4000.text mult2:textField4015.text scale:2]];
    [_writeArray replaceObjectAtIndex:18 withObject:[NSString stringWithFormat:@"%@",tf18.text]];
}

-(void)rightNumberTfDidChangeOneCI2:(NSNotification *)notification
{
    UITextField *textField4000 = [self viewWithTag:4000];
    UITextField *textField4011 = [self viewWithTag:4011];
    UITextField *textField4012 = [self viewWithTag:4012];
    
    textField4012.text = [NSString stringWithFormat:@"%@",[BaseModel CHUmult1:textField4000.text mult2:textField4011.text scale:2]];
    [_writeArray replaceObjectAtIndex:12 withObject:[NSString stringWithFormat:@"%@",textField4012.text]];
}


-(void)setIsLoadData:(BOOL)isLoadData
{
    [self notification];
}



-(void)notification
{
    UITextField *textField4000 = [self viewWithTag:4000];
    UITextField *textField4001 = [self viewWithTag:4001];
    UITextField *textField4002 = [self viewWithTag:4002];
    UITextField *textField4003 = [self viewWithTag:4003];
    UITextField *textField4011 = [self viewWithTag:4011];
    UITextField *textField4012 = [self viewWithTag:4012];
    UITextField *textField4015 = [self viewWithTag:4015];
    //    费用总额=贷款本金+服务费
    UITextField *tf18 = [self viewWithTag:4018];
    
    
    
    
    if (![textField4000.text isEqualToString:@""] && ![textField4001.text isEqualToString:@""] && ![textField4002.text isEqualToString:@""] && ![textField4003.text isEqualToString:@""]) {
        
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.code = @"632541";
        http.isShowMsg = NO;
        http.parameters[@"loanBankCode"] = self.model.loanBank;
        http.parameters[@"loanAmount"] = [BaseModel Cheng1000:textField4000.text];
        http.parameters[@"loanPeriods"] = textField4001.text;
        http.parameters[@"bankRate"] = [BaseModel Chu100:textField4002.text];
        http.parameters[@"totalRate"] = [BaseModel Chu100:textField4003.text];
        http.parameters[@"invoicePrice"] = [BaseModel Cheng1000:textField4011.text];
        [http postWithSuccess:^(id responseObject) {
//            月供
            UITextField *tf0 = [self viewWithTag:4006];
//            首月还款额
            UITextField *tf1 = [self viewWithTag:4007];
//            贷款乘数
//            UITextField *tf2 = [self viewWithTag:4012];
//            开卡金额
            UITextField *tf3 = [self viewWithTag:4008];
//            手续费
            UITextField *tf4 = [self viewWithTag:4015];
            tf0.text = [BaseModel Chu1000:responseObject[@"data"][@"annualAmount"]];
            tf1.text = [BaseModel Chu1000:responseObject[@"data"][@"initialAmount"]];
//            tf2.text = [BaseModel Chu1000:responseObject[@"data"][@"loanRatio"]];
            tf3.text = [BaseModel Chu1000:responseObject[@"data"][@"openCardAmount"]];
            tf4.text = [BaseModel Chu1000:responseObject[@"data"][@"poundage"]];
            
            [_writeArray replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"%@",tf0.text]];
            [_writeArray replaceObjectAtIndex:7 withObject:[NSString stringWithFormat:@"%@",tf1.text]];
            [_writeArray replaceObjectAtIndex:8 withObject:[NSString stringWithFormat:@"%@",tf3.text]];
            [_writeArray replaceObjectAtIndex:15 withObject:[NSString stringWithFormat:@"%@",tf4.text]];
            
            tf18.text = [NSString stringWithFormat:@"%@",[BaseModel JIAmult1:textField4000.text mult2:textField4015.text scale:2]];
            [_writeArray replaceObjectAtIndex:18 withObject:[NSString stringWithFormat:@"%@",tf18.text]];
        } failure:^(NSError *error) {
            
        }];
        
        
        
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
