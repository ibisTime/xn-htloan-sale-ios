//
//  TimeSubmissionVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TimeSubmissionVC : BaseViewController

@property (nonatomic , copy)NSString *left;
@property (nonatomic , copy)NSString *right;
@property (nonatomic , assign)NSInteger selectRow;
@property (nonatomic , strong)SurveyModel *model;
@end

NS_ASSUME_NONNULL_END
