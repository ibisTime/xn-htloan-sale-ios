//
//  CheckGPSTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckGPSTableView.h"
#import "CarGounpCell.h"
#define CarGounp @"CarGounpCell"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "UploadVideoCell.h"
#define UploadVideo @"UploadVideoCell"
#import "CarSettledUpdataPhotoCell.h"
#define CellIdentifier @"CarSettledUpdataPhotoCell"

@interface CheckGPSTableView ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate1,CarSettledUpdataPhotoDelegate>

@end
@implementation CheckGPSTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        [self registerClass:[CarSettledUpdataPhotoCell class] forCellReuseIdentifier:CellIdentifier];
        [self registerClass:[CarGounpCell class] forCellReuseIdentifier:CarGounp];
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (section == 3) {
    //        return 2;
    //    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = self.peopleAray;
    if (indexPath.section == 0) {
//        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.name = @"GPS设备号";
//        cell.detailsLabel.tag = 103;
//        cell.details = self.GPS;
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"GPS设备号";
        cell.nameText = [NSString stringWithFormat:@"%@",dic[@"gpsDevNo"]];
        cell.nameTextField.enabled = NO;
        return cell;
    }
    if (indexPath.section == 1) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"GPS类型";
        
        cell.nameText = [NSString stringWithFormat:@"%@",[dic[@"gpsType"]isEqualToString:@"1"]?@"有线":@"无线"];
        cell.nameTextField.enabled = NO;
        //        cell.nameTextField.tag = 100;
        //        if (self.isSelect >= 100) {
        //            cell.TextFidStr = self.Str1;
        //        }
        return cell;
    }
    if (indexPath.section == 2) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"安装位置";
        cell.nameText = [NSString stringWithFormat:@"%@",dic[@"azLocation"]];
        cell.nameTextField.enabled = NO;
//        cell.nameTextField.tag = 100;
//        if (self.isSelect >= 100) {
//            cell.TextFidStr = self.Str1;
//        }
        return cell;
    }
    if (indexPath.section ==3) {
//        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.name = @"安装时间";
//        cell.details = self.date;
//        cell.detailsLabel.tag = 104;
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"安装时间";
        
        cell.nameText = [NSString stringWithFormat:@"%@",[dic[@"azDatetime"] convertDate]];
        cell.nameTextField.enabled = NO;
        return cell;
    }
    if (indexPath.section == 4 ){
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"安装人员";
        cell.nameText = [NSString stringWithFormat:@"%@",dic[@"azUser"]];
        cell.nameTextField.enabled = NO;
        return cell;
    }if (indexPath.section == 5) {

        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"备注";
        cell.nameText = [NSString stringWithFormat:@"%@",dic[@"remark"]];
        cell.nameTextField.enabled = NO;
        return cell;
    }
    
    
    if (indexPath.section == 6) {
        CarGounpCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[CarGounpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarGounp];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
//        self.BankPicArray  = [NSArray arrayWithObjects:dic[@"devPhotos"], nil];
        self.BankPicArray = [dic[@"devPhotos"] componentsSeparatedByString:@"||"];
        cell.collectDataArray = self.BankPicArray;
        cell.selectButton.hidden = YES;
        return cell;
        
    }
    if (indexPath.section == 7) {
        CarGounpCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[CarGounpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CarGounp];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        self.CompanyPicArray = [dic[@"azPhotos"] componentsSeparatedByString:@"||"];
        cell.collectDataArray = self.CompanyPicArray;
        cell.photoBtn.tag = indexPath.section;
        cell.selectButton.hidden = YES;
        return cell;
    }else{
        
        return nil;
    }
    
}

-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:[str intValue] selectRowState:@"add"];
    }
}

-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:[str integerValue] selectRowState:@"delete"];
    }
}

-(void)CarSettledUpdataPhotoBtn:(UIButton *)sender selectStr:(NSString *)Str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:[Str integerValue] selectRowState:@"add"];
    }
}

//确认
-(void)confirmButtonClick:(UIButton *)sender
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
    if (indexPath.section == 6 || indexPath.section == 7) {
        if (indexPath.section == 6) {
            float numberToRound;
            int result;
            
            numberToRound = (_BankPicArray.count + 1.0)/4.0;
            result = (int)ceilf(numberToRound);
            NSLog(@"roundf(%.2f) = %d", numberToRound, result);
            return result * ((SCREEN_WIDTH - 20) / 4 + 5) + 10;
        }else
        {
            float numberToRound;
            int result;
            
            numberToRound = (_CompanyPicArray.count + 1.0)/4.0;
            result = (int)ceilf(numberToRound);
            NSLog(@"roundf(%.2f) = %d", numberToRound, result);
            return result * ((SCREEN_WIDTH - 20) / 4 + 5) + 10;
        }
        
    }else{
        return 50;
        
    }
//    if (indexPath.section == 5 || indexPath.section == 6) {
//        return 130;
//    }else{
//        return 50;
//
//    }
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 6 || section == 7) {
        return 50;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 7) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *array = @[@"设备图片",@"安装图片"];
    
    if (section == 6) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[0];
        [headView addSubview:nameLabel];
        return headView;
        
    }
    else if (section == 7) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[1];
        [headView addSubview:nameLabel];
        return headView;
        
    }else{
        
        return nil;
    }
    
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section == 6) {
//        UIView *headView = [[UIView alloc]init];
//        
//        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
//        [confirmButton setTitle:@"确定" forState:(UIControlStateNormal)];
//        confirmButton.backgroundColor = MainColor;
//        kViewRadius(confirmButton, 5);
//        confirmButton.titleLabel.font = HGfont(18);
//        [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
//        [headView addSubview:confirmButton];
//        
//        return headView;
//    }
//    return nil;
//}
@end

