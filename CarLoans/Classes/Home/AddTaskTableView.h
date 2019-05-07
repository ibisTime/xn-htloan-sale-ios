//
//  AddTaskTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddTaskTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)NSDictionary *dataDic;

@property (nonatomic , assign)NSInteger selectRow;

@property (nonatomic , assign)BOOL isFirstEntry;
@property (nonatomic , copy)NSString *state;
@end

NS_ASSUME_NONNULL_END
