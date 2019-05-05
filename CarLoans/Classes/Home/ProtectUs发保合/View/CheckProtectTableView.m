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
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务归属",@"指派归属",@"当前状态"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSString *bizType;
        if ([self.model.credit[@"bizType"] integerValue] == 0) {
            bizType = @"新车";
        }
        else
        {
            bizType = @"二手车";
        }
        
        NSArray *rightAry = @[[BaseModel convertNull:self.model.code],
                              [NSString stringWithFormat:@"%@",self.model.creditUser[@"userName"]],
                              [BaseModel convertNull:self.model.loanBankName],
                              [NSString stringWithFormat:@"%.2f万",[self.model.loanAmount floatValue]/10000],
                              bizType,
                              [NSString stringWithFormat:@"%@-%@-%@",self.model.companyName,self.model.teamName,self.model.saleUserName],
                              [NSString stringWithFormat:@"%@-%@",self.model.companyName,self.model.teamName],
                              [BaseModel convertNull:[[BaseModel user]note:self.model.curNodeCode]]];
        
        cell.TextFidStr = rightAry[indexPath.row];
        
        cell.nameTextField.hidden = YES;
        cell.nameTextLabel.hidden = NO;
        return cell;
    }
    InputBoxCell * cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"审核意见";
    cell.nameText = @"请输入审核意见";
    cell.symbolLabel.hidden = YES;
    cell.tag = 400;
    return cell;
    return cell;
    
   
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
        return 8;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

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
