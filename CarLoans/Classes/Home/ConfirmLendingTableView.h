//
//  ConfirmLendingTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/7.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ConfirmLendingTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong) AccessSingleModel *model;
@property (nonatomic , copy)NSString *date;
@property (nonatomic , copy)NSString *bankStr;
@property (nonatomic , copy)NSString *speciesStr;
@property (nonatomic , copy)NSString *secondCarReport;
@end

NS_ASSUME_NONNULL_END
