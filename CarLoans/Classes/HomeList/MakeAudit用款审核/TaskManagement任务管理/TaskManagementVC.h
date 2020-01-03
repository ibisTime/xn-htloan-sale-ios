//
//  TaskManagementVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnMissionBlock1)(NSArray *missionArray);

@interface TaskManagementVC : BaseViewController
@property (nonatomic , strong)NSArray *missionList;

@property (nonatomic, copy) ReturnMissionBlock1 returnAryBlock1;

@end

NS_ASSUME_NONNULL_END
