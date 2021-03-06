//
//  AdmissionDetailsTableView9.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView9.h"

@interface AdmissionDetailsTableView9 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end
@implementation AdmissionDetailsTableView9
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
    
    return 13;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 10) {
        static NSString *CellIdentifier = @"PhotoCell";
        PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 10) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"advance_bill_pdf"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"水单";
        }
        
        return cell;
        
    }
    if (indexPath.row == 12) {
        static NSString *rid=@"cell123";
        AdmissionInformationCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[AdmissionInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        _cell = cell;
        NSArray *topArray = @[@"收款账号"];
        cell.topLbl.text = topArray[0];
        NSArray * array = self.model.advance[@"advanceCollectCardList"];
        NSMutableArray * bank = [NSMutableArray array];
        NSString * str ;
        for (int i = 0; i < array.count; i ++) {
            [bank addObject:[[BaseModel user]ReturnBankcardNumberByCode:array[i][@"collectBankcardCode"] ]];
        }
        str = [bank componentsJoinedByString:@"\n"];
        NSLog(@"%@",str);
        cell.bottomLbl.text = str;
        cell.bottomLbl.numberOfLines = 0;
        [cell.bottomLbl sizeToFit];
        cell.bottomLbl.frame = CGRectMake(15, 39, SCREEN_WIDTH - 137, cell.bottomLbl.height);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *CellIdentifier = @"Cell";
    AdmissionInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[AdmissionInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _cell = cell;
    NSArray *topArray = @[@"GPS费用",
                          @"公证费",
                          @"月供保证金",
                          @"其他费用",
                          @"公司服务费",
                          @"团队服务费",
                          @"银行服务费",
                          @"垫资日期",
                          @"垫资金额",
                          @"出款账号",
                          @"",
                          @"垫资说明"];
    cell.topLbl.text = topArray[indexPath.row];
    
    NSArray *bottomArray = @[[BaseModel convertNull:[NSString stringWithFormat:@"%.2f", [self.model.loanInfo[@"gpsFee"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f", [self.model.loanInfo[@"authFee"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f", [self.model.loanInfo[@"monthDeposit"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f", [self.model.loanInfo[@"otherFee"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f", [self.model.loanInfo[@"companyFee"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f", [self.model.loanInfo[@"teamFee"] floatValue]/1000]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f", [self.model.carInfoRes[@"bankFee"] floatValue]/1000]],
                             [BaseModel convertNull:[self.model.advance[@"advanceFundDatetime"] convertDateWithFormat:@"yyyy-MM-dd"]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f", [self.model.advance[@"advanceFundAmount"] floatValue]/1000]],
                             [BaseModel convertNull:[[BaseModel user]ReturnBankcardNumberByCode:self.model.advance[@"advanceCardCode"]]],
                             @"",
                             [BaseModel convertNull:self.model.advance[@"advanceNote"]]];
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
    if (indexPath.row == 10) {
        float numberToRound;
        int result;
        numberToRound = ([[[BaseModel user]FindUrlWithModel:self.model ByKname:@"advance_bill_pdf"] componentsSeparatedByString:@"||"].count)/3.0;
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
        nameLbl.text = @"财务垫资";
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
