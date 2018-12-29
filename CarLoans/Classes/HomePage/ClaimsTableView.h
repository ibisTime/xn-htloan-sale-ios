//
//  ClaimsTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
@interface ClaimsTableView : TLTableView
@property (nonatomic ,strong) AccessSingleModel *model;

@property (nonatomic ,assign) BOOL  isList;

@property (nonatomic ,copy) NSString *teamStr;
@property (nonatomic ,copy) NSString *teamname;

@end
