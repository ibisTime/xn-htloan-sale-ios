//
//  CreditReviewTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "SurveyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CreditReviewTableView : TLTableView
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , strong)NSString *state;
@end

NS_ASSUME_NONNULL_END
