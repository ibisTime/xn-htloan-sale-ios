//
//  InputInformationMortgageTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
@interface InputInformationMortgageTableView : TLTableView
@property (nonatomic , strong)AccessSingleModel *model;
@property (nonatomic , copy)NSString *date;
//绿大本扫描件
@property (nonatomic , strong)NSArray *GreenBigBenArray;
@end
