//
//  AdmissionDetailsTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdmissionDetailsTableView : TLTableView
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic,assign) NSInteger row;

@end

NS_ASSUME_NONNULL_END
