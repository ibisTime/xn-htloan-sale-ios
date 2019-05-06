//
//  CheckTableView2.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "TaskCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CheckTableView2 : TLTableView<UITableViewDelegate,UITableViewDataSource,TaskDelegate>
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic,strong) NSMutableArray * taskArray;
@end

NS_ASSUME_NONNULL_END
