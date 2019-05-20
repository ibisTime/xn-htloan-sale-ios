//
//  CancelMortgageTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CancelMortgageTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)NSMutableArray <SettlementAuditModel *>*model;
@end

NS_ASSUME_NONNULL_END
