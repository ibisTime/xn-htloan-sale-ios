//
//  BankResultTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BankResultTableView.h"
#import "TextFieldCell.h"
#import "TongDunCell.h"
@interface BankResultTableView(){
    TongDunCell * _cell;
}
@end
@implementation BankResultTableView

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
    return 12;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 11) {
        static NSString *rid=@"TongDunCell";
        TongDunCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TongDunCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        _cell = cell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.title =[BaseModel convertNull:self.dataDic[@"note"]];
        [cell.label sizeToFit];
        cell.label.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, cell.label.height + 25);
        return cell;
    }
    
    
    static NSString *rid=@"cell";
    TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"姓名",@"与借款人关系",@"贷款角色",@"手机号",@"身份证号",@"风险筛查结果",@"贷款逾期记录",@"信用卡逾期记录",@"工行专项卡分期笔数",@"未结清余额",@"状态"];
    cell.name = nameArray[indexPath.row];
    cell.isInput = @"0";
    NSArray *detailsArray = @[
                              [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.dataDic[@"userName"]]],
                              [BaseModel convertNull:[[BaseModel user] setParentKey:@"credit_user_relation" setDkey:self.dataDic[@"relation"]]],
                              [BaseModel convertNull:[[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:self.dataDic[@"loanRole"]]],
                              [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.dataDic[@"mobile"]]],
                              [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.dataDic[@"idNo"]]],
                              [BaseModel convertNull:[self.dataDic[@"result"] isEqualToString:@"001"]?@"通过":[self.dataDic[@"result"] isEqualToString:@"003"]?@"不通过":@"退回"],
                              [BaseModel convertNull:self.dataDic[@"loanCrdt"]],
                              [BaseModel convertNull:self.dataDic[@"cardCrdt"]],
                              [BaseModel convertNull:[NSString stringWithFormat:@"%@", self.dataDic[@"leftNum"]]],
                              [BaseModel convertNull:[NSString stringWithFormat:@"%@", self.dataDic[@"leftAmount"]]],
                              [BaseModel convertNull:@"工行回调完成"]];
    cell.TextFidStr = detailsArray[indexPath.row];
    return cell;
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 11) {
        return _cell.label.yy;
    }
    return 50 ;
}
@end
