//
//  HomeListCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "HomeListCell.h"

@implementation HomeListCell
{
    UILabel *codeLbl;
    UILabel *stateLbl;
    UILabel *nameLbl;
    UILabel *carNameLbl;
    UILabel *priceLbl;
    UILabel *bankLbl;
    UILabel *timeLbl;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        codeLbl = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        codeLbl.text = @"3zd7890987890";
        [self addSubview:codeLbl];
        [codeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        
        stateLbl = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        //        stateLbl.text = @"待征信派单";
        [self addSubview:stateLbl];
        [stateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(40);
            make.left.equalTo(codeLbl.mas_right).mas_equalTo(0);
        }];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, 50, 0, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
        nameLbl.text = @"张三";
        [self addSubview:nameLbl];
        
        
        carNameLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx + 5, 52.5, 0, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kHexColor(@"#FF9D4D") font:Font(10) textColor:kWhiteColor];
        carNameLbl.text = @"新车";
        kViewRadius(carNameLbl, 2);
        [self addSubview:carNameLbl];
        
        
        
        nameLbl.frame = CGRectMake(15, 50, 0, 20);
        [nameLbl sizeToFit];
        nameLbl.frame = CGRectMake(15, 50, nameLbl.width, 20);
        carNameLbl.frame = CGRectMake(nameLbl.xx + 5, 52.5, 0, 15);
        [carNameLbl sizeToFit];
        carNameLbl.frame = CGRectMake(nameLbl.xx + 5, 52.5, carNameLbl.width + 9, 15);
        
        
        
        
        priceLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 115, 50, 100, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(14) textColor:kAppCustomMainColor];
        priceLbl.text = @"10.7万";
        [self addSubview:priceLbl];
        
        
        
        bankLbl = [UILabel labelWithFrame:CGRectMake(15, 80, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        bankLbl.text = @"经办银行：中国工商银行";
        [self addSubview:bankLbl];
        
        timeLbl = [UILabel labelWithFrame:CGRectMake(15, 103.5, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        timeLbl.text = @"开始时间：2019-10-10 20:00:00";
        [self addSubview:timeLbl];
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 135, SCREEN_WIDTH, 10)];
        bottomView.backgroundColor = kBackgroundColor;
        [self addSubview:bottomView];
        
        
    }
    return self;
}

-(void)setPledgeNodeCode:(NSString *)pledgeNodeCode
{
    _pledgeNodeCode = pledgeNodeCode;
}

-(void)setModel:(SurveyModel *)model
{
    _model = model;
    if ([_pledgeNodeCode isEqualToString:@"h1"] || [_pledgeNodeCode isEqualToString:@"h2"]) {
        stateLbl.text = [[BaseModel user]note:model.materialNodeCode];
    }else if ([_pledgeNodeCode isEqualToString:@"e1"] || [_pledgeNodeCode isEqualToString:@"e2"]) {
        stateLbl.text = [[BaseModel user]note:model.pledgeNodeCode];
    }else
    {
        stateLbl.text = [[BaseModel user]note:model.curNodeCode];
    }
    
    codeLbl.text = model.code;
    
    nameLbl.text = model.creditUser[@"userName"];
    nameLbl.frame = CGRectMake(15, 50, 0, 20);
    [nameLbl sizeToFit];
    nameLbl.frame = CGRectMake(15, 50, nameLbl.width, 20);
    bankLbl.text = model.loanBankName;
    NSString *bizType;
    if ([model.bizType integerValue] == 0) {
        bizType = @"新车";
    }
    else
    {
        bizType = @"二手车";
    }
    carNameLbl.frame = CGRectMake(nameLbl.xx + 5, 52.5, 0, 15);
    carNameLbl.text = bizType;
    [carNameLbl sizeToFit];
    carNameLbl.frame = CGRectMake(nameLbl.xx + 5, 52.5, carNameLbl.width + 9, 15);
    
    
    timeLbl.text = [model.applyDatetime convertToDetailDate];
    priceLbl.text = [NSString stringWithFormat:@"%.2f",[model.loanAmount floatValue]/1000];
}

@end
