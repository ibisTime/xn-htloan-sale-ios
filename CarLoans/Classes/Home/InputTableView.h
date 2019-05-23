//
//  InputTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/11.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
//#import "TaskCell.h"
#import "FileCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface InputTableView : TLTableView<UITableViewDataSource,UITableViewDelegate,TaskDelegate>
@property (nonatomic,strong) AccessSingleModel * model;
@property (nonatomic,strong) NSMutableArray * FileArray;
@property (nonatomic,strong) NSString * location;
@end

NS_ASSUME_NONNULL_END
