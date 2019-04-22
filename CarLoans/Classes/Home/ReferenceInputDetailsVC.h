//
//  ReferenceInputDetailsVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/19.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "SurveyModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^CreditListBlock)(NSDictionary *creditListDic, NSInteger row);

@interface ReferenceInputDetailsVC : BaseViewController

@property (nonatomic , strong)NSDictionary *dataDic;

@property (nonatomic,copy) CreditListBlock creditListBlock;

@property (nonatomic , assign)NSInteger row;

@property (nonatomic , strong)NSDictionary *creditListDic;

@end

NS_ASSUME_NONNULL_END
