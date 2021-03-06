//
//  DealerSearchVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/16.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^DealerSearchBlock)(SurveyModel *model);

@interface DealerSearchVC : BaseViewController

@property (nonatomic, copy) DealerSearchBlock returnAryBlock;

@end

NS_ASSUME_NONNULL_END
