//
//  CheckTableView1.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckTableView1.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
@implementation CheckTableView1

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
        
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 8) {
        TextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务种类",@"业务归属",@"指派归属",@"当前状态"];
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
                              [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000],
                              bizType,
                              [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                              [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                              [BaseModel convertNull:[[BaseModel user]note:self.model.fbhgpsNode]]];
        
        cell.TextFidStr = rightAry[indexPath.row];
        cell.nameTextField.hidden = YES;
        cell.nameTextLabel.hidden = NO;
        return cell;
    }
    InputBoxCell * cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.state isEqualToString:@"制单回录"]) {
        cell.name = @"垫资说明";
        cell.nameText = @"请输入垫资说明";
    }else{
        cell.name = @"审核意见";
        cell.nameText = @"请输入审核意见";
    }
    
    cell.symbolLabel.hidden = YES;
    cell.tag = 400;
    return cell;
}

@end
