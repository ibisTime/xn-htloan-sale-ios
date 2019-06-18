//
//  BeyondListTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BeyondListTableView.h"
#import "GreenlistCell.h"
@implementation BeyondListTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.models.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    GreenlistCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[GreenlistCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    ListModel * model = self.models[indexPath.section];
    
    cell.LeftTitle =  @[@"业务编号",
                        @"贷款人",
                        @"期数",
                        @"逾期期数",
                        @"逾期金额",
                        @"逾期日期"];
    
    cell.RightTitle = @[model.code,
                        [BaseModel convertNull: model.user[@"realName"]],
                        [BaseModel convertNull:[[BaseModel user]setParentKey:@"loan_period" setDkey:[NSString stringWithFormat:@"%@",model.periods]]],
                        [BaseModel convertNull:model.curPeriods],
                        [NSString stringWithFormat:@"%.2f",[model.overdueAmount floatValue]/1000],
                        [model.repayDatetime convertDate]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.button.hidden = YES;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}
@end
