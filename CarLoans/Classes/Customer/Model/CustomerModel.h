//
//  CustomerModel.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomerModel : NSObject

@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *bankCode;
@property (nonatomic , copy)NSString *bizType;
@property (nonatomic , copy)NSString *dkAmount;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *zfStatus;
@property (nonatomic , copy)NSString *ywyUser;
@property (nonatomic , copy)NSString *teamCode;
@property (nonatomic , copy)NSString *applyDatetime;
@property (nonatomic , copy)NSString *loanBankName;
@property (nonatomic , copy)NSString *loanAmount;
@property (nonatomic , strong)NSDictionary *credit;
@property (nonatomic , strong)NSArray *attachments;
@property (nonatomic , strong)NSArray *bizTasks;
@property (nonatomic , strong)NSArray *bizLogs;
@property (nonatomic , strong)NSDictionary *creditUser;
//"code":"cb201904121733567164846",
//"bankCode":"BA201811051330406186135",
//"bizType":"1",
//"dkAmount":111111000,
//"status":"001",
//"zfStatus":"0",
//"ywyUser":"USYS201800000000001",
//"teamCode":"BT201812010242065583765",
//"credit":Object{...},
//"attachments":Array[4],
//"bizTasks":Array[1],
//"bizLogs":Array[161]


@end

NS_ASSUME_NONNULL_END
