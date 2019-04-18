//
//  CustomerDetailsVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomerDetailsVC : BaseViewController
@property (nonatomic , strong)CustomerModel *model;
@property (nonatomic , strong)NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
