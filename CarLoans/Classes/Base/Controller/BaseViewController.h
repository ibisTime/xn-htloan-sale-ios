//
//  BaseViewController.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (nonatomic , strong)UIButton *LeftBackbButton;

@property (nonatomic , strong)UIButton *RightButton;
-(void)initNavigationController;
@end

NS_ASSUME_NONNULL_END
