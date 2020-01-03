//
//  YeWuTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/24.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YeWuTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) CustomerInvalidModel * model;
@end

NS_ASSUME_NONNULL_END
