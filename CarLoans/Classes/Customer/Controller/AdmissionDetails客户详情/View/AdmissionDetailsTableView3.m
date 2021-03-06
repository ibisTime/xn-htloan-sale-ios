//
//  AdmissionDetailsTableView3.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView3.h"

#import "AdmissionInformationCell.h"
#import "AdmiissionDetailsIDCardCellCell.h"
#import "PhotoCell.h"
#import "SecondReportCell.h"
@interface AdmissionDetailsTableView3 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@property (nonatomic , strong)BaseModel *baseModel;
@end
@implementation AdmissionDetailsTableView3
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[AdmissionInformationCell class] forCellReuseIdentifier:@"AdmissionInformationCell"];
        
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
    if ([self.model.bizType isEqualToString:@"1"]) {
        return 37;
    }
    return 36;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 34 || indexPath.row == 35 ) {
        static NSString *CellIdentifier = @"PhotoCell";
        PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 34) {
            cell.collectDataArray =  [[self FindUrlByKname:@"car_pic"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"车辆照片";
        }
        if (indexPath.row == 35) {
            cell.collectDataArray = [[self FindUrlByKname:@"car_hgz_pic"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"合格证照片";
//            cell.backgroundColor = [UIColor redColor];
        }
        return cell;
    }
//    if (indexPath.row == 33) {
//
////        static NSString *CellIdentifier = @"PhotoCell123";
////        PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
////        if (cell == nil) {
////            cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
////            cell.selectionStyle = UITableViewCellSelectionStyleNone;
////        }
////        if (indexPath.row == 33) {
////            cell.collectDataArray =  [[self FindUrlByKname:@"second_car_report"] componentsSeparatedByString:@"||"];
////            cell.selectStr = @"二手车评估报告";
////        }
////        return cell;
//
//        NSString *rid=@"normalcell";
//        SecondReportCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
//        if(cell==nil){
//            cell=[[SecondReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.secondreport = [self FindUrlByKname:@"second_car_report"];
//        return cell;
//    }
    if (indexPath.row == 36) {
        static NSString *CellIdentifier = @"AdmiissionDetailsIDCardCellCell";
        AdmiissionDetailsIDCardCellCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        
        if (cell == nil) {
            cell = [[AdmiissionDetailsIDCardCellCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.topLbl.text = @"行驶证正反照片";
            [cell.button1 sd_setImageWithURL:[NSURL URLWithString:[[self FindUrlByKname:@"drive_license_front"] convertImageUrl]] forState:UIControlStateNormal];
            [cell.button2 sd_setImageWithURL:[NSURL URLWithString:[[self FindUrlByKname:@"drive_license_reverse"] convertImageUrl]] forState:UIControlStateNormal];
            cell.button1.tag = 100;
            cell.button2.tag = 101;
        
        return cell;
    }
    static NSString *CellIdentifier = @"Cell";
    AdmissionInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[AdmissionInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _cell = cell;
    NSArray *topArray = @[@"业务种类",
                          @"贷款期限",
                          @"银行利率",
                          @"贷款产品",
                          @"是否垫资",
                          @"是否融资",
                          @"是否安装GPS",
                          @"是否我司续保",
                          @"所属区域",
                          @"机动车销售公司",
                          @"开票单位",
                          @"开票价(元)",
                          @"市场指导价(元)",
                          @"首付金额(元)",
                          @"首付比例(%)",
                          @"贷款额(元)",
                          @"月供保证金(元)",
                          @"团队服务费(元)",
                          @"GPS费用(元)",
                          @"公证费(元)",
                          @"其他费用(元)",
                          @"油补公里数",
                          @"油补(元)",
                          @"厂家贴息",
                          @"车辆类型",
                          @"车辆品牌",
                          @"车系",
                          @"车型名称",
                          @"车辆颜色",
                          @"车架号",
                          @"发动机号",
                          @"落户地点",
                          @"上牌时间",
                          @"公里数(万)"];
    cell.topLbl.text = topArray[indexPath.row];
    
    NSArray *bottomArray = @[[BaseModel convertNull:[NSString stringWithFormat:@"%@",[self.model.bizType isEqualToString:@"1"]?@"二手车":@"新车" ]],
                             [BaseModel convertNull:[[BaseModel user]setParentKey:@"loan_period" setDkey:[NSString stringWithFormat:@"%@",self.model.loanInfo[@"periods"]]]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%@", self.model.loanInfo[@"bankRate"]]],
                             [BaseModel convertNull: self.model.loanInfo[@"loanProductName"]] ,
                             [self.model.isAdvanceFund isEqualToString:@"1"]?@"是":[self.model.isAdvanceFund isEqualToString:@"0"]?@"否":@"",
                             [self.model.isFinacing isEqualToString:@"1"]?@"是":[self.model.isAdvanceFund isEqualToString:@"0"]?@"否":@"",
                             [self.model.isGpsAz isEqualToString:@"1"]?@"是":[self.model.isGpsAz isEqualToString:@"0"]?@"否":@"",
                             [self.model.isPlatInsure isEqualToString:@"1"]?@"是":[self.model.isPlatInsure isEqualToString:@"0"]?@"否":@"",
                             [BaseModel convertNull:[[BaseModel user] setid:self.model.carInfoRes[@"region"]]],
                             [BaseModel convertNull:[[BaseModel user]setCompanyCode:self.model.carInfoRes[@"vehicleCompanyName"]]],
                             [BaseModel convertNull:self.model.carInfoRes[@"invoiceCompany"]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"invoicePrice"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.carInfoRes[@"originalPrice"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"sfAmount"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.loanInfo[@"sfRate"]]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f", [self.model.loanInfo[@"loanAmount"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"monthDeposit"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"teamFee"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"gpsFee"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"authFee"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"otherFee"] floatValue]/1000]],
                             [BaseModel convertNull:self.model.carInfoRes[@"oilSubsidyKil"]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.carInfoRes[@"oilSubsidy"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.carInfoRes[@"carDealerSubsidy"] floatValue]/1000]],
                             
                             [BaseModel convertNull: [[BaseModel user]setParentKey:@"car_type" setDkey:self.model.carInfoRes[@"carType"]]],
                             [BaseModel convertNull:self.model.carInfoRes[@"carBrandName"]],
                             [BaseModel convertNull:self.model.carInfoRes[@"carSeriesName"]],
                             [BaseModel convertNull:self.model.carInfoRes[@"carModelName"]],
                             [BaseModel convertNull:self.model.carInfoRes[@"carColor"]],
                             [BaseModel convertNull:self.model.carInfoRes[@"carFrameNo"]],
                             [BaseModel convertNull:self.model.carInfoRes[@"carEngineNo"]],
                             [BaseModel convertNull:self.model.carInfoRes[@"settleAddress"]],
                             [BaseModel convertNull:self.model.carInfoRes[@"regDate"]],
                             [BaseModel convertNull:self.model.carInfoRes[@"mile"]]];
    NSLog(@"%@-%ld",bottomArray[indexPath.row],indexPath.row);
    cell.bottomLbl.frame = CGRectMake(15, 39, SCREEN_WIDTH - 137, 14);
    cell.bottomLbl.numberOfLines = 0;
    cell.bottomLbl.text = bottomArray[indexPath.row];
    [cell.bottomLbl sizeToFit];
    return cell;
}

-(NSString *)FindUrlByKname:(NSString *)Kname{
    NSString * string;
    NSLog(@"%ld",self.model.attachments.count)
    for (int i = 0; i < self.model.attachments.count; i++) {
        if ([Kname isEqualToString:self.model.attachments[i][@"kname"]]) {
            string = self.model.attachments[i][@"url"];
        }
    }
    return string;
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
//    if (indexPath.row == 31) {
//        NSArray * array = [[self FindUrlByKname:@"car_hgz_pic"] componentsSeparatedByString:@"||"];
//        float numberToRound;
//        int result;
//        numberToRound = (array.count + 0.0)/3.0;
//        result = (int)ceilf(numberToRound);
//        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
//    }
    if (indexPath.row == 34) {
        NSArray * array = [[self FindUrlByKname:@"car_pic"] componentsSeparatedByString:@"||"];
        float numberToRound;
        int result;
        numberToRound = (array.count + 0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ) + 32;
    }
    if (indexPath.row == 35) {
        NSArray * array = [[self FindUrlByKname:@"car_hgz_pic"] componentsSeparatedByString:@"||"];
        float numberToRound;
        int result;
        numberToRound = (array.count + 0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ) + 32;
    }
    if (indexPath.row == 36) {
        NSArray * array = @[@"",@""];
        float numberToRound;
        int result;
        numberToRound = (array.count + 0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ) + 32;
    }
    return _cell.bottomLbl.yy ;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 58;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 23;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 107 - 15, 58) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = @"贷款车辆信息";
        [headView addSubview:nameLbl];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 57, SCREEN_WIDTH - 107, 1)];
        lineView.backgroundColor = kLineColor;
        [headView addSubview:lineView];
        
        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
