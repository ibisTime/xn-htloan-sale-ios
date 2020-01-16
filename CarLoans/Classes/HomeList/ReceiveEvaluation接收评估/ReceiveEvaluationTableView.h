//
//  ReceiveEvaluationTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/16.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReceiveEvaluationTableView : TLTableView
@property (nonatomic , strong)SurveyModel *model;

@property (nonatomic , strong)NSArray *carRegisterCertificateFirst;
@property (nonatomic , strong)NSArray *policy;
@property (nonatomic , strong)NSArray *carInvoice;
@property (nonatomic , strong)NSArray *driveLicense;
@property (nonatomic , strong)NSString *idReverse;
@property (nonatomic , strong)NSString *idFront;
@property (nonatomic , strong)NSString *holdIdCardPdf;
@end

NS_ASSUME_NONNULL_END
