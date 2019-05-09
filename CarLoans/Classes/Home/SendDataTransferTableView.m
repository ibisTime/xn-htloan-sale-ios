//
//  SendDataTransferTableView.m
//  CarLoans
//
//  Created by shaojianfei on 2018/12/21.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SendDataTransferTableView.h"
#import "InformationCell.h"
#import "GPSInfomationCell.h"
#import "GPSDetailaCell.h"
#import "CLTextFiled.h"

#define GPSDetail @"GPSDetailaCell"

#define Information @"InformationCell"
#define GPSInformation @"GPSInfomationCell"
#import "TransferCell.h"

@interface SendDataTransferTableView()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation SendDataTransferTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[InformationCell class] forCellReuseIdentifier:Information];
        [self registerClass:[GPSInfomationCell class] forCellReuseIdentifier:GPSInformation];
        [self registerClass:[GPSDetailaCell class] forCellReuseIdentifier:GPSDetail];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isRecview == YES) {
        return 2;
    }else{
        return 1;
        
    }
    
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.model.count;
        
    }else{
        return 1;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell1";
    
    TransferCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[TransferCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        
    }
    cell.dataTransferModel = self.model[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.state isEqualToString:@"send"]) {
        if ([self.model[indexPath.row].status isEqualToString:@"0"]) {
            [cell.button setTitle:@"发件" forState:(UIControlStateNormal)];
            cell.button.frame = CGRectMake(SCREEN_WIDTH - 115, 260+20, 100, 30);
            cell.hidden = NO;
        }
        else if ([self.model[indexPath.row].status isEqualToString:@"3"]){
            [cell.button setTitle:@"补发件" forState:(UIControlStateNormal)];
            cell.button.frame = CGRectMake(SCREEN_WIDTH - 115, 330+20, 100, 30);
            cell.button.hidden = NO;
        }
        else{
            cell.button.hidden = YES;
        }
    }
    else if ([self.state isEqualToString:@"collect"]){
        if ([self.model[indexPath.row].status isEqualToString:@"1"]) {
            [cell.button setTitle:@"收件" forState:(UIControlStateNormal)];
            cell.button.frame = CGRectMake(SCREEN_WIDTH - 115, 330+60+60+20, 100, 30);
            cell.hidden = NO;
        }
        else
            cell.button.hidden = YES;
    }
    [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return cell;
}
#pragma mark -- tableView

//发件
-(void)buttonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.model[indexPath.row].status isEqualToString:@"0"] || [self.model[indexPath.row].status isEqualToString:@"1"] || [self.model[indexPath.row].status isEqualToString:@"3"]) {
        if (!self.model[indexPath.row].sendType) {
            return 330;
        }
        if ([self.model[indexPath.row].sendType isEqualToString:@"1"]) {
            return  495;
        }
        return 330+60;
    }
    else
        return 330+60+60;
    
//    DataTransferModel *model = self.model[indexPath.row];
//    if (self.isGps == YES) {
//        if (self.isDetail == YES) {
//            return 330+60+60+60+60+30;
//
//        }
//        if ([model.status  isEqualToString:@"0"] ||  [model.status  isEqualToString:@"3"]) {
//            return 330+60+90+30;
//        }else
//        {
//            return 280+60+90+60;
//        }
//
//    }else{
//        if (self.isRecview == YES) {
//            if (indexPath.section == 0) {
//                return 330+60+90;
//
//            }else{
//                return [self.model[0].filelist componentsSeparatedByString:@","].count *45+50;
//
//            }
//        }else{
//            return 330+60+90;
//
//        }
//
//    }
    
    
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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
