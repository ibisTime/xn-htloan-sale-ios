//
//  HomeListCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeListCell : UITableViewCell
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , strong)NSString *pledgeNodeCode;
@end

NS_ASSUME_NONNULL_END
