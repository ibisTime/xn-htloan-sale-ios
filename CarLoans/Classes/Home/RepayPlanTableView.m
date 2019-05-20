//
//  RepayPlanTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "RepayPlanTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "RepayPlanCell.h"
@implementation RepayPlanTableView

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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return self.model.repayPlanList.count + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *rid=TextField;
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"贷款人",@"贷款金额(元)",@"期数"];
        cell.name = nameArray[indexPath.row];
        NSArray * textarray = @[[NSString stringWithFormat:@"%@",self.model.realName],
                                [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000],
                                [NSString stringWithFormat:@"%@",self.model.periods]];
        
        cell.TextFidStr = textarray[indexPath.row];
        cell.nameTextField.hidden = YES;
        cell.nameTextLabel.hidden = NO;
        return cell;
    }
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
                            [NSString stringWithFormat:@"%.2f",[self.model.repayPlanList[indexPath.row - 1][@"payedAmount"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.repayPlanList[indexPath.row - 1][@"overdueAmount"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.repayPlanList[indexPath.row - 1][@"overplusAmount"] floatValue]/1000]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
     return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
@end
