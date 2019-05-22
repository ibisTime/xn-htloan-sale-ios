//
//  AdmissionDetailsTableView11.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView11.h"

@interface AdmissionDetailsTableView11 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end
@implementation AdmissionDetailsTableView11
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
    
    return 15;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 8 || indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 11 || indexPath.row == 12 || indexPath.row == 13 ) {
        static NSString *CellIdentifier = @"PhotoCell";
        PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 1) {
            
            cell.collectDataArray = @[[BaseModel convertNull:[[BaseModel user]FindUrlWithModel:self.model ByKname:@"pledge_user_id_card_front"]],[BaseModel convertNull:[[BaseModel user]FindUrlWithModel:self.model ByKname:@"pledge_user_id_card_reverse"]]];
            cell.selectStr = @"抵押代理人身份证复印件";
        }
        if (indexPath.row == 8) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_regcerti"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"机动车登记证书";
        }
        if (indexPath.row == 9) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_pd"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"批单";
        }
        if (indexPath.row == 10) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_key"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"车钥匙";
        }
        if (indexPath.row == 11) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_big_smj"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"大本扫描件";
        }
        if (indexPath.row == 12) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_xsz_smj"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"车辆行驶证扫描件";
        }
        if (indexPath.row == 13) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"duty_paid_prove_smj"]componentsSeparatedByString:@"||"];
            cell.selectStr = @"完税证明扫描件";
        }
        return cell;
        
    }
    static NSString *CellIdentifier = @"Cell";
    AdmissionInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[AdmissionInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _cell = cell;
    NSArray *topArray = @[@"抵押代理人",@"",@"抵押地点",@"银行账单日",@"银行还款日",@"公司还款日",@"补充说明",@"车牌号",@"",@"",@"",@"",@"",@"",@"提交时间"];
    cell.topLbl.text = topArray[indexPath.row];
    
    NSArray *bottomArray = @[[BaseModel convertNull:self.model.carPledge[@"pledgeUser"]],
                             @"",
                             [BaseModel convertNull:self.model.carInfoRes[@"settleAddress"]],
                             [NSString stringWithFormat:@"%@",self.model.bankLoan[@"repayBillDate"]],
                             [NSString stringWithFormat:@"%@",self.model.bankLoan[@"repayBankDate"]],
                             [NSString stringWithFormat:@"%@",self.model.bankLoan[@"repayCompanyDate"]],
                             [BaseModel convertNull:self.model.carPledge[@"pledgeSupplementNote"]],
                             [BaseModel convertNull:self.model.carInfoRes[@"carNumber"]],
                             @"",
                             @"",
                             @"",
                             @"",
                             @"",
                             @"",
                             @"提交时间"];
    cell.bottomLbl.frame = CGRectMake(15, 39, SCREEN_WIDTH - 137, 14);
    cell.bottomLbl.numberOfLines = 0;
    cell.bottomLbl.text = bottomArray[indexPath.row];
    [cell.bottomLbl sizeToFit];
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
    if (indexPath.row == 1 || indexPath.row == 8 || indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 11 || indexPath.row == 12 || indexPath.row == 13 ) {
        float numberToRound;
        int result;
        numberToRound = (2.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
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
        nameLbl.text = @"车辆抵押";
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
