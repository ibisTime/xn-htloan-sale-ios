//
//  InsideMortgageTB.h
//  CarLoans
//
//  Created by shaojianfei on 2018/11/13.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
#import "UploadIdCardCell.h"
@protocol SelectButtonDelegate <NSObject>

-(void)selectButtonClick:(UIButton *)sender;

@end
@interface InsideMortgageTB : TLTableView<UploadIdCardDelegate>
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

@property (nonatomic , strong)AccessSingleModel *model;

@property (nonatomic,weak) id<SelectButtonDelegate> AgentDelegate;
//    身份证正面
@property (nonatomic , copy)NSString *idNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *idNoReverse;

@end
