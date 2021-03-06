//
//  FinancialTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/5.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FinancialTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)NSMutableArray <SurveyModel *>*model;
@end

NS_ASSUME_NONNULL_END
