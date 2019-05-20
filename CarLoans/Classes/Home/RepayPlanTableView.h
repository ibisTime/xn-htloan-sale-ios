//
//  RepayPlanTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepayPlanTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) RepayModel * model;
@end

NS_ASSUME_NONNULL_END
