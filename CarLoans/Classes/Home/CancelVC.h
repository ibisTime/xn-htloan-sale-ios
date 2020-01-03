//
//  CancelVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CancelVC : BaseViewController
@property (nonatomic,strong) SettlementAuditModel * model;
@property (nonatomic,strong) NSString * code;
@end

NS_ASSUME_NONNULL_END
