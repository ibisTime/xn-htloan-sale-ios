//
//  AdmissionDetailsTableView10.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView10.h"

@interface AdmissionDetailsTableView10 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end
@implementation AdmissionDetailsTableView10
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
    
    return 14;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 13) {
        static NSString *CellIdentifier = @"PhotoCell";
        PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 13) {
            cell.collectDataArray = [self.model.bankLoan[@"receiptPdf"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"收款凭证";
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
    NSArray *topArray = @[@"收款银行",
                          @"收款卡号",
                          @"还款银行",
                          @"还款卡号",
                          @"放款日期",
                          @"账单还款日",
                          @"银行还款日",
                          @"公司还款日",
                          @"首期还款日期",
                          @"首期月供金额",
                          @"每期月供金额",
                          @"收款账号",
                          @"提交时间",
                          @""];
    cell.topLbl.text = topArray[indexPath.row];
    
    NSArray *bottomArray = @[[NSString stringWithFormat:@"%@ %@",[BaseModel convertNull: self.model.bankLoan[@"receiptBankName"]],[BaseModel convertNull:self.model.bankLoan[@"receiptSubbranch"]]],
                             [BaseModel convertNull:self.model.bankLoan[@"receiptBankcardNumber"]],
                             [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull: self.model.loanBankName],[BaseModel convertNull:self.model.subbranchBankName]],
                             [BaseModel convertNull:self.model.bankLoan[@"repayBankcardNumber"]],
                             [BaseModel convertNull:self.model.bankLoan[@"bankFkDate"]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.bankLoan[@"repayBillDate"]]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.bankLoan[@"repayBankDate"]]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.bankLoan[@"repayCompanyDate"]]],
                             [BaseModel convertNull:self.model.bankLoan[@"repayFirstMonthDatetime"]],
                             [BaseModel convertNullWithOutMoney:[NSString stringWithFormat:@"%.2f",[self.model.bankLoan[@"repayFirstMonthAmount"] floatValue]/1000]],
                             [BaseModel convertNullWithOutMoney:[NSString stringWithFormat:@"%.2f",[self.model.bankLoan[@"repayMonthAmount"] floatValue]/1000]],
                             [BaseModel convertNull:self.model.bankLoan[@"receiptBankcardNumber"]],
                             [BaseModel convertNull:[self.model.bankLoan[@"bankCommitDatetime"] convertDateWithFormat:@"yyyy-MM-dd"]],
                             @""];
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
    if (indexPath.row == 13) {
        float numberToRound;
        int result;
        numberToRound = ([self.model.bankLoan[@"receiptPdf"] componentsSeparatedByString:@"||"].count)/3.0;
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
        nameLbl.text = @"银行放款";
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
