//
//  ListModel.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListModel : NSObject
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * refType;
@property (nonatomic,copy) NSString * repayBizCode;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * periods;
@property (nonatomic,copy) NSString * curPeriods;
@property (nonatomic,copy) NSString * repayDatetime;
@property (nonatomic,copy) NSString * repayCapital;
@property (nonatomic,copy) NSString * repayInterest;
@property (nonatomic,copy) NSString * repayAmount;
@property (nonatomic,copy) NSString * payedAmount;
@property (nonatomic,copy) NSString * overplusAmount;
@property (nonatomic,copy) NSString * overdueAmount;
@property (nonatomic,copy) NSString * curNodeCode;
@property (nonatomic,copy) NSString * totalFee;

@property (nonatomic,copy) NSString * payedFee;
@property (nonatomic,copy) NSString * overdueDeposit;
@property (nonatomic,copy) NSString * depositWay;
@property (nonatomic,copy) NSString * shouldDeposit;
@property (nonatomic,copy) NSString * remindCount;
@property (nonatomic,copy) NSString * realRepayAmount;
@property (nonatomic,copy) NSString * isRepay;
@property (nonatomic,copy) NSDictionary * user;
@property (nonatomic,copy) NSDictionary * repayBiz;

@end

NS_ASSUME_NONNULL_END
