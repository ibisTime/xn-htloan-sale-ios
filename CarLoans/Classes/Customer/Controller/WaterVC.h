//
//  WaterVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/11.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "WaterTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WaterVC : BaseViewController
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , strong)NSDictionary *waterDic;
@end

NS_ASSUME_NONNULL_END
