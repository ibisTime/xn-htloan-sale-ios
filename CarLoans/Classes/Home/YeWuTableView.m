//
//  YeWuTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/24.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "YeWuTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"

@implementation YeWuTableView

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
    return 12;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=TextField;
    TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    NSArray * array = @[@"业务编号",
                        @"客户姓名",
                        @"贷款银行",
                        @"贷款金额",
                        @"业务种类",
                        @"业务归属",
                        @"指派归属",
                        @"当前状态",
                        @"作废原因",
                        @"是否垫资",
                        @"垫资金额",
                        @"垫资时间"];
    cell.name = array[indexPath.row];
    NSString * bizType;
    if ([self.model.bizType integerValue] == 0) {
        bizType = @"新车";
    }
    else
    {
        bizType = @"二手车";
    }
    
    NSArray * infoarray = @[[NSString stringWithFormat:@"%@",self.model.code],
                            [NSString stringWithFormat:@"%@",self.model.creditUser[@"userName"]],
                             [NSString stringWithFormat:@"%@",self.model.loanBankName],
                            [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000],
                            bizType,
                            [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                            [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                            [[BaseModel user]note:self.model.cancelNodeCode],
                            [BaseModel convertNull:self.model.cancelReason],
                            [NSString stringWithFormat:@"%@",[self.model.isAdvanceFund isEqualToString:@"1"]?@"是":@"否"],
                            [NSString stringWithFormat:@"%.2f", [self.model.advance[@"advanceFundAmount"] floatValue]/1000 ],
                            [NSString stringWithFormat:@"%@",[self.model.advance[@"advanceFundDatetime"] convertDate]],
                            ];
    cell.TextFidStr = infoarray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
@end
