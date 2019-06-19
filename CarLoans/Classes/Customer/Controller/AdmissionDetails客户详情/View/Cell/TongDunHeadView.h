//
//  TongDunHeadView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBCircleChart.h"
NS_ASSUME_NONNULL_BEGIN

@interface TongDunHeadView : UIView
@property (nonatomic,strong) GBCircleChart * circleChart;
@property (nonatomic,strong) NSDictionary * tongdunResult;
@property (nonatomic,strong) UILabel * tongdunid;
@property (nonatomic,strong) UILabel * resultlabel;
@end

NS_ASSUME_NONNULL_END
