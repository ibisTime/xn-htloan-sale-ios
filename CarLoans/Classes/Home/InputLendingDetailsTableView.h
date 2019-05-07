//
//  InputLendingDetailsTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/7.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface InputLendingDetailsTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)AccessSingleModel *model;
@property (nonatomic , copy)NSString *date;
@property (nonatomic , copy)NSString *date1;
@end

NS_ASSUME_NONNULL_END
