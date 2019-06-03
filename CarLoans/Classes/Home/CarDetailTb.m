//
//  CarDetailTb.m
//  CarLoans
//
//  Created by shaojianfei on 2018/12/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//


#pragma mark - 录入抵押信息
#import "CarDetailTb.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "SurverCertificateCell.h"
#define SurverCertificate @"SurverCertificateCell"
#define SurverCertificate1 @"SurverCertificateCell"

@interface CarDetailTb ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation CarDetailTb
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[SurverCertificateCell class] forCellReuseIdentifier:SurverCertificate];
         [self registerClass:[SurverCertificateCell class] forCellReuseIdentifier:SurverCertificate1];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 9;
    }else if (section == 1)
    {
        return 1;
    }else if (section == 2)
    {
        return 4;
    }
    else if (section == 3){
        return 5;

    }else{
        return 2;
    }
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"客户姓名",@"业务编号",@"贷款银行",@"贷款金额",@"业务团队",@"区域经理",@"信贷专员",@"内勤专员",@"抵押代理人"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_model.applyUserName],
                                  [NSString stringWithFormat:@"%@",_model.code],
                                   [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull:self.model.loanBankName],[BaseModel convertNull:self.model.subbranchBankName]],
                                  [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",_model.teamName],
                                  [NSString stringWithFormat:@"%@",_model.areaName],
                                  [NSString stringWithFormat:@"%@",_model.saleUserName],
                                  [NSString stringWithFormat:@"%@",_model.insideJobName],
                                  [NSString stringWithFormat:@"%@",_model.pledgeUser],
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }else if (indexPath.section == 1)
    {
        SurverCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:SurverCertificate1 forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        NSArray *array = @[@"抵押代理人身份证复印件",@"合格证",@"交强险",@"商业险",@"其他"];
        cell.name =@"抵押代理人身份证复印件";
        cell.picArray = _model.Newpics8;
        return cell;
        
    }else if (indexPath.section ==2)
    {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"抵押地点",@"补充说明",@"审核说明",@"车牌号"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_model.pledgeAddress],
                                  [NSString stringWithFormat:@"%@",_model.supplementNote],
                                  [NSString stringWithFormat:@"%@",_model.approveNote],
                                  [NSString stringWithFormat:@"%@",_model.carNumber]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    else if (indexPath.section ==3){
        SurverCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:SurverCertificate forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *array = @[@"机动车登记证书",@"批单",@"车钥匙",@"大本扫描件",@"车辆驾驶证扫描件",@"完税证明扫描件"];
        cell.name = array[indexPath.row];
        switch (indexPath.row) {
            case 0:
            {
                cell.picArray = _model.Newpics2;
            }
                break;
            case 1:
            {
                cell.picArray = _model.Newpics3;
            }
                break;
            case 2:
            {
                cell.picArray = _model.Newpics4;
            }
                break;
            case 3:
            {
                cell.picArray = _model.Newpics5;
            }
                break;
            case 4:
            {
                cell.picArray = _model.Newpics6;
            }
                break;
            case 5:
            {
                cell.picArray = _model.Newpics7;
            }
                break;
                
            default:
                break;
        }
        return cell;
    }else{
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"提交时间",@"提交说明"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",[_model.applyDatetime convertDate]],
                                  [NSString stringWithFormat:@"%@",_model.approveNote]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
        
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
    float numberToRound;
    int result;
    if (indexPath.section == 1) {
        numberToRound = (_model.Newpics8.count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
    }
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
            {
                numberToRound = (_model.Newpics2.count)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
            }
                break;
            case 1:
            {
                numberToRound = (_model.Newpics3.count)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
            }
                break;
            case 2:
            {
                numberToRound = (_model.Newpics4.count)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
            }
                break;
            case 3:
            {
                numberToRound = (_model.Newpics5.count)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
            }
                break;
            case 4:
            {
                numberToRound = (_model.Newpics6.count)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
            }
                break;
            case 5:
            {
                numberToRound = (_model.Newpics7.count)/3.0;
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
