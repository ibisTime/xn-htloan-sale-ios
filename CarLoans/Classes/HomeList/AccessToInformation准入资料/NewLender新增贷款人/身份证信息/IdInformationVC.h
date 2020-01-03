//
//  IdInformationVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^IdCardInfoBlock)(NSDictionary *creditUserDic);

@interface IdInformationVC : BaseViewController
@property (nonatomic, copy) IdCardInfoBlock returnAryBlock;
//@property (nonatomic , strong)NSDictionary *idFrontDic;
//@property (nonatomic , strong)NSDictionary *idReverseDic;
@property (nonatomic , strong)NSString *userName;
@property (nonatomic , strong)NSString *nation;
@property (nonatomic , strong)NSString *gender;
@property (nonatomic , strong)NSString *customerBirth;
@property (nonatomic , strong)NSString *idNo;
@property (nonatomic , strong)NSString *birthAddress;
@property (nonatomic , strong)NSString *authref;
@property (nonatomic , strong)NSString *statdate;
@property (nonatomic , strong)NSString *startDate;

@property (nonatomic , assign)BOOL isDetails;


@end

NS_ASSUME_NONNULL_END
