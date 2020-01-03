//
//  CheckRepayDetailsTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CheckRepayDetailsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
@implementation CheckRepayDetailsTableView

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
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 16;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=TextField;
    TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray * array = @[@"业务编号",@"贷款人",@"手机号",@"贷款银行",@"贷款金额(元)",@"贷款期数",@"剩余期数",@"还款日",@"月供(元)",@"剩余欠款(元)",@"未还清收总成本(元)",@"逾期金额(元)",@"累计逾期期数",@"实际逾期期数",@"放款日期",@"当前节点"];
    cell.name = array[indexPath.row];
    
    
    NSArray * infoarray = @[[BaseModel convertNull:self.model.code],
                            [BaseModel convertNull:self.model.user[@"realName"]],
                            [BaseModel convertNull:self.model.user[@"mobile"]],
                             [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull:self.model.loanBankName],[BaseModel convertNull:self.model.subbranchBankName]],
                            [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000],
                            [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.periods]],
                            [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.restPeriods]],
                            [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.monthDatetime]],
                            [NSString stringWithFormat:@"%.2f",[self.model.monthAmount floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.restAmount floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.restTotalCost floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.overdueAmount floatValue]/1000],
                            [NSString stringWithFormat:@"%@",self.model.totalOverdueCount],
                            [NSString stringWithFormat:@"%@",self.model.curOverdueCount],
                            [BaseModel convertNull:[self.model.bankFkDatetime convertDate]],
                            [[BaseModel user]note:self.model.curNodeCode]
                            ];
    cell.text = infoarray[indexPath.row];
    cell.isInput = @"0";
    return cell;
}

@end
