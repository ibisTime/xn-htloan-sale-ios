//
//  CreditResultsTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreditResultsTableView : TLTableView
@property (nonatomic , strong)NSArray *bankCreditReport;
@property (nonatomic , strong)NSArray *dataCreditReport;
@property (nonatomic , strong)NSDictionary *dataDic;
@property (nonatomic , copy)NSString *bankResult;

@property (nonatomic , copy)NSString *creditNote;
@end

NS_ASSUME_NONNULL_END
