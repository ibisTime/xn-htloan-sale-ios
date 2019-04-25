//
//  CreditResultsTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CreditResultsTableView.h"


#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "CreditReportingPersonInformationCell.h"
#define CreditReportingPersonInformation @"CreditReportingPersonInformationCell"
#import "SurverCertificateCell.h"
#define SurverCertificate @"SurverCertificateCell"
#import "UsedCarInformationCell.h"
#define UsedCarInformation @"UsedCarInformationCell"
#import "ChooseCell.h"
#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"
@interface CreditResultsTableView ()<UITableViewDataSource,UITableViewDelegate,CreditReportingPersonInformationDelegate,CustomCollectionDelegate>

@end
@implementation CreditResultsTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[CreditReportingPersonInformationCell class] forCellReuseIdentifier:CreditReportingPersonInformation];
        [self registerClass:[SurverCertificateCell class] forCellReuseIdentifier:SurverCertificate];
        [self registerClass:[UsedCarInformationCell class] forCellReuseIdentifier:UsedCarInformation];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:@"ChooseCell"];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 6;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"姓名",@"与借款人关系",@"贷款角色",@"手机号",@"身份证号",@"银行征信结果"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSString *_bankResult;
        if ([self.dataDic[@"bankCreditResult"] isEqualToString:@"1"]) {
            _bankResult = @"通过";
        }else
        {
            _bankResult = @"不通过";
        }
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",self.dataDic[@"userName"]],
                                  [[BaseModel user] setParentKey:@"credit_user_relation" setDkey:self.dataDic[@"relation"]],
                                  [[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:self.dataDic[@"loanRole"]],
                                  [NSString stringWithFormat:@"%@",self.dataDic[@"mobile"]],
                                  [NSString stringWithFormat:@"%@",self.dataDic[@"idNo"]],
                                  _bankResult
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    
    if (indexPath.section == 1) {
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.isEditor = NO;
        cell.selectStr = @"银行征信报告";
        cell.collectDataArray = self.bankCreditReport;
        
        return cell;
    }
    if (indexPath.section == 2) {
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.selectStr = @"大数据征信报告";
        cell.collectDataArray = self.dataCreditReport;
        cell.isEditor = NO;
        return cell;
    }
    
    
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"征信结果说明";
    cell.nameText = @"请输入说明";
    cell.isInput = 0;
    cell.TextFidStr = self.dataDic[@"bankCreditResultRemark"];
    cell.nameTextField.tag = 3000;
    return cell;
}





#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        float numberToRound;
        int result;
        numberToRound = (self.bankCreditReport.count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
    }
    if (indexPath.section == 2) {
        float numberToRound;
        int result;
        numberToRound = (self.dataCreditReport.count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 1 || section == 2) {
        return 50;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];
        
        NSArray *array = @[@"银行征信报告",@"大数据征信报告"];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section - 1];
        [headView addSubview:nameLabel];
        
        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
 
    return nil;
}

@end
