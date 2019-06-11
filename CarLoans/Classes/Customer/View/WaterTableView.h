//
//  WaterTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/11.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WaterTableView : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)NSDictionary *waterDic;
@property (nonatomic , strong)SurveyModel *model;
@end

NS_ASSUME_NONNULL_END
