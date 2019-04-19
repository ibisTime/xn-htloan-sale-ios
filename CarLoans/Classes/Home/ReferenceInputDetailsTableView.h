//
//  ReferenceInputDetailsTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/19.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReferenceInputDetailsTableView : TLTableView
@property (nonatomic , strong)NSArray *bankCreditReport;
@property (nonatomic , strong)NSArray *dataCreditReport;
@end

NS_ASSUME_NONNULL_END
