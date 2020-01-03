//
//  HomeListVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeListVC : BaseViewController

@property (nonatomic , assign)NSInteger selectRow;
@property (nonatomic , strong)NSArray *curNodeCodeList;

@end

NS_ASSUME_NONNULL_END
