//
//  ReceivesAuditTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/8.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "DataTransferModel.h"
#import "CadListModel.h"
@interface ReceivesAuditTableView : TLTableView

@property (nonatomic , strong)DataTransferModel *model;
@property (nonatomic , assign)BOOL isGps;
@property (nonatomic , strong)NSMutableArray <CadListModel *>*models;

@end
