//
//  ImproveInformationTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ImproveInformationTableView.h"

#import "MenuInputCell.h"
@interface ImproveInformationTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation ImproveInformationTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [MenuModel new].improveInformationArray.count;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = [MenuModel new].improveInformationArray;
    cell.leftStr = nameArray[indexPath.row];
    
    NSString *nowHouseTypeStr;
    if ([self.nowHouseType isEqualToString:@"0"]) {
        nowHouseTypeStr = @"自有";
    }else if ([self.nowHouseType isEqualToString:@"1"]) {
        nowHouseTypeStr = @"租用";
    }else
    {
        nowHouseTypeStr = @"";
    }
    
    NSArray *ary = @[[BaseModel convertNull:[[BaseModel user] setParentKey:@"education" setDkey:self.education]],
                     [NSString stringWithFormat:@"%@%@%@",[BaseModel convertNull:self.nowAddressProvince],[BaseModel convertNull:self.nowAddressCity],[BaseModel convertNull:self.nowAddressArea]],
                     [BaseModel convertNull:self.nowAddress],
                     [BaseModel convertNull:self.nowAddressMobile],
                     [BaseModel convertNull:self.nowAddressDate],
                     [BaseModel convertNull:[[BaseModel user] setParentKey:@"now_address_state" setDkey:self.nowAddressState]],
                     [BaseModel convertNull:[[BaseModel user] setParentKey:@"marry_state" setDkey:self.marryState]],
                     nowHouseTypeStr,
                     [BaseModel convertNull:self.companyName],
                     [NSString stringWithFormat:@"%@%@%@",[BaseModel convertNull:self.companyProvince],[BaseModel convertNull:self.companyCity],[BaseModel convertNull:self.companyArea]],
                     [BaseModel convertNull:self.companyAddress],
                     [BaseModel convertNull:[[BaseModel user] setParentKey:@"work_company_property" setDkey:self.workCompanyProperty]],
                     [BaseModel convertNull:self.workDatetime],
                     [BaseModel convertNull:[[BaseModel user] setParentKey:@"work_profession" setDkey:self.position]],
                     [BaseModel Chu1000:self.yearIncome],
                     [BaseModel convertNull:self.presentJobYears],
                     [BaseModel convertNull:[[BaseModel user] setParentKey:@"permanent_type" setDkey:self.permanentType]],
                     [BaseModel convertNull:[[BaseModel user] setParentKey:@"jk_address" setDkey:self.cardPostAddress]],
                     ];
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 9 || indexPath.row == 11 || indexPath.row == 12 || indexPath.row == 13 || indexPath.row == 16|| indexPath.row == 17 ) {

        if (self.isDetails == YES) {
            cell.type = MenuShowType;
        }else
        {
            cell.type = MenuChooseType;
        }
        cell.rightStr = ary[indexPath.row];
    }else
    {
        if (self.isDetails == YES) {
            cell.type = MenuShowType;
            cell.rightStr = ary[indexPath.row];
        }else
        {
            cell.type = MenuInputType;
            if ([cell.rightTF.text isEqualToString:@""]) {
                cell.rightTF.text = ary[indexPath.row];
            }
            cell.placStr = [NSString stringWithFormat:@"请输入%@",nameArray[indexPath.row]];
        }
    }
    
    if (indexPath.row == 15) {
        if (![[BaseModel convertNull:self.workDatetime] isEqualToString:@""]) {
            NSString *start = [self getCurrentTimes];
            
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
//            NSDate *date = [formatter dateFromString:@"%@-00 00:00:00"];
            
            NSString *end = self.workDatetime;
            
//            NSString *end = [NSString stringWithFormat:@"%@-00 00:00:00",self.workDatetime];
            
            NSInteger time = [self dateTimeDifferenceWithStartTime:end endTime:start];
//            NSString *years = [NSString stringWithFormat:@"%ld",time/3600/24/365];
            cell.rightStr = [NSString stringWithFormat:@"%ld",time];
        }
    }
    
    
    cell.rightLbl.tag = 1000 + indexPath.row;
    cell.rightTF.tag = 1000 + indexPath.row;
    
    return cell;
}


-(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSLog(@"currentTimeString =  %@",currentTimeString);
    
    return currentTimeString;
    
}

//计算日期
-(NSInteger)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    
    NSDate *startDate =[formatter dateFromString:startTime];
    NSDate *endData = [formatter dateFromString:endTime];
    
    
    // 2.创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 3.利用日历对象比较两个时间的差值
    NSDateComponents *cmps = [calendar components:type fromDate:startDate toDate:endData options:0];
    // 4.输出结果
    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    return cmps.year;
}


//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//
//    [formatter setDateFormat:@"YYYY"];
    
    
    
//    NSString *year =
    
    
    //设置时区,这个对于时间的处理有时很重要
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//    [formatter setTimeZone:timeZone];
//
//    NSTimeInterval start = [startDate timeIntervalSince1970]*1;
//    NSTimeInterval end = [endData timeIntervalSince1970]*1;
//
//
//    //    NSDate *date = [NSDate date];
//    //    NSTimeInterval end = [nowDate timeIntervalSince1970]*1;
//    NSTimeInterval value = end - start;
//
//    int second = (int)value %60;//秒
//    int minute = ((int)value %3600)/60;
//    int house = (int)value / 3600;
//    int years = (int)value / 3600 / 30 / 365;
//    NSInteger time;//剩余时间为多少分钟
////    time = house*60*60 + minute*60 + second;
//    return years;
//}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}
#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 55;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
@end
