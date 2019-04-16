//
//  SettlementAuditTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "SettlementAuditModel.h"
@interface SettlementAuditTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <SettlementAuditModel *>*model;

@end
