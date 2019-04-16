//
//  SendDataTransferTableView.h
//  CarLoans
//
//  Created by shaojianfei on 2018/12/21.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "DataTransferModel.h"
#import "CadListModel.h"
@interface SendDataTransferTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <DataTransferModel *>*model;

@property (nonatomic , strong)NSMutableArray <CadListModel *>*models;

@property (nonatomic , assign)BOOL isGps;

@property (nonatomic , assign)BOOL isDetail;

@property (nonatomic , assign)BOOL isRecview;

@end
