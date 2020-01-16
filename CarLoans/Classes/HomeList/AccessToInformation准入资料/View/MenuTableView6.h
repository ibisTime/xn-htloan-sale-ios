//
//  MenuTableView6.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnPhotoAryBlock)(NSArray *imgAry,NSString *name,NSInteger section);

@interface MenuTableView6 : TLTableView

@property (nonatomic, copy) ReturnPhotoAryBlock returnAryBlock;

@property (nonatomic , strong)NSMutableArray <SurveyModel *>*gpsAry;
@property (nonatomic , strong)NSMutableArray *gpsPhotoAry;
@property (nonatomic , copy)NSString *evalPrice;
@property (nonatomic , copy)NSString *originalPrice;
@property (nonatomic , copy)NSString *carNumber;
@property (nonatomic , copy)NSString *carFrameNo;
@property (nonatomic , copy)NSString *carEngineNo;

@property (nonatomic , copy)NSString *mile;
@property (nonatomic , copy)NSString *secondCarReport;
@property (nonatomic , strong)NSArray *driveLicense;
@property (nonatomic , copy)NSString *carBrand;
@property (nonatomic , copy)NSString *carSeries;
@property (nonatomic , copy)NSString *carModel;
@property (nonatomic , copy)NSString *shopCarGarage;

@property (nonatomic , strong)NSString *regDate;
@property (nonatomic , strong)NSString *isAzGps;
@property (nonatomic , strong)NSString *regAddress;
@property (nonatomic , strong)NSString *isPublicCard;
@property (nonatomic , assign)BOOL isDetails;
@property (nonatomic , copy)NSString *bizType;
@property (nonatomic , strong)SurveyModel *model;
@end

NS_ASSUME_NONNULL_END
