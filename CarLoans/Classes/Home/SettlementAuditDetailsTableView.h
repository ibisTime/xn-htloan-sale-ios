//
//  SettlementAuditDetailsTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "SettlementAuditModel.h"
@interface SettlementAuditDetailsTableView : TLTableView
@property (nonatomic , copy)NSString *date;
@property (nonatomic , strong)SettlementAuditModel *model;

@property (nonatomic , strong)NSArray *proveArray;

@end
