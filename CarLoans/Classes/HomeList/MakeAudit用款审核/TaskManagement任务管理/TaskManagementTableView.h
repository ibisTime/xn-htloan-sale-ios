//
//  TaskManagementTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TaskManagementTableView : TLTableView
@property (nonatomic , strong)NSArray *missionList;
@property (nonatomic , strong)NSArray *saleUserIdAry;
@end

NS_ASSUME_NONNULL_END
