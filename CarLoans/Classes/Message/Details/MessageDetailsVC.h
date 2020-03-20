//
//  MessageDetailsVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "TodoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MessageDetailsVC : BaseViewController
@property (nonatomic , strong)TodoModel *model;
@property (nonatomic , assign)NSInteger index;
@end

NS_ASSUME_NONNULL_END
