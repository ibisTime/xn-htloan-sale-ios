//
//  CancelTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CancelTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
@implementation CancelTableView

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
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 4) {
        static NSString *rid=TextField;
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray * array = @[@"贷款人",@"手机号",@"身份证号",@"贷款金额(元)"];
        cell.name = array[indexPath.row];
        NSArray * rightarray = @[[NSString stringWithFormat:@"%@",self.model.user[@"realName"]],
                                 [NSString stringWithFormat:@"%@",self.model.user[@"mobile"]],
                                 [NSString stringWithFormat:@"%@",self.model.user[@"idNo"]],
                                 [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000]];
        cell.TextFidStr = rightarray[indexPath.row];
        cell.nameTextField.enabled = NO;
        return cell;
    }
//    ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
    static NSString *rid=@"cell1";
    ChooseCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[ChooseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"解除日期";
    if (self.date) {
        cell.details = self.date;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
@end
