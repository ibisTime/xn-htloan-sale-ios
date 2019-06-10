//
//  GPSDetailsTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/29.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "GPSDetailsTableView.h"
#import "TextFieldCell.h"
#import "GPSCell.h"
@implementation GPSDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if ([self.model.sendType isEqualToString:@"1"]) {
            return 7;
        }else if ([self.model.sendType isEqualToString:@"2"]){
            return 9;
        }
        return 7;
    }
    if (self.array.count == 0) {
        return 0;
    }
    return self.array.count + 1;
    
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
    if (indexPath.section == 0) {
        static NSString *rid=@"cell";
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray * namearray = [NSArray array];
        NSArray * infoarray = [NSArray array];
        if ([self.model.sendType isEqualToString:@"2"]) {
            namearray = @[@"业务编号",@"发件人",@"收件人",@"业务团队",@"发件方式",@"快递公司",@"快递单号",@"发件时间",@"发件说明"];
            NSString  * str;
            if ([self.model.sendType isEqualToString:@"1"]) {
                str = @"线下";
            }
            else if ([self.model.sendType isEqualToString:@"2"]){
                str = @"快递";
            }
            else
                str = @"暂未发件";
            infoarray = @[
                          [BaseModel convertNull:self.model.bizCode],
                          [BaseModel convertNull:self.model.senderName],
                          [BaseModel convertNull:self.model.receiverName],
                          [BaseModel convertNull:self.model.teamName],
                          str,
                          [NSString stringWithFormat:@"%@", [[BaseModel user] setParentKey:@"kd_company" setDkey:self.model.logisticsCompany]],
                          [BaseModel convertNull:self.model.logisticsCode],
                          [BaseModel convertNull:[self.model.sendDatetime convertDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]],
                          [BaseModel convertNull:self.model.sendNote]
                          ];
        }
        else if ([self.model.sendType isEqualToString:@"1"]) {
            namearray = @[@"业务编号",@"发件人",@"收件人",@"业务团队",@"发件方式",@"发件时间",@"发件说明"];
            NSString  * str;
            if ([self.model.sendType isEqualToString:@"1"]) {
                str = @"线下";
            }
            else if ([self.model.sendType isEqualToString:@"2"]){
                str = @"快递";
            }
            else
                str = @"暂未发件";
            infoarray = @[
                          [BaseModel convertNull:self.model.bizCode],
                          [BaseModel convertNull:self.model.senderName],
                          [BaseModel convertNull:self.model.receiverName],
                          [BaseModel convertNull:self.model.teamName],
                          str,
                          [BaseModel convertNull:[self.model.sendDatetime convertDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]],
                          [BaseModel convertNull:self.model.sendNote]
                          ];
        }else{
            namearray = @[@"业务编号",@"发件人",@"收件人",@"业务团队",@"发件方式",@"发件时间",@"发件说明"];
            NSString  * str;
            if ([self.model.sendType isEqualToString:@"1"]) {
                str = @"线下";
            }
            else if ([self.model.sendType isEqualToString:@"2"]){
                str = @"快递";
            }
            else
                str = @"暂未发件";
            infoarray = @[
                          [BaseModel convertNull:self.model.bizCode],
                          [BaseModel convertNull:self.model.senderName],
                          [BaseModel convertNull:self.model.receiverName],
                          [BaseModel convertNull:self.model.teamName],
                          str,
                          [BaseModel convertNull:[self.model.sendDatetime convertDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]],
                          [BaseModel convertNull:self.model.sendNote]
                          ];
        }
        
        cell.name = namearray[indexPath.row];
        cell.TextFidStr = infoarray[indexPath.row];
        cell.isInput = @"0";
        return cell;
    }
    if (indexPath.row == 0) {
        static NSString *rid=@"GPSCell";
        GPSCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[GPSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.rightarray = @[@"GPS类型",@"GPS设备号"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *rid=@"GPSCell1";
    GPSCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[GPSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.rightarray = @[
                        [[BaseModel convertNull:self.array[indexPath.row - 1][@"gpsType"]]isEqualToString:@"1"]?@"有线":@"无线",
                        [BaseModel convertNull:self.array[indexPath.row - 1][@"gpsDevNo"]]
                        ];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}
@end
