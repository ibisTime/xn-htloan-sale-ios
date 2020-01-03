//
//  DataDetailsTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/29.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DataDetailsTableView.h"
#import "TextFieldCell.h"
#import "CLTextFiled.h"
@implementation DataDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.model.sendType isEqualToString:@"1"]) {
        return 13;
    }
    else if ([self.model.sendType isEqualToString:@"2"]){
        return 15;
    }
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 9) {
        return self.filearray.count *45+50;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([self.model.sendType isEqualToString:@"2"]) {
        static NSString *rid=@"cell";
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray * namearray = [NSArray array];
        NSArray * infoarray = [NSArray array];
        namearray = @[@"客户姓名",@"业务编号",@"发件节点",@"收件节点",@"发件人",@"收件人",@"业务团队",@"信贷专员",@"内勤专员",@"材料清单",@"发件方式",@"快递公司",@"快递单号",@"发件时间",@"发件说明"];
        infoarray = @[[BaseModel convertNull:self.model.customerName],
                      self.model.bizCode,
                      [[BaseModel user]note:self.model.fromNodeCode],
                      [[BaseModel user]note:self.model.toNodeCode],
                      [BaseModel convertNull:self.model.senderName],
                      [BaseModel convertNull:self.model.receiverName],
                      [BaseModel convertNull:self.model.teamName],
                      [BaseModel convertNull:self.model.saleUserName],
                      [BaseModel convertNull:self.model.insideJobName],
                      @"",
                      [self.model.sendType isEqualToString:@"1"]?@"线下":@"快递",
                      [NSString stringWithFormat:@"%@", [[BaseModel user] setParentKey:@"kd_company" setDkey:self.model.logisticsCompany]],
                      [BaseModel convertNull:self.model.logisticsCode],
                      [BaseModel convertNull:[self.model.sendDatetime convertDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]],
                      [BaseModel convertNull:self.model.sendNote]
                      ];
        cell.name = namearray[indexPath.row];
        cell.TextFidStr = infoarray[indexPath.row];
        cell.isInput = @"0";
        if (indexPath.row == 9) {
            for (int i = 0; i < self.filearray.count; i++) {
                CLTextFiled *fild = [[CLTextFiled alloc] initWithFrame:CGRectMake(15, 50+i*40, SCREEN_WIDTH-30, 40) leftTitle:@"" titleWidth:10 placeholder:@""];
                fild.backgroundColor = kLineColor;
                fild.font = [UIFont systemFontOfSize:13];
                fild.contentLab.text = self.filearray[i];
                [cell addSubview:fild];
                fild.enabled = NO;
            }
        }
        return cell;
        
    }
    else if ([self.model.sendType isEqualToString:@"1"]){
        static NSString *rid=@"cell123";
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray * namearray = [NSArray array];
        NSArray * infoarray = [NSArray array];
        namearray = @[@"客户姓名",@"业务编号",@"发件节点",@"收件节点",@"发件人",@"收件人",@"业务团队",@"信贷专员",@"内勤专员",@"材料清单",@"发件方式",@"发件时间",@"发件说明"];
        infoarray = @[[BaseModel convertNull:self.model.customerName],
                      self.model.bizCode,
                      [[BaseModel user]note:self.model.fromNodeCode],
                      [[BaseModel user]note:self.model.toNodeCode],
                      [BaseModel convertNull:self.model.senderName],
                      [BaseModel convertNull:self.model.receiverName],
                      [BaseModel convertNull:self.model.teamName],
                      [BaseModel convertNull:self.model.saleUserName],
                      [BaseModel convertNull:self.model.insideJobName],
                      @"",
                      [self.model.sendType isEqualToString:@"1"]?@"线下":@"快递",
                      [BaseModel convertNull:[self.model.sendDatetime convertDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]],
                      [BaseModel convertNull:self.model.sendNote]
                      ];
        cell.name = namearray[indexPath.row];
        cell.TextFidStr = infoarray[indexPath.row];
        cell.isInput = @"0";
        if (indexPath.row == 9) {
            for (int i = 0; i < self.filearray.count; i++) {
                CLTextFiled *fild = [[CLTextFiled alloc] initWithFrame:CGRectMake(15, 50+i*40, SCREEN_WIDTH-30, 40) leftTitle:@"" titleWidth:10 placeholder:@""];
                fild.backgroundColor = kLineColor;
                fild.font = [UIFont systemFontOfSize:13];
                fild.contentLab.text = self.filearray[i];
                [cell addSubview:fild];
                fild.enabled = NO;
            }
        }
        return cell;
    }
    static NSString *rid=@"cell123098";
    TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray * namearray = [NSArray array];
    NSArray * infoarray = [NSArray array];
    namearray = @[@"客户姓名",@"业务编号",@"发件节点",@"收件节点",@"发件人",@"收件人",@"业务团队",@"信贷专员",@"内勤专员"];
    infoarray = @[[BaseModel convertNull:self.model.customerName],
                  self.model.bizCode,
                  [[BaseModel user]note:self.model.fromNodeCode],
                  [[BaseModel user]note:self.model.toNodeCode],
                  [BaseModel convertNull:self.model.senderName],
                  [BaseModel convertNull:self.model.receiverName],
                  [BaseModel convertNull:self.model.teamName],
                  [BaseModel convertNull:self.model.saleUserName],
                  [BaseModel convertNull:self.model.insideJobName]
                  ];
    cell.name = namearray[indexPath.row];
    cell.TextFidStr = infoarray[indexPath.row];
    cell.isInput = @"0";
    if (indexPath.row == 9) {
        for (int i = 0; i < self.filearray.count; i++) {
            CLTextFiled *fild = [[CLTextFiled alloc] initWithFrame:CGRectMake(15, 50+i*40, SCREEN_WIDTH-30, 40) leftTitle:@"" titleWidth:10 placeholder:@""];
            fild.backgroundColor = kLineColor;
            fild.font = [UIFont systemFontOfSize:13];
            fild.contentLab.text = self.filearray[i];
            [cell addSubview:fild];
            fild.enabled = NO;
        }
    }
    return cell;
    
    
}
@end
