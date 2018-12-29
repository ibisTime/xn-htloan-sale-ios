//
//  VehiclesInDetailsTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
@interface VehiclesInDetailsTableView : TLTableView
@property (nonatomic , strong)AccessSingleModel *model;

@end
