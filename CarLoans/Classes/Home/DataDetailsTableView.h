//
//  DataDetailsTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/29.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "DataTransferModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DataDetailsTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)DataTransferModel *model;
@property (nonatomic,strong) NSMutableArray * filearray;
@end

NS_ASSUME_NONNULL_END
