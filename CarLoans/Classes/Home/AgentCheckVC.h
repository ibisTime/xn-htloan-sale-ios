//
//  AgentCheckVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AgentCheckVC : BaseViewController
@property (nonatomic , strong)AccessSingleModel *model;
@property (nonatomic,strong) NSString * code;
//    身份证正面
@property (nonatomic , copy)NSString *idNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *idNoReverse;
@end

NS_ASSUME_NONNULL_END
