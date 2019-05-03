//
//  ToApplyForRightTableView5.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnAryBlock)(NSArray *imgAry,NSString *name);
@interface ToApplyForRightTableView5 : TLTableView
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic, copy) ReturnAryBlock returnAryBlock;
// 收入证明
@property (nonatomic , strong)NSArray *improvePdf;
// 单位前台照片
@property (nonatomic , strong)NSArray *frontTablePic;
// 单位场地照片
@property (nonatomic , strong)NSArray *workPlacePic;
// 业务员与客户合影
@property (nonatomic , strong)NSArray *salerAndcustomer;
@end

NS_ASSUME_NONNULL_END
