//
//  ReferenceInputVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/19.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "SurveyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReferenceInputVC : BaseViewController
@property (nonatomic , copy)NSString *code;

@property (nonatomic , strong)SurveyModel *surveyModel;
@end

NS_ASSUME_NONNULL_END
