//
//  GreenListTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GreenListTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray< ListModel *> * models;
@end

NS_ASSUME_NONNULL_END
