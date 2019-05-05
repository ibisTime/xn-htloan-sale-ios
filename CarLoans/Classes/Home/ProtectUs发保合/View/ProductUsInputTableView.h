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

@property (nonatomic,strong) NSMutableArray * carSettleOtherPdf;//其它资料
@property (nonatomic,strong) NSMutableArray * carSyx;//商业险
@property (nonatomic,strong) NSMutableArray * carJqx;//交强险
@property (nonatomic,strong) NSMutableArray * carInvoice;//发票
@property (nonatomic,strong) NSMutableArray * carHgzPic;//合格证

@property (nonatomic , strong)TextFieldCell *cell;
@end

NS_ASSUME_NONNULL_END
