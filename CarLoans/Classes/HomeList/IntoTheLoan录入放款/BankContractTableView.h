//
//  BankContractTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BankContractTableView : TLTableView
//@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , strong)NSMutableArray <SurveyModel *>*models;
@end

NS_ASSUME_NONNULL_END
