//
//  CustomerCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CustomerCell.h"

@implementation CustomerCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *codeLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 15 - 115, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        codeLbl.text = @"3zd7890987890";
        [self addSubview:codeLbl];
        
        UILabel *stateLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 115, 0, 100, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        stateLbl.text = @"待征信派单";
        [self addSubview:stateLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 50, 0, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
        nameLbl.text = @"张三";
        [nameLbl sizeToFit];
        nameLbl.frame = CGRectMake(15, 50, nameLbl.width, 20);
        [self addSubview:nameLbl];
        
        
        UILabel *carNameLbl = [UILabel labelWithFrame:CGRectMake(nameLbl.xx + 5, 52.5, 0, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kHexColor(@"#FF9D4D") font:Font(10) textColor:kWhiteColor];
        carNameLbl.text = @"新车";
        
        kViewRadius(carNameLbl, 2);
        [carNameLbl sizeToFit];
        carNameLbl.frame =CGRectMake(nameLbl.xx + 5, 52.5, carNameLbl.width + 9, 15);
        [self addSubview:carNameLbl];
        
        
        UILabel *priceLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 115, 50, 100, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(14) textColor:kAppCustomMainColor];
        priceLbl.text = @"10.7万";
        [self addSubview:priceLbl];
        
        
        
        UILabel *bankLbl = [UILabel labelWithFrame:CGRectMake(15, 80, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        bankLbl.text = @"经办银行：中国工商银行";
        [self addSubview:bankLbl];
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(15, 103.5, SCREEN_WIDTH - 30, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#666666")];
        timeLbl.text = @"开始时间：2019-10-10 20:00:00";
        [self addSubview:timeLbl];
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 135, SCREEN_WIDTH, 10)];
        bottomView.backgroundColor = kBackgroundColor;
        [self addSubview:bottomView];
        
        
    }
    return self;
}

@end
