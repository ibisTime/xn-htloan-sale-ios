//
//  MenuTableView4.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuTableView4 : TLTableView

@property (nonatomic , strong)SurveyModel *model;

@property (nonatomic , strong)NSString *code;
@property (nonatomic , strong)NSString *loanAmount;
@property (nonatomic , strong)NSString *periods;
@property (nonatomic , strong)NSString *bankRate;
@property (nonatomic , strong)NSString *totalRate;
@property (nonatomic , strong)NSString *rebateRate;
@property (nonatomic , strong)NSString *fee;
@property (nonatomic , strong)NSString *rateType;
@property (nonatomic , strong)NSString *isAdvanceFund;
@property (nonatomic , strong)NSString *isDiscount;
@property (nonatomic , strong)NSString *discountRate;
@property (nonatomic , strong)NSString *discountAmount;
@property (nonatomic , strong)NSString *loanRatio;
@property (nonatomic , strong)NSString *wanFactor;
@property (nonatomic , strong)NSString *monthAmount;
@property (nonatomic , strong)NSString *repayFirstMonthAmount;
@property (nonatomic , strong)NSString *highCashAmount;
@property (nonatomic , strong)NSString *totalFee;
@property (nonatomic , strong)NSString *customerBearRate;
@property (nonatomic , strong)NSString *surchargeRate;
@property (nonatomic , strong)NSString *surchargeAmount;
@property (nonatomic , strong)NSString *openCardAmount;
@property (nonatomic , strong)NSString *notes;


@property (nonatomic , assign)BOOL isLoadData;

@property (nonatomic , assign)BOOL isDetails;
@end

NS_ASSUME_NONNULL_END
