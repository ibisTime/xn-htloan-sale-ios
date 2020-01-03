//
//  MenuTableView3.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuTableView3 : TLTableView

@property (nonatomic , copy)NSString *emergencyName1;
@property (nonatomic , copy)NSString *emergencyRelation1;
@property (nonatomic , copy)NSString *emergencyMobile1;
@property (nonatomic , copy)NSString *emergencyName2;
@property (nonatomic , copy)NSString *emergencyRelation2;
@property (nonatomic , copy)NSString *emergencyMobile2;
@property (nonatomic , assign)BOOL isDetails;

@end

NS_ASSUME_NONNULL_END
