//
//  SenderGPSVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransferModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SenderGPSVC : BaseViewController
@property (nonatomic , strong)DataTransferModel *model;
@property (nonatomic,strong) NSString * code;
@property (nonatomic,strong) NSString * state;
@end

NS_ASSUME_NONNULL_END
