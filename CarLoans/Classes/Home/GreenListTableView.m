//
//  GreenListTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "GreenListTableView.h"
#import "GreenlistCell.h"
@implementation GreenListTableView

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
    cell.RightTitle = @[model.code,
                        model.user[@"realName"],
                        [model.repayDatetime convertDate],
                        model.totalFee,
                        model.payedFee,
                        model.overdueDeposit];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.button.hidden = NO;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 280;
}
@end
