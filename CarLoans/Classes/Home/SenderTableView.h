//
//  SenderTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "DataTransferModel.h"
#import "TLTextField.h"
@interface SenderTableView : TLTableView

@property (nonatomic , strong)DataTransferModel *model;

@property (nonatomic , copy)NSString *distributionStr;

@property (nonatomic , copy)NSString *CourierCompanyStr;


@property (nonatomic , copy)NSString *date;

@property (nonatomic , copy)NSString *cardStr;

@property (nonatomic , strong)NSMutableArray *cardList;

@property (nonatomic , strong)TLTextField *remarkField;

@property (nonatomic , strong)TLTextField *remarkKuaiField;

@property (nonatomic , strong)TLTextField *kuaidField;

@property (nonatomic , copy)NSString *tempRemark;

@property (nonatomic , copy)NSString *tempDate;

@property (nonatomic , copy)NSString *tempdan;



@end
