//
//  CheckCarTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "UploadIdCardCell.h"
#define UploadIdCard @"UploadIdCardCell"
NS_ASSUME_NONNULL_BEGIN

@interface CheckCarTableView : TLTableView<UITableViewDataSource,UITableViewDelegate,UploadIdCardDelegate,CustomCollectionDelegate>
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , copy)NSString *date;

//    身份证正面
@property (nonatomic , copy)NSString *idNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *idNoReverse;

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
