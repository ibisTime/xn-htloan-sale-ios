//
//  TongDunHeadView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TongDunHeadView.h"
#import "GBCircleChart.h"
@implementation TongDunHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _circleChart = [[GBCircleChart alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 107 - 100)/2, 0, 100, 100) total:@100 current:@0 clockwise:YES shadow:YES shadowColor:[[UIColor grayColor] colorWithAlphaComponent:0.4] displayCountingLabel:YES overrideLineWidth:@4];
        [self addSubview:_circleChart];
        _circleChart.strokeColorGradientStart = [UIColor blueColor];
        _circleChart.strokeColor = [UIColor redColor];
        //    circleChart.shadowColor = [UIColor blueColor];
        _circleChart.countingLabel.formatBlock = ^NSString *(CGFloat value) {
            
            return [NSString stringWithFormat:@"%0.0f", value];
        };
        [_circleChart strokeChart];
        
        self.tongdunid = [UILabel labelWithFrame:CGRectMake(0, 100, SCREEN_WIDTH - 107, 30) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        [self addSubview:self.tongdunid];
        
    }
    return self;
}

-(void)setTongdunResult:(NSDictionary *)tongdunResult{
    _circleChart.current = tongdunResult[@"result_desc"][@"ANTIFRAUD"][@"final_score"];
    [_circleChart strokeChart];
    
    self.tongdunid.text = [NSString stringWithFormat:@"保镖ID:%@",[BaseModel convertNull: tongdunResult[@"id"]]];
}
@end
