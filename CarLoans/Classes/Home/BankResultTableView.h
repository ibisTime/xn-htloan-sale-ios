//
//  BankResultTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BankResultTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)NSDictionary *dataDic;
@end

NS_ASSUME_NONNULL_END
