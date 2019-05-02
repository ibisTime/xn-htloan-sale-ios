//
//  AdmissionDetailsTableView2.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView2.h"

#import "AdmissionInformationCell.h"
#import "AdmiissionDetailsIDCardCellCell.h"
#import "PhotoCell.h"
@interface AdmissionDetailsTableView2 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end
@implementation AdmissionDetailsTableView2
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.creditUserList.count;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 11;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataDic = self.model.creditUserList[indexPath.section];
    if (indexPath.row == 5) {
        static NSString *CellIdentifier = @"AdmiissionDetailsIDCardCellCell";
        AdmiissionDetailsIDCardCellCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[AdmiissionDetailsIDCardCellCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.creditUser = dataDic;
        return cell;
    }
    if (indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 9) {
        static NSString *CellIdentifier = @"PhotoCell";
        PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 6) {
            cell.collectDataArray = [dataDic[@"authPdf"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"征信查询授权书";
        }
        if (indexPath.row == 7) {
            cell.collectDataArray = [dataDic[@"interviewPic"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"面签照片";
        }
        if (indexPath.row == 9) {
            NSString *str = [NSString stringWithFormat:@"%@||%@",dataDic[@"dataCreditReport"],dataDic[@"BankCreditReport"]];
            cell.collectDataArray = [str componentsSeparatedByString:@"||"];
            cell.selectStr = @"征信报告";
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

    NSArray *topArray = @[@"姓名",@"于借贷人关系",@"贷款人角色",@"手机号",@"身份证号",@"",@"",@"",@"信用卡使用占比",@"",@"征信结果说明"];
    cell.topLbl.text = topArray[indexPath.row];
    
    NSArray *bottomArray = @[[BaseModel convertNullReturnStr:dataDic[@"userName"]],
                             [[BaseModel user] setParentKey:@"credit_user_relation" setDkey:dataDic[@"relation"]],
                             [[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:dataDic[@"loanRole"]],
                             [BaseModel convertNullReturnStr:dataDic[@"mobile"]],
                             [BaseModel convertNullReturnStr:dataDic[@"idNo"]],
                             @"",
                             @"",
                             @"",
                             @"0",
                             @"",
                             [BaseModel convertNullReturnStr:dataDic[@"bankCreditResultRemark"]]];
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
    NSDictionary *dataDic = self.model.creditUserList[indexPath.section];
    if (indexPath.row == 5) {
        return (SCREEN_WIDTH - 107 - 40)/2/210*133 + 47;
    }
    if (indexPath.row == 6) {
        NSArray *array = [dataDic[@"authPdf"] componentsSeparatedByString:@"||"];
        float numberToRound;
        int result;
        numberToRound = (array.count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
    }
    if (indexPath.row == 7) {
        NSArray *array = [dataDic[@"interviewPic"] componentsSeparatedByString:@"||"];
        float numberToRound;
        int result;
        numberToRound = (array.count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ) + 32;
    }
    if (indexPath.row == 9) {
        NSString *str = [NSString stringWithFormat:@"%@||%@",dataDic[@"dataCreditReport"],dataDic[@"BankCreditReport"]];
        NSArray *array = [str componentsSeparatedByString:@"||"];
        float numberToRound;
        int result;
        numberToRound = (array.count)/3.0;
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
        nameLbl.text = @"征信列表";
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
    
    UIView *footView = [[UIView alloc]init];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 22, SCREEN_WIDTH - 107, 1)];
    lineView.backgroundColor = kLineColor;
    [footView addSubview:lineView];
    return footView;
}


@end
