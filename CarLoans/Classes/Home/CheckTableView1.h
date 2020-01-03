//
//  CheckTableView1.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckTableView1 : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic,strong) NSString * state;
@end

NS_ASSUME_NONNULL_END
