//
//  ImproveInformationTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImproveInformationTableView : TLTableView



@property (nonatomic , strong)NSString *education;
@property (nonatomic , strong)NSString *nowAddressProvince;
@property (nonatomic , strong)NSString *nowAddressCity;
@property (nonatomic , strong)NSString *nowAddressArea;
@property (nonatomic , strong)NSString *nowAddress;

@property (nonatomic , strong)NSString *nowAddressMobile;

@property (nonatomic , strong)NSString *nowAddressDate;
@property (nonatomic , strong)NSString *nowAddressState;
@property (nonatomic , strong)NSString *marryState;
@property (nonatomic , strong)NSString *nowHouseType;
@property (nonatomic , strong)NSString *companyName;
@property (nonatomic , strong)NSString *companyProvince;
@property (nonatomic , strong)NSString *companyCity;
@property (nonatomic , strong)NSString *companyArea;
@property (nonatomic , strong)NSString *companyAddress;
@property (nonatomic , strong)NSString *workCompanyProperty;
@property (nonatomic , strong)NSString *workDatetime;
@property (nonatomic , strong)NSString *position;
@property (nonatomic , strong)NSString *yearIncome;
@property (nonatomic , strong)NSString *presentJobYears;
@property (nonatomic , strong)NSString *permanentType;
@property (nonatomic , assign)BOOL isDetails;

@end

NS_ASSUME_NONNULL_END
