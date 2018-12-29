//
//  CarSettledInTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"

@interface CarSettledInTableView : TLTableView

@property (nonatomic , strong)NSMutableArray <AccessSingleModel *>*model;
@end
