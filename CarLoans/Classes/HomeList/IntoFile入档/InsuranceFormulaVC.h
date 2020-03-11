//
//  InsuranceFormulaVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2020/3/10.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^DealerSearchBlock)(SurveyModel *model);
NS_ASSUME_NONNULL_BEGIN

@interface InsuranceFormulaVC : BaseViewController
@property (nonatomic, copy) DealerSearchBlock returnAryBlock;
@end

NS_ASSUME_NONNULL_END
