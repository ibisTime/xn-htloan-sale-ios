//
//  AdmissionDetailsTableView8.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AdmissionDetailsTableView8 : TLTableView
@property (nonatomic , strong)SurveyModel *model;

@property (nonatomic , strong)NSArray *bank_video;
@property (nonatomic , strong)NSArray *company_video;
@property (nonatomic , strong)NSArray *other_video;
@property (nonatomic , strong)NSArray *bank_photo;
@property (nonatomic , strong)NSArray *bank_contract;
@property (nonatomic , strong)NSArray *company_contract;
@property (nonatomic , strong)NSArray *advance_fund_amount_pdf;
@property (nonatomic , strong)NSArray *interview_other_pdf;

@end

NS_ASSUME_NONNULL_END
