//
//  CreditDetailsTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreditDetailsTableView : TLTableView
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , strong)NSString *state;
@property (nonatomic , strong)NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
