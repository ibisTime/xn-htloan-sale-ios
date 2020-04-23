//
//  DetailsMenuTableView2.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/31.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsMenuTableView2 : TLTableView
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , strong)NSArray *credit_user_loan_roleArray;
@property (nonatomic , strong)NSArray *creditUserList;
@property (nonatomic , assign)BOOL isDetails;
@end

NS_ASSUME_NONNULL_END
