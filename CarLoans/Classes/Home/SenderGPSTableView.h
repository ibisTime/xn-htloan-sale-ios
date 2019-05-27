//
//  SenderGPSTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "DataTransferModel.h"
#import "TLTextField.h"
NS_ASSUME_NONNULL_BEGIN

@interface SenderGPSTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
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

NS_ASSUME_NONNULL_END
