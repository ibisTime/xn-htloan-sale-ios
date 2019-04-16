//
//  SurvuyPeopleModel.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurvuyPeopleModel : NSObject


@property (nonatomic , copy)NSString *creditCode;
@property (nonatomic , copy)NSString *mobile;
//身份证
@property (nonatomic , copy)NSString *idNoFront;
@property (nonatomic , copy)NSString *idNoReverse;


@property (nonatomic , copy)NSString *loanRole;
@property (nonatomic , copy)NSString *bankCreditResultRemark;
@property (nonatomic , copy)NSString *authPdf;
@property (nonatomic , copy)NSString *code;
@property (nonatomic , copy)NSString *userName;
@property (nonatomic , copy)NSString *relation;
@property (nonatomic , copy)NSString *idNo;
@property (nonatomic , copy)NSString *bankCreditResultPdf;
@property (nonatomic , copy)NSString *creditCardOccupation;

@property (nonatomic , copy)NSString *interviewPic;

//授权书
@property (nonatomic , strong)NSArray *pics1;
//面签照片
@property (nonatomic , strong)NSArray *pics2;
//征信报告
@property (nonatomic , strong)NSArray *pics3;

//"idNoReverse" : "FqNG4fbHn0pM5jzqn7G0j2COLi7M",
//"creditCode" : "C201807091800465218250",
//"mobile" : "18868824532",
//"idNoFront" : "FqNG4fbHn0pM5jzqn7G0j2COLi7M",
//"loanRole" : "3",
//"bankCreditResultRemark" : "征信结果说明\n",
//"authPdf" : "FqNG4fbHn0pM5jzqn7G0j2COLi7M",
//"code" : "CU201807091800465528456",
//"userName" : "八戒",
//"relation" : "8",
//"idNo" : "150606199809040312",
//"bankCreditResultPdf" : "FqNG4fbHn0pM5jzqn7G0j2COLi7M",
//"interviewPic" : "FqNG4fbHn0pM5jzqn7G0j2COLi7M"

@end
