//
//  CustomerTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomerTableView : TLTableView
@property (nonatomic , strong)NSMutableArray <CustomerModel *>*models;
@property (nonatomic , strong)NSArray *dataArray;
@end

NS_ASSUME_NONNULL_END
