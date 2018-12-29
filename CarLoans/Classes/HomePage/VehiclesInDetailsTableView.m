//
//  VehiclesInDetailsTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "VehiclesInDetailsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "SurverCertificateCell.h"
#define SurverCertificate @"SurverCertificateCell"

@interface VehiclesInDetailsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation VehiclesInDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[SurverCertificateCell class] forCellReuseIdentifier:SurverCertificate];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"客户姓名",@"业务编号",@"贷款银行",@"贷款金额",@"落户时间"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_model.applyUserName],
                                  [NSString stringWithFormat:@"%@",_model.code],
                                  [NSString stringWithFormat:@"%@",_model.loanBankName],
                                  [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",[_model.carSettleDatetime convertDate]]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    SurverCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:SurverCertificate forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *array = @[@"发票",@"合格证",@"交强险",@"商业险",@"其他资料"];
    cell.name = array[indexPath.row];
    switch (indexPath.row) {
        case 0:
        {
            cell.picArray = _model.pics1;
        }
            break;
        case 1:
        {
            cell.picArray = _model.pics2;
        }
            break;
        case 2:
        {
            cell.picArray = _model.pics3;
        }
            break;
        case 3:
        {
            cell.picArray = _model.pics4;
        }
            break;
        case 4:
        {
            cell.picArray = _model.pics5;
        }
            break;

        default:
            break;
    }
    return cell;


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
    float numberToRound;
    int result;
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                numberToRound = (_model.pics1.count)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
            }
                break;
            case 1:
            {
                numberToRound = (_model.pics2.count)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
            }
                break;
            case 2:
            {
                numberToRound = (_model.pics3.count)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
            }
                break;
            case 3:
            {
                numberToRound = (_model.pics4.count)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
            }
                break;
            case 4:
            {
                numberToRound = (_model.pics5.count)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
            }
                break;

            default:
                break;
        }
    }
    return 50;
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
