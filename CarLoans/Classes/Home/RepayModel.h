//
//  RepayModel.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepayModel : NSObject
@property (nonatomic,strong) NSDictionary * user;
@property (nonatomic,strong) NSArray * repayPlanList;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * bizCode;
@property (nonatomic,copy) NSString * loanProductCode;
@property (nonatomic,copy) NSString * loanProductName;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * realName;
@property (nonatomic,copy) NSString * idNo;
@property (nonatomic,copy) NSString * refType;
@property (nonatomic,copy) NSString * refCode;
@property (nonatomic,copy) NSString * sfRate;
@property (nonatomic,copy) NSString * sfAmount;
@property (nonatomic,copy) NSString * loanAmount;
@property (nonatomic,copy) NSString * periods;
@property (nonatomic,copy) NSString * restPeriods;
@property (nonatomic,copy) NSString * bankRate;
@property (nonatomic,copy) NSString * bankFkDatetime;
@property (nonatomic,copy) NSString * firstRepayDatetime;
@property (nonatomic,copy) NSString * firstRepayAmount;
@property (nonatomic,copy) NSString * monthDatetime;
@property (nonatomic,copy) NSString * monthAmount;
@property (nonatomic,copy) NSString * lyDeposit;
@property (nonatomic,copy) NSString * curNodeCode;
@property (nonatomic,copy) NSString * restAmount;
@property (nonatomic,copy) NSString * restTotalCost;
@property (nonatomic,copy) NSString * overdueAmount;
@property (nonatomic,copy) NSString * totalOverdueCount;
@property (nonatomic,copy) NSString * curOverdueCount;
@property (nonatomic,copy) NSString * loanBalance;
@property (nonatomic,copy) NSString * retreatDeposit;
@property (nonatomic,copy) NSString * loanBankName;
@property (nonatomic,copy) NSString * curPeriods;
@property (nonatomic,copy) NSString * repayDatetime;
@property (nonatomic,strong) NSDictionary * repayBiz;
@property (nonatomic,copy) NSString * repayAmount;

@end

NS_ASSUME_NONNULL_END
