//
//  WaterTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/11.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "WaterTableView.h"
#import "TextFieldCell.h"
#import "CollectionViewCell.h"
@implementation WaterTableView
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
        return [TopModel user].newWaterAry.count;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *rid=@"cell";
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = [TopModel user].newWaterAry[indexPath.row];
        NSString * type;
        if ([_waterDic[@"type"] isEqualToString:@"1"]) {
            type = @"微信";
        }else if ([_waterDic[@"type"] isEqualToString:@"2"])
        {
            type = @"支付宝";
        }else
        {
            type = @"银行";
        }
        NSArray * array = @[_waterDic[@"creditUser"][@"userName"],
                            type,
                            [_waterDic[@"datetimeStart"] convertDate],
                            [_waterDic[@"datetimeEnd"] convertDate],
                            [[BaseModel user] setParentKey:@"interest" setDkey:[NSString stringWithFormat:@"%@",_waterDic[@"jourInterest1"]]],
                            [[BaseModel user] setParentKey:@"interest" setDkey:[NSString stringWithFormat:@"%@",_waterDic[@"jourInterest2"]]],
                            [NSString stringWithFormat:@"%.2f",[_waterDic[@"interest1"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[_waterDic[@"interest2"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[_waterDic[@"income"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[_waterDic[@"expend"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[_waterDic[@"monthIncome"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[_waterDic[@"monthExpend"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[_waterDic[@"balance"] floatValue]/1000],
                            _waterDic[@"remark"]];
        cell.TextFidStr = array[indexPath.row];
        return cell;
    }
    static NSString *CellIdentifier = @"CollectionViewCell";
    CollectionViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[CollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
//    cell.delegate = self;
    cell.isEditor = NO;
    cell.collectDataArray = [self.waterDic[@"pic"] componentsSeparatedByString:@"||"];
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 50;
    }
    float numberToRound;
    int result;
    numberToRound = ([self.waterDic[@"pic"] componentsSeparatedByString:@"||"].count + 1.0)/3.0;
    result = (int)ceilf(numberToRound);
    return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = @"*流水图片";
        [headView addSubview:nameLbl];
        return headView;
    }
    return nil;
}
@end
