//
//  CustomerCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CustomerCell.h"

@implementation CustomerCell
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
        codeLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15 - 115, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
//        codeLbl.text = @"3zd7890987890";
        [self addSubview:codeLbl];
        
        stateLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 165, 0, 150, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
//        stateLbl.text = @"待征信派单";
        [self addSubview:stateLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, 50, 0, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
//        nameLbl.text = @"张三";
        
        [self addSubview:nameLbl];
        
        
        carNameLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx + 5, 52.5, 0, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kHexColor(@"#FF9D4D") font:Font(10) textColor:kWhiteColor];
//        carNameLbl.text = @"新车";
        
        kViewRadius(carNameLbl, 2);
        
        [self addSubview:carNameLbl];
        
        
        priceLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 115, 50, 100, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(14) textColor:kAppCustomMainColor];
//        priceLbl.text = @"10.7万";
        [self addSubview:priceLbl];
        
        
        
        bankLbl = [UILabel labelWithFrame:CGRectMake(15, 80, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
//        bankLbl.text = @"经办银行：中国工商银行";
        [self addSubview:bankLbl];
        
        timeLbl = [UILabel labelWithFrame:CGRectMake(15, 103.5, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
//        timeLbl.text = @"开始时间：2019-10-10 20:00:00";
        [self addSubview:timeLbl];
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 135, SCREEN_WIDTH, 10)];
        bottomView.backgroundColor = kBackgroundColor;
        [self addSubview:bottomView];
        
        
    }
    return self;
}

-(void)setModel:(CustomerModel *)model
{
    _model = model;
    codeLbl.text = model.code;
    
    nameLbl.text = model.credit[@"creditUser"][@"userName"];
    nameLbl.frame = CGRectMake(15, 50, 0, 20);
    [nameLbl sizeToFit];
    nameLbl.frame = CGRectMake(15, 50, nameLbl.width, 20);
    bankLbl.text = model.credit[@"loanBankName"];
    NSString *bizType;
    if ([model.credit[@"bizType"] integerValue] == 0) {
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
    timeLbl.text = [model.credit[@"applyDatetime"] convertToDetailDate];
    priceLbl.text = [NSString stringWithFormat:@"%.2f万",[model.dkAmount floatValue]/10000];
}

-(void)setDataArray:(NSArray *)dataArray
{
    for (int i = 0; i < dataArray.count; i ++) {
        if ([dataArray[i][@"dkey"] isEqualToString:_model.status]) {
            stateLbl.text = dataArray[i][@"dvalue"];
        }
    }
}

@end
