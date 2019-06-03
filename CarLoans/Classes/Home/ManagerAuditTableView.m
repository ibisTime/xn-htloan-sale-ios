//
//  ManagerAuditTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ManagerAuditTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "RepayPlanCell.h"
#import "PhotoCell.h"
@implementation ManagerAuditTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 11;
    }
    if (section == 1) {
        return self.model.repayPlanList.count + 1;
    }
    return 6;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *rid=TextField;
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"贷款人",@"手机号",@"身份证号",@"贷款金额(元)",@"是否提前还款",@"总期数",@"剩余期数",@"逾期金额",@"剩余欠款",@"未还清收成本",@"未还代偿款"];
        cell.name = nameArray[indexPath.row];
        NSArray * textarray = @[[NSString stringWithFormat:@"%@",self.model.realName],
                                [NSString stringWithFormat:@"%@",self.model.user[@"mobile"]],
                                [NSString stringWithFormat:@"%@",self.model.user[@"idNo"]],
                                [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000],
                                [self.model.isAdvanceSettled isEqualToString:@"1"]?@"是":@"否",
                                [NSString stringWithFormat:@"%@",self.model.periods],
                                [NSString stringWithFormat:@"%@",self.model.restPeriods],
                                [NSString stringWithFormat:@"%@",self.model.overdueAmount],
                                [NSString stringWithFormat:@"%.2f",[self.model.restAmount floatValue]/1000 ],
                                [NSString stringWithFormat:@"%.2f",[self.model.restTotalCost floatValue]/1000 ],
                                [NSString stringWithFormat:@"%.2f",[self.model.unRepayTotalAmount floatValue]/1000 ],
                                ];
        
        cell.text = textarray[indexPath.row];
        cell.nameTextField.hidden = YES;
        cell.nameTextLabel.hidden = NO;
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *rid=@"cell";
            RepayPlanCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[RepayPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
            }
            cell.rightarray = @[@"期数",@"还款日期",@"应还本息",@"实还金额",@"逾期金额",@"剩余欠款"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        static NSString *rid=@"cell1";
        RepayPlanCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[RepayPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.rightarray = @[[NSString stringWithFormat:@"%@",self.model.repayPlanList[indexPath.row - 1][@"curPeriods"]],
                            [NSString stringWithFormat:@"%@",[self.model.repayPlanList[indexPath.row - 1][@"repayDatetime"] convertDate]],
                            [NSString stringWithFormat:@"%.2f",[self.model.repayPlanList[indexPath.row - 1][@"repayCapital"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.repayPlanList[indexPath.row - 1][@"realRepayAmount"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.repayPlanList[indexPath.row - 1][@"overdueAmount"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.repayPlanList[indexPath.row - 1][@"overplusAmount"] floatValue]/1000]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row == 4) {
        static NSString *rid=@"photo";
        PhotoCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.collectDataArray = [self.model.settleAttach componentsSeparatedByString:@"||"];
        cell.selectStr = @"结清证明";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *rid=TextField;
    TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"可退押金金额",@"扣除违约金额",@"实际退款金额",@"结清时间",@"",@"审核意见"];
    cell.name = nameArray[indexPath.row];
    NSArray * textarray = @[[NSString stringWithFormat:@"%.2f", [self.model.retreatDeposit floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f", [self.model.cutLyDeposit floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f", ([self.model.retreatDeposit floatValue]/1000)-([self.model.cutLyDeposit floatValue]/1000)],
                            [self.model.settleDatetime convertDate],
                            @"",
                            @""];
    
    cell.text = textarray[indexPath.row];
    cell.nameTextField.tag = 100000 + indexPath.row;
    if (indexPath.row == 5) {
        cell.nameTextField.hidden = NO;
        cell.nameTextLabel.hidden = YES;
        cell.nameTextField.placeholder = @"请输入审核意见";
    }else{
        cell.nameTextField.hidden = YES;
        cell.nameTextLabel.hidden = NO;
        
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 4) {
            NSArray * array = [self.model.settleAttach componentsSeparatedByString:@"||"];;
            float numberToRound;
            int result;
            numberToRound = (array.count)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
        }
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 70;
    }
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        UIView *headView = [[UIView alloc]init];
        
        
        UIButton *initiateButton = [UIButton buttonWithTitle:@"通过" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
        initiateButton.frame = CGRectMake(15, 15, SCREEN_WIDTH/2 - 30, 50);
        kViewRadius(initiateButton, 5);
        [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        initiateButton.tag = 100;
        [headView addSubview:initiateButton];
        
        
                UIButton *saveButton = [UIButton buttonWithTitle:@"不通过" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
                saveButton.frame = CGRectMake(SCREEN_WIDTH/2 + 15, 15, SCREEN_WIDTH/2 - 30, 50);
                kViewRadius(saveButton, 5);
                [saveButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
                saveButton.tag = 101;
                [headView addSubview:saveButton];
        
        return headView;
    }
    return [UIView new];
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    UITextField * text = [self viewWithTag:100000];
    UITextField * text1 = [self viewWithTag:100001];
    UITextField * text2 = [self viewWithTag:100002];
    //    UITextField * text3 = [self viewWithTag:100003];
    text2.text =[NSString stringWithFormat:@"%.2f", [text.text floatValue] - [text1.text floatValue]];
}
-(void)confirmButtonClick:(UIButton *)sender{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"click"];
    }
}
@end
