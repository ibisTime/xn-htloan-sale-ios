//
//  CheckFileTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/13.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "TaskCell.h"
#import "FileCell.h"
#import "FileModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CheckFileTableView : TLTableView<UITableViewDataSource,UITableViewDelegate,TaskDelegate>
@property (nonatomic,strong) AccessSingleModel * model;
@property (nonatomic,strong) NSMutableArray * FileArray;
@property (nonatomic,strong) NSMutableArray<FileModel *> * filemodels;
@property (nonatomic,strong) NSString * filelocation;
@property (nonatomic,strong) NSString * enterCode;
@property (nonatomic,strong) NSString * location;
@end

NS_ASSUME_NONNULL_END
