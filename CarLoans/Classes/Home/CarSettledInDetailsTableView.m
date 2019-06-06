//
//  CarSettledInDetailsTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarSettledInDetailsTableView.h"

#import "ChooseCell.h"
#define ChooseC @"ChooseCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"

@interface CarSettledInDetailsTableView ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>

@end

@implementation CarSettledInDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
        _date = @"";
        _date1 = @"";
        _date2 = @"";
        _date3 = @"";

    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 4;
    }
    if (section == 1) {
        return 4;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"客户姓名",@"业务编号",@"贷款银行",@"贷款金额"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                [NSString stringWithFormat:@"%@",_model.applyUserName],
                [NSString stringWithFormat:@"%@",_model.code],
                [NSString stringWithFormat:@"%@",_model.loanBankName],
                [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *array = @[@"保单日期",@"保单到期日",@"落户日期",@"抵押日期"];
        cell.name = array[indexPath.row];
        NSArray *datArray = @[_date,_date1,_date2,_date3];
        cell.details = datArray[indexPath.row];
        return cell;
    }
    CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    switch (indexPath.section) {
        case 2:
        {
            cell.collectDataArray = self.invoiceArray;
            cell.selectStr = @"1";
        }
            break;
        case 3:
        {
            cell.collectDataArray = self.insuranceArray;
            cell.selectStr = @"2";
        }
            break;
        case 4:
        {
            cell.collectDataArray = self.BusinessRisksArray;
            cell.selectStr = @"3";
        }
            break;
        case 5:
        {
            cell.collectDataArray = self.otherArray;
            cell.selectStr = @"4";
        }
            break;
        case 6:
        {
            cell.collectDataArray = self.greenDataArray;
            cell.selectStr = @"5";
        }
            break;

        default:
            break;
    }

    return cell;

}

-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{

    if ([str isEqualToString:@"1"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:1 selectRowState:@"add"];

        }
    }else if([str isEqualToString:@"2"])
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:2 selectRowState:@"add"];

        }
    }else if([str isEqualToString:@"3"])
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:3 selectRowState:@"add"];

        }
    }else if([str isEqualToString:@"4"])
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:4 selectRowState:@"add"];

        }
        
    }else if([str isEqualToString:@"5"])
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:5 selectRowState:@"add"];
            
        }
    }

}


//删除
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    if ([str isEqualToString:@"1"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos1"];
        }
    }else if ([str isEqualToString:@"2"])
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos2"];

        }
    }else if ([str isEqualToString:@"3"])
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos3"];

        }
    }else if ([str isEqualToString:@"4"])
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos4"];

        }
    }else if ([str isEqualToString:@"5"])
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos5"];
            
        }
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

    switch (indexPath.section) {
        case 0:
        {
            return 50;
        }
            break;
        case 1:
        {
            return 50;
        }
            break;
        case 2:
        {
            float numberToRound;
            int result;
            numberToRound = (_invoiceArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;

        case 3:
        {
            float numberToRound;
            int result;
            numberToRound = (_insuranceArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 4:
        {
            float numberToRound;
            int result;
            numberToRound = (_BusinessRisksArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 5:
        {
            float numberToRound;
            int result;
            numberToRound = (_otherArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
        case 6:
        {
            float numberToRound;
            int result;
            numberToRound = (_greenDataArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;

        default:
            break;
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 3 || section == 4 || section == 5|| section == 6) {
        return 50;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 6) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 3 || section == 4 || section == 5|| section == 6) {
        UIView *headView = [[UIView alloc]init];

        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];

        NSArray *array = @[@"发票",@"交强险",@"商业险",@"其他资料",@"绿大本"];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section - 2];
        [headView addSubview:nameLabel];

        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if (section == 6) {
        UIView *headView = [[UIView alloc]init];

        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
        [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
        confirmButton.backgroundColor = MainColor;
        kViewRadius(confirmButton, 5);
        confirmButton.titleLabel.font = HGfont(18);
        [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:confirmButton];

        return headView;
    }

    return nil;
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"confirm"];

    }
}

@end
