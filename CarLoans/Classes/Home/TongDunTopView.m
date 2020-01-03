//
//  TongDunTopView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TongDunTopView.h"

@implementation TongDunTopView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _circleChart = [[GBCircleChart alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 0, 100, 100) total:@100 current:@0 clockwise:YES shadow:YES shadowColor:[[UIColor grayColor] colorWithAlphaComponent:0.4] displayCountingLabel:YES overrideLineWidth:@4];
        [self addSubview:_circleChart];
        _circleChart.strokeColorGradientStart = [UIColor blueColor];
        _circleChart.strokeColor = [UIColor redColor];
        //    circleChart.shadowColor = [UIColor blueColor];
        _circleChart.countingLabel.formatBlock = ^NSString *(CGFloat value) {
            
            return [NSString stringWithFormat:@"%0.0f", value];
        };
        [_circleChart strokeChart];
        
        self.tongdunid = [UILabel labelWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 30) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        [self addSubview:self.tongdunid];
        
        self.resultlabel = [UILabel labelWithFrame:CGRectMake(0, 135, SCREEN_WIDTH, 30) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(16) textColor:kBlackColor];
        [self addSubview:self.resultlabel];
        
    }
    return self;
}

-(void)setTongdunResult:(NSDictionary *)tongdunResult{
    _circleChart.current = tongdunResult[@"result_desc"][@"ANTIFRAUD"][@"final_score"];
    [_circleChart strokeChart];
    
    self.tongdunid.text = [NSString stringWithFormat:@"保镖ID:%@",[BaseModel convertNull: tongdunResult[@"id"]]];
    
    NSString * str = tongdunResult[@"result_desc"][@"ANTIFRAUD"][@"final_decision"];
    if ([str isEqualToString:@"PASS"]) {
        self.resultlabel.text = @"建议通过";
        [self.resultlabel setTextColor:RGB(167, 217, 112)];
    }
    else if ([str isEqualToString:@"REVIEW"]) {
        self.resultlabel.text = @"建议复核";
        [self.resultlabel setTextColor:RGB(240, 211, 72)];
    }
    else if ([str isEqualToString:@"REJECT"]) {
        self.resultlabel.text = @"建议拒绝";
        [self.resultlabel setTextColor:RGB(221, 105, 94)];
    }
}
@end
