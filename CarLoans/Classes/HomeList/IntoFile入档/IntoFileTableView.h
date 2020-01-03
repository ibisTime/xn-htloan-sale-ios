//
//  IntoFileTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnPhotoAryBlock)(NSArray *imgAry,NSString *name,NSInteger section);

@interface IntoFileTableView : TLTableView
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , copy)NSString *archivesCode;
@property (nonatomic , copy)NSString *syxDateStart;
@property (nonatomic , copy)NSString *syxDateEnd;
@property (nonatomic , copy)NSString *enterLocation;
@property (nonatomic , copy)NSString *insuranceCompany;
@property (nonatomic, copy) ReturnPhotoAryBlock returnAryBlock;
@end

NS_ASSUME_NONNULL_END
