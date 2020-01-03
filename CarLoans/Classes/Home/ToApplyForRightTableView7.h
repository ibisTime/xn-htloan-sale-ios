//
//  ToApplyForRightTableView7.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnAryBlock)(NSArray *imgAry,NSString *name);
@interface ToApplyForRightTableView7 : TLTableView
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic, copy) ReturnAryBlock returnAryBlock;
@property (nonatomic , strong)NSArray *otherPic;
@property (nonatomic , strong)NSArray *otherPic1;
@end

NS_ASSUME_NONNULL_END
