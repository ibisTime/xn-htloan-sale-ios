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
        
//        self.backgroundColor = kAppCustomMainColor;
        
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, (SCREEN_WIDTH - 107) - 30, 115)];
        backView.backgroundColor = kAppCustomMainColor;
        kViewRadius(backView , 4);
        [self addSubview:backView];
        
        UILabel *remainingLbl = [UILabel labelWithFrame:CGRectMake(0, 20, (SCREEN_WIDTH - 107) - 30, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
        remainingLbl.text = @"剩余还款总额（元）";
        remainingLbl.alpha= 0.8;
        [backView addSubview:remainingLbl];
        
        UILabel *priceLbl = [UILabel labelWithFrame:CGRectMake(0, remainingLbl.yy, (SCREEN_WIDTH - 107) - 30, 45) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(28) textColor:kWhiteColor];
        priceLbl.text = @"2890.00";
        [backView addSubview:priceLbl];
        
        UILabel *introduceLbl = [UILabel labelWithFrame:CGRectMake(0, priceLbl.yy, (SCREEN_WIDTH - 107) - 30, 15) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
        introduceLbl.text = @"（包含利息及费用53.67）";
        introduceLbl.alpha= 0.8;
        [backView addSubview:introduceLbl];
        
    }
    return self;
}
@end
