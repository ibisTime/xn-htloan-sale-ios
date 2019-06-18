//
//  ReFinancialTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReFinancialTableView : TLTableView<UITableViewDelegate,UITableViewDataSource,CustomCollectionDelegate>
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic,strong) NSMutableArray * carInvoice;//发票
@property (nonatomic , strong)NSArray *peopleAray;
@property (nonatomic,strong) NSArray * inarray;
@end

NS_ASSUME_NONNULL_END
