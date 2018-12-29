//
//  CarSettledInDetailsTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
@interface CarSettledInDetailsTableView : TLTableView

@property (nonatomic , strong)AccessSingleModel *model;


@property (nonatomic , copy)NSString *date;
@property (nonatomic , copy)NSString *date1;
@property (nonatomic , copy)NSString *date2;
@property (nonatomic , copy)NSString *date3;

//发票
@property (nonatomic , strong)NSArray *invoiceArray;
//交强险
@property (nonatomic , strong)NSArray *insuranceArray;
//商业险
@property (nonatomic , strong)NSArray *BusinessRisksArray;
//其他
@property (nonatomic , strong)NSArray *otherArray;
//绿大本
@property (nonatomic , strong)NSMutableArray *greenDataArray;

@end
