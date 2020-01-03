//
//  SecondReportVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecondReportVC : BaseViewController
@property (nonatomic,strong) UIWebView * detail;
@property (nonatomic,strong) NSString * web;
@property (nonatomic,strong) UIScrollView * scrollview;
@property (nonatomic,strong) NSString * IntroduceTitle;
@property (nonatomic,strong) NSString * time;
@end

NS_ASSUME_NONNULL_END
