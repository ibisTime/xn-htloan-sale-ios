//
//  DataTransferTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "DataTransferTableView.h"
#import "InformationCell.h"
#import "GPSInfomationCell.h"
#import "GPSDetailaCell.h"
#define GPSDetail @"GPSDetailaCell"

#define Information @"InformationCell"
#define GPSInformation @"GPSInfomationCell"

@interface DataTransferTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation DataTransferTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[InformationCell class] forCellReuseIdentifier:Information];
        [self registerClass:[GPSInfomationCell class] forCellReuseIdentifier:GPSInformation];
        [self registerClass:[GPSDetailaCell class] forCellReuseIdentifier:GPSDetail];

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
    return self.model.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    if (self.isGps == YES) {
       
        if (self.isDetail == YES) {
            
                
                GPSDetailaCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
                if (cell == nil) {
                    cell = [[GPSDetailaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GPSDetail];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                DataTransferModel *model = self.model[indexPath.row];
                cell.dataTransferModel = model;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if ([model.status  isEqualToString:@"0"] ||[model.status  isEqualToString:@"3"]) {
                    cell.button.hidden = YES;
                }else if ([model.status  isEqualToString:@"1"])
                {
                    
                    cell.button.hidden = YES;
//                    [cell.button setTitle:@"收件" forState:(UIControlStateNormal)];
                }
                else
                {
                    
                    
                    cell.button.hidden = YES;
                }
                [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
                cell.button.tag = indexPath.row;
                return cell;
           
        }
        
            GPSInfomationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (cell == nil) {
                cell = [[GPSInfomationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GPSInformation];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            DataTransferModel *model = self.model[indexPath.row];
            cell.dataTransferModel = model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        if ([model.status  isEqualToString:@"0"] ||[model.status  isEqualToString:@"3"]) {
            cell.button.hidden = YES;
//            [cell.button setTitle:@"发件" forState:(UIControlStateNormal)];
        }else if ([model.status  isEqualToString:@"1"])
        {
            
            cell.button.hidden = NO;
            [cell.button setTitle:@"收件" forState:(UIControlStateNormal)];
        }
        else
        {
            
            
            cell.button.hidden = YES;
        }
        [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.button.tag = indexPath.row;
        return cell;
    }else{
        InformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[InformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        DataTransferModel *model = self.model[indexPath.row];
        cell.dataTransferModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([model.status  isEqualToString:@"0"] ||[model.status  isEqualToString:@"3"]) {
            cell.button.hidden = NO;
            [cell.button setTitle:@"发件" forState:(UIControlStateNormal)];
        }else if ([model.status  isEqualToString:@"1"])
        {
            cell.button.hidden = NO;
            [cell.button setTitle:@"收件" forState:(UIControlStateNormal)];
            
        }
        else
        {
          
            
            cell.button.hidden = YES;
        }
        [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.button.tag = indexPath.row;
        return cell;
    }
    

}

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
    DataTransferModel *model = self.model[indexPath.row];
    if (self.isGps == YES) {
        if (self.isDetail == YES) {
            return 330+60+60+60+60+30;
            
        }
        if ([model.status  isEqualToString:@"0"] || [model.status  isEqualToString:@"1"] || [model.status  isEqualToString:@"3"]) {
            return 330+60+90+30;
        }else
        {
            return 280+60+90+60;
        }
       
    }else{
//        if ([model.status  isEqualToString:@"1"] ) {
            return 330+60+90;
//        }else
//        {
//            return 290+60+90;
//        }

    }
    

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
