//
//  FaceSignAuditTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FaceSignAuditTableView : TLTableView
@property (nonatomic , strong)SurveyModel *model;
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
@end

NS_ASSUME_NONNULL_END
