//
//  NewWaterTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/2.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewWaterTableView : TLTableView
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , strong)NSArray *picArray;
@end

NS_ASSUME_NONNULL_END
