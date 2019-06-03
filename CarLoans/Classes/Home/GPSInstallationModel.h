//
//  GPSInstallationModel.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPSInstallationModel : NSObject

@property (nonatomic , copy)NSString *code;

@property (nonatomic , copy)NSString *curNodeCode;

@property (nonatomic , copy)NSString *bizType;

@property (nonatomic , copy)NSString *applyUserName;

@property (nonatomic , copy)NSString *loanAmount;

@property (nonatomic , copy)NSString *loanBankName;

@property (nonatomic , copy)NSString *applyDatetime;

@property (nonatomic , copy)NSString *companyName;

@property (nonatomic , copy)NSString *carBrand;

@property (nonatomic , copy)NSString *advanfCurNodeCode;

@property (nonatomic , copy)NSString *fbhgpsNode;
@property (nonatomic , copy)NSString *operatorName;

@property (nonatomic , strong)NSDictionary *creditUser;
@property (nonatomic , strong)NSArray *creditUserList;
@property (nonatomic,strong) NSArray * budgetOrderGps;
@property (nonatomic , copy)NSString *teamName;
@property (nonatomic , copy)NSString *saleUserCompanyName;
@property (nonatomic , copy)NSString *saleUserDepartMentName;
@property (nonatomic , copy)NSString *saleUserPostName;
@property (nonatomic , copy)NSString *saleUserName;

@property (nonatomic,copy) NSString * insideJobCompanyName;
@property (nonatomic,copy) NSString * insideJobDepartMentName;
@property (nonatomic,copy) NSString * insideJobName;
@property (nonatomic,copy) NSString * insideJobPostName;

@property (nonatomic , copy)NSString *insideJob;
@property (nonatomic,copy) NSString * subbranchBankName;
@end
