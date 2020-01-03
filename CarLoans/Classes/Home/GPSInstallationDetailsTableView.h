//
//  GPSInstallationDetailsTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "GPSInstallationModel.h"
@interface GPSInstallationDetailsTableView : TLTableView

@property (nonatomic , strong)GPSInstallationModel *model;

@property (nonatomic , strong)NSArray *peopleAray;

@end
