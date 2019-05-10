//
//  CheckCarTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckCarTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)AccessSingleModel *model;
@property (nonatomic , copy)NSString *date;
@end

NS_ASSUME_NONNULL_END
