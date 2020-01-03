//
//  AccessToInformationVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AccessToInformationVC : BaseViewController

@property (nonatomic , strong)NSString *carcode;
@property (nonatomic , strong)NSString *SerialNumber;
@property (nonatomic , strong)SurveyModel *model;

@end

NS_ASSUME_NONNULL_END
