//
//  SignVideoVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignVideoVC : BaseViewController
@property (nonatomic,strong) NSMutableArray * Array;
//银行视频
@property (nonatomic , strong)NSArray *BankVideoArray;
//公司视频
@property (nonatomic , strong)NSArray *CompanyVideoArray;
//身份证正面
@property (nonatomic,strong) NSArray * idfront;
//身份证反面
@property (nonatomic,strong) NSArray * idreverse;
@end

NS_ASSUME_NONNULL_END
