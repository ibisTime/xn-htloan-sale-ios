//
//  GreenlistCell.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GreenlistCell : UITableViewCell
@property (nonatomic,strong) UIButton * button;
@property (nonatomic,strong) NSArray * LeftTitle;
@property (nonatomic,strong) NSArray * RightTitle;
@end

NS_ASSUME_NONNULL_END
