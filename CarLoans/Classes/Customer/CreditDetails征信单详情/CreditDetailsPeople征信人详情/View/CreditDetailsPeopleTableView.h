//
//  CreditDetailsPeopleTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreditDetailsPeopleTableView : TLTableView

@property (nonatomic , strong)NSDictionary *dataDic;
//授权书
@property (nonatomic , strong)NSArray *authPdf;
//面签
@property (nonatomic , strong)NSArray *interviewPic;

@end

NS_ASSUME_NONNULL_END
