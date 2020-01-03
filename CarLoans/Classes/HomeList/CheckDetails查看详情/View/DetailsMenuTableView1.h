//
//  DetailsMenuTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/31.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsMenuTableView1 : TLTableView
@property (nonatomic , strong)SurveyModel *model;

@property (nonatomic , copy)NSString *loanBankCode;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *region;
@property (nonatomic , copy)NSString *bizType;
@property (nonatomic , copy)NSString *regDate;
@property (nonatomic , copy)NSString *mile;
@property (nonatomic , copy)NSString *secondCarReport;
@property (nonatomic , copy)NSString *carBrand;
@property (nonatomic , copy)NSString *carSeries;
@property (nonatomic , copy)NSString *carModel;
@property (nonatomic , copy)NSString *shopCarGarage;
@property (nonatomic , copy)NSString *saleUserId;

@end

NS_ASSUME_NONNULL_END
