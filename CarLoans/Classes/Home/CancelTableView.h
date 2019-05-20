//
//  CancelTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CancelTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) SettlementAuditModel * model;
@property (nonatomic,strong) NSString * date;
@end

NS_ASSUME_NONNULL_END
