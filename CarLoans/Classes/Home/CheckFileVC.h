//
//  CheckFileVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/13.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckFileVC : BaseViewController
@property (nonatomic,strong) AccessSingleModel * model;
@property (nonatomic,strong) NSString * code;
@end

NS_ASSUME_NONNULL_END
