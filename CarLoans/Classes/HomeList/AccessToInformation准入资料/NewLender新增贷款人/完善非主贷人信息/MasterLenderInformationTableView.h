//
//  MasterLenderInformationTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/1.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MasterLenderInformationTableView : TLTableView
@property (nonatomic , assign)BOOL isDetails;

@property (nonatomic , strong)NSString *companyName;
@property (nonatomic , strong)NSString *position;
@property (nonatomic , strong)NSString *nowAddress;
@property (nonatomic , strong)NSString *companyAddress;
@property (nonatomic , strong)NSString *relation;

@end

NS_ASSUME_NONNULL_END
