//
//  CreditDetailsCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CreditDetailsCell.h"

@implementation CreditDetailsCell
{
    UILabel *nameLbl;
    UILabel *mobileLbl;
    UILabel *stateLbl;
    UILabel *idCardLbl;
    UILabel *whoLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[ super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, 12.5, 0, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#676767")];
        [self addSubview:nameLbl];
        
        
        mobileLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx + 35, 12.5, 0, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#676767")];
        [self addSubview:mobileLbl];
        
        stateLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 100, 12.5, 85, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#F86767")];
        [self addSubview:stateLbl];
        
        idCardLbl = [UILabel labelWithFrame:CGRectMake(15, 40, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#676767")];
        [self addSubview:idCardLbl];
        
        
        whoLbl = [UILabel labelWithFrame:CGRectMake(15, 71.5, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#676767")];
        [self addSubview:whoLbl];
        
    }
    return self;
}

-(void)setCreditUser:(NSDictionary *)creditUser
{
    nameLbl.frame = CGRectMake(15, 12.5, 0, 20);
    nameLbl.text = creditUser[@"userName"];
    [nameLbl sizeToFit];
    nameLbl.frame = CGRectMake(15, 12.5, nameLbl.width, 20);
    
    mobileLbl.frame = CGRectMake(nameLbl.xx + 35, 12.5, 0, 20);
    mobileLbl.text = creditUser[@"mobile"];
    [mobileLbl sizeToFit];
    mobileLbl.frame = CGRectMake(nameLbl.xx + 35, 12.5, mobileLbl.width, 20);
    
    idCardLbl.text = creditUser[@"idNo"];
    
    whoLbl.text = [NSString stringWithFormat:@"%@/%@",[[BaseModel user] setParentKey:@"credit_user_relation" setDkey:creditUser[@"relation"]],[[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:creditUser[@"loanRole"]]];
    
    if ([creditUser[@"bankCreditResultPdf"] isEqualToString:@"1"]) {
        stateLbl.text = @"征信通过";
    }else
    {
        stateLbl.text = @"";
    }
}

@end
