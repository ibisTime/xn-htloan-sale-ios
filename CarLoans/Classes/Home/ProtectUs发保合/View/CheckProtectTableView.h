//
//  CheckProtectTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/5.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckProtectTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic,strong) NSArray * carSyx;//商业险
@property (nonatomic,strong) NSArray * carJqx;//交强险
@property (nonatomic,strong) NSArray * carInvoice;//发票
@property (nonatomic,strong) NSArray * carHgzPic;//合格证
@end

NS_ASSUME_NONNULL_END
