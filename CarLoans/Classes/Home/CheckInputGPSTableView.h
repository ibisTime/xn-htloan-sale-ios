//
//  CheckInputGPSTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "GPSClaimsModel.h"
#import "AddGPSCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CheckInputGPSTableView : TLTableView<UITableViewDelegate,UITableViewDataSource,GPSDelegate>
@property (nonatomic , strong)GPSClaimsModel *model;
@property (nonatomic,strong) NSArray * gpsArray;

@end

NS_ASSUME_NONNULL_END
