//
//  InputFilesTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/8.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface InputFilesTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)NSMutableArray <AccessSingleModel *>*model;
@property (nonatomic , assign)BOOL isCar;
@end

NS_ASSUME_NONNULL_END
