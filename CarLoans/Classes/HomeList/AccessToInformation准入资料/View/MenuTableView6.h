//
//  MenuTableView6.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuTableView6 : TLTableView

@property (nonatomic , strong)NSMutableArray *gpsAry;
@property (nonatomic , strong)NSMutableArray *gpsPhotoAry;

@property (nonatomic , strong)NSString *regDate;
@property (nonatomic , strong)NSString *isAzGps;
@property (nonatomic , strong)NSString *regAddress;
@property (nonatomic , strong)NSString *isPublicCard;
@property (nonatomic , assign)BOOL isDetails;

@property (nonatomic , strong)SurveyModel *model;
@end

NS_ASSUME_NONNULL_END
