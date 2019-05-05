//
//  ProductUsInputVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/5.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "TextFieldCell.h"
#import "ChooseCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductUsInputVC : BaseViewController
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , strong)NSMutableArray *bankCreditReport;
@property (nonatomic , strong)NSMutableArray *dataCreditReport;
@end

NS_ASSUME_NONNULL_END
