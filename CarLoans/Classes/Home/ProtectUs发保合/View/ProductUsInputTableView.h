//
//  ProductUsInputTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/5.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "TextFieldCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductUsInputTableView : TLTableView
@property (nonatomic , strong)SurveyModel *model;

@property (nonatomic , strong)NSArray *bankCreditReport;
@property (nonatomic , strong)NSArray *dataCreditReport;
@property (nonatomic , strong)NSDictionary *dataDic;
@property (nonatomic , copy)NSString *bankResult;
@property (nonatomic , copy)NSString *creditNote;
@property (nonatomic , copy)NSString *creditCardOccupation;

@property (nonatomic,strong) NSArray * carSettleOtherPdf;//其它资料
@property (nonatomic,strong) NSArray * carSyx;//商业险
@property (nonatomic,strong) NSArray * carJqx;//交强险
@property (nonatomic,strong) NSArray * carInvoice;//发票
@property (nonatomic,strong) NSArray * carHgzPic;//合格证

@property (nonatomic,strong) NSString * policyDatetime;
@property (nonatomic,strong) NSString * policyDueDate;

@property (nonatomic , strong)TextFieldCell *cell;
@end

NS_ASSUME_NONNULL_END
