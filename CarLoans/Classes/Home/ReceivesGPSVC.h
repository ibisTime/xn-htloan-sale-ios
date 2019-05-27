//
//  ReceivesGPSVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransferModel.h"
#import "CadListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ReceivesGPSVC : BaseViewController
@property (nonatomic , strong)DataTransferModel *model;
@property (nonatomic,strong) NSString * code;
@property (nonatomic , assign)BOOL isGps;

@property (nonatomic , strong)NSMutableArray <CadListModel *>*models;
@end

NS_ASSUME_NONNULL_END
