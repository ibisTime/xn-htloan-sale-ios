//
//  ForwardRepayTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ForwardRepayTableView : TLTableView<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>
@property (nonatomic,strong) RepayModel * model;
@property (nonatomic,strong) NSMutableArray * picarr;
@end

NS_ASSUME_NONNULL_END
