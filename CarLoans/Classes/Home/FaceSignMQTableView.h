//
//  FaceSignMQTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

@interface FaceSignMQTableView : TLTableView

//银行视频
@property (nonatomic , strong)NSArray *BankVideoArray;
//公司视频
@property (nonatomic , strong)NSArray *CompanyVideoArray;
//其他视频
@property (nonatomic , strong)NSArray *OtherVideoArray;

//银行面签照片
@property (nonatomic , strong)NSArray *BankSignArray;
//银行合同照片
@property (nonatomic , strong)NSArray *BankContractArray;
//公司合同照片
@property (nonatomic , strong)NSArray *CompanyContractArray;
//资金划转授权书
@property (nonatomic , strong)NSArray *MoneyArray;
//其他资料
@property (nonatomic , strong)NSArray *otherArray;

@property (nonatomic , strong)NSString *Str1;
@property (nonatomic , strong)NSString *Str2;
@property (nonatomic , strong)NSString *Str3;
@property (nonatomic , strong)NSString *Str4;
@property (nonatomic , strong)NSString *Str5;


@end
