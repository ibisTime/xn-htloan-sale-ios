//
//  InputfilesVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/8.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "AccessSingleModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface InputfilesVC : BaseViewController
@property (nonatomic,strong) NSArray * curNodeCodeList;
@property (nonatomic , strong)NSMutableArray <AccessSingleModel *>*model;
@end

NS_ASSUME_NONNULL_END
