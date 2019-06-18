//
//  TongDunTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TongDunTableView : UITableView
@property (nonatomic,strong) NSDictionary * tongdunResult;
@property (nonatomic,strong) NSArray * risk_items;
@end

NS_ASSUME_NONNULL_END
