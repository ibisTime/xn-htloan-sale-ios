//
//  LenderInformationCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LenderInformationCell : UITableViewCell
@property (nonatomic , strong)NSDictionary *dataDic;
@property (nonatomic , strong)NSArray *creditUserList;
@end

NS_ASSUME_NONNULL_END
