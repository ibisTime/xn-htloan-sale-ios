//
//  AddTaskVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
typedef void (^ReturnMissionBlock)(NSDictionary *missionDic,NSInteger row);
NS_ASSUME_NONNULL_BEGIN

@interface AddTaskVC1 : BaseViewController

@property (nonatomic , strong)NSDictionary *dataDic;

@property (nonatomic, copy) ReturnMissionBlock returnAryBlock;

@property (nonatomic , assign)NSInteger row;

@end

NS_ASSUME_NONNULL_END
