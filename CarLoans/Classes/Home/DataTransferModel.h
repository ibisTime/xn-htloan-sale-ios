//
//  DataTransferModel.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataTransferModel : NSObject
@property (nonatomic , copy) NSString *userRole;
@property (nonatomic,strong) NSString * curNodeCode;
@property (nonatomic , copy)NSString *insideJob;
@property (nonatomic , copy)NSString *budgetCode;
@property (nonatomic , copy)NSString *logisticsCompany;
@property (nonatomic , copy)NSString *userId;
@property (nonatomic , copy)NSString *bizCode;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *logisticsCode;
@property (nonatomic , copy)NSString *toNodeCode;
@property (nonatomic , copy)NSString *sendDatetime;
@property (nonatomic , copy)NSString *fromNodeCode;
@property (nonatomic , copy)NSString *sendType;
@property (nonatomic , copy)NSString *receiptDatetime;
@property (nonatomic , copy)NSString *type;
@property (nonatomic , copy)NSString *refFileList;
@property (nonatomic , copy)NSString *sendFileList;
@property (nonatomic , copy)NSString *receiver;
@property (nonatomic , copy)NSString *teamCode;
@property (nonatomic , copy)NSString *userName;
@property (nonatomic , copy)NSString *remark;
@property (nonatomic , copy)NSString *customerName;
@property (nonatomic , copy)NSString *sendNote;
@property (nonatomic , copy)NSString *receiverName;
@property (nonatomic , copy)NSString *senderName;
@property (nonatomic , copy)NSString *sender;
@property (nonatomic , copy)NSString *teamName;
@property (nonatomic , copy)NSString *saleUserName;
@property (nonatomic , copy)NSString *insideJobName;
@property (nonatomic , strong) NSDictionary *gpsApply;
@property (nonatomic , copy) NSString *carFrameNo;
@property (nonatomic , copy) NSString *filelist;
@property (nonatomic,strong) NSString * applyWiredCount;
@property (nonatomic,strong) NSString * applyWirelessCount;
@property (nonatomic,strong) NSArray * gpsList;

/*
 bizCode: "GA201905231738120404713"
 code: "L201905232014418023528"
 gpsApply: {code: "GA201905231738120404713", type: "2", companyCode: "DP201800000000000000001",…}
 logisticsCode: ""
 logisticsCompany: ""
 receiptDatetime: "May 23, 2019 8:15:46 PM"
 receiver: "U201905211103072136918"
 receiverName: "王磊"
 fsendDatetime: "May 23, 2019 8:15:31 PM"
 sendNote: ""
 sendType: "1"
 sender: "USYS201800000000001"
 senderName: "admin"
 status: "2"
 teamCode: "BT201905181328458463400"
 teamName: "柴运来团队"
 type: "2"
 userId: "U201905211103072136918"
 userName: "王磊"
 userRole: "超级管理员"
 */


@end
