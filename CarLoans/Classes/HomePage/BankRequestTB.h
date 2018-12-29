//
//  BankRequestTB.h
//  CarLoans
//
//  Created by shaojianfei on 2018/11/14.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"

@interface BankRequestTB : TLTableView
@property (nonatomic , strong)AccessSingleModel *model;
@property (nonatomic , copy)NSString *date;
//绿大本扫描件
@property (nonatomic , strong)NSArray *GreenBigBenArray;
@end
