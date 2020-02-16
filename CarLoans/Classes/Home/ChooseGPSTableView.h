//
//  ChooseGPSTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChooseGPSTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray <SurveyModel *>* model;

@property (nonatomic,strong) NSArray * chooseArray;

@end

NS_ASSUME_NONNULL_END
