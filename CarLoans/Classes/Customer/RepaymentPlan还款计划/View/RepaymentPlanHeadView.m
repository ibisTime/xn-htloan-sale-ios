//
//  RepaymentPlanHeadView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "RepaymentPlanHeadView.h"

@implementation RepaymentPlanHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kAppCustomMainColor;
        
        UILabel *remainingLbl = [UILabel labelWithFrame:CGRectMake(0, 21, SCREEN_WIDTH, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
        remainingLbl.text = @"剩余还款总额（元）";
        remainingLbl.alpha= 0.8;
        [self addSubview:remainingLbl];
        
        UILabel *priceLbl = [UILabel labelWithFrame:CGRectMake(0, remainingLbl.yy + 2, SCREEN_WIDTH, 45) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(32) textColor:kWhiteColor];
        priceLbl.text = @"2890.00";
        [self addSubview:priceLbl];
        
        UILabel *introduceLbl = [UILabel labelWithFrame:CGRectMake(0, priceLbl.yy + 2, SCREEN_WIDTH, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
        introduceLbl.text = @"（包含利息及费用53.67）";
        introduceLbl.alpha= 0.8;
        [self addSubview:introduceLbl];
        
    }
    return self;
}
@end
