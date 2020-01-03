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
        
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        backView.backgroundColor = kAppCustomMainColor;
//        kViewRadius(backView , 4);
        [self addSubview:backView];
        
        UILabel *remainingLbl = [UILabel labelWithFrame:CGRectMake(0, 21, SCREEN_WIDTH, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
        remainingLbl.text = @"剩余还款总额（元）";
        remainingLbl.alpha= 0.8;
        [backView addSubview:remainingLbl];
        
        UILabel *priceLbl = [UILabel labelWithFrame:CGRectMake(0, remainingLbl.yy + 2, SCREEN_WIDTH, 45) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(28) textColor:kWhiteColor];
        priceLbl.text = [BaseModel convertNull:self.price];
        priceLbl.tag = 1001;
        [backView addSubview:priceLbl];
        
        UILabel *introduceLbl = [UILabel labelWithFrame:CGRectMake(0, priceLbl.yy + 2, SCREEN_WIDTH, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
        introduceLbl.text = @"（已包含利息）";
        introduceLbl.alpha= 0.8;
        [backView addSubview:introduceLbl];
        
    }
    return self;
}
-(void)setPrice:(NSString *)price{
    UILabel * label = [self viewWithTag:1001];
    if ([price floatValue] == 0) {
        label.text = [NSString stringWithFormat:@"%.2f",[price floatValue]/1000];
    }else
    {
//        NSInteger pri = [price integerValue];
        label.text = [NSString stringWithFormat:@"%@",[RepaymentPlanHeadView CHUmult1:[NSString stringWithFormat:@"%@",price] mult2:@"1000" scale:2]];
    }
}

+ (NSString *)CHUmult1:(NSString *)mult1 mult2:(NSString *)mult2 scale:(NSUInteger)scale{
    if ([mult1 isEqualToString:@""] || [mult2 isEqualToString:@""]) {
        return @"";
    }
    
    NSDecimalNumber *mult1Num = [[NSDecimalNumber alloc] initWithString:mult1];
    NSDecimalNumber *mult2Num = [[NSDecimalNumber alloc] initWithString:mult2];
    NSDecimalNumber *result = [mult1Num decimalNumberByDividingBy:mult2Num];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler  decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                              scale:scale
                                                                                   raiseOnExactness:NO
                                                                                    raiseOnOverflow:NO
                                                                                   raiseOnUnderflow:NO
                                                                                raiseOnDivideByZero:YES];
    
    return [[result decimalNumberByRoundingAccordingToBehavior:roundUp] stringValue];
}


@end
