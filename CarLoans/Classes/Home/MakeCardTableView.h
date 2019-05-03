//
//  MakeCardTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/2.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MakeCardTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <SurveyModel *>*model;
@property (nonatomic , copy)NSString *title;
@end

NS_ASSUME_NONNULL_END
