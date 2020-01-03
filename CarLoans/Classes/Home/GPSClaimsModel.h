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
@property (nonatomic , strong)NSString *customerName;
@property (nonatomic , strong)NSString *applyWiredCount;
@property (nonatomic , strong)NSString *applyWirelessCount;
@property (nonatomic , strong)NSString *mobile;
@property (nonatomic,strong) NSArray * gpsList;
@property (nonatomic,strong) NSString * roleName;
@property (nonatomic,strong) NSString * teamCode;
@property (nonatomic,strong) NSString * teamName;

@property (nonatomic,strong) NSString * remark;

/*
 applyCount: 3
 applyDatetime: "May 23, 2019 5:38:12 PM"
 applyReason: "详细"
 applyUser: "U201905211103072136918"
 applyUserName: "王磊"
 applyWiredCount: 1
 applyWirelessCount: 2
 code: "GA201905231738120404713"
 companyCode: "DP201800000000000000001"
 companyName: "温州浩源有限公司"
 gpsList: []
 roleName: "超级管理员"
 status: "0"
 teamCode: "BT201905181328458463400"
 teamName: "柴运来团队"
 type: "2"
 
 
 */



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
