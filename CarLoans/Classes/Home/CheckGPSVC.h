//
//  CheckGPSVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "GPSInstallationModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CheckGPSVC : BaseViewController
@property (nonatomic , strong)NSArray *peopleAray;
@property (nonatomic , strong)GPSInstallationModel *model;
@end

NS_ASSUME_NONNULL_END
