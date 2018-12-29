//
//  GPSClaimsModel.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSClaimsModel : NSObject

@property (nonatomic , assign)NSInteger status;
@property (nonatomic , strong)NSString *applyUserName;
@property (nonatomic , strong)NSString *applyReason;
@property (nonatomic , strong)NSString *code;
@property (nonatomic , strong)NSString *companyCode;
@property (nonatomic , strong)NSString *applyUser;
@property (nonatomic , strong)NSString *applyCount;
@property (nonatomic , strong)NSString *type;
@property (nonatomic , strong)NSString *companyName;
@property (nonatomic , strong)NSString *applyDatetime;
//"status" : "0",
//"applyUserName" : "郑",
//"applyReason" : "tyhhgg",
//"code" : "GA201808011459050585247",
//"companyCode" : "DP201806231737515317492",
//"applyUser" : "U201807161731162594497",
//"applyCount" : 22,
//"type" : "2",
//"companyName" : "温州子公司",
//"applyDatetime" : "Aug 1, 2018 2:59:05 PM"

@end
