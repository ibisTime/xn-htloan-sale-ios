//
//  DataCollectedVC.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "DataTransferModel.h"
@interface DataCollectedVC : BaseViewController
@property (nonatomic , assign)BOOL  isDetail;
@property (nonatomic , strong) DataTransferModel *mode;

@end
