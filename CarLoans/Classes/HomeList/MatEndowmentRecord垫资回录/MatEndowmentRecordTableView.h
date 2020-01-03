//
//  MatEndowmentRecordTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnPhotoAryBlock)(NSArray *imgAry,NSString *name,NSInteger section);

@interface MatEndowmentRecordTableView : TLTableView
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , strong)NSString *advanceFundDatetime;

@property (nonatomic, copy) ReturnPhotoAryBlock returnAryBlock;
//@property (nonatomic , strong)NSString *currentTimeString;
@end

NS_ASSUME_NONNULL_END
