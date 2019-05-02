//
//  ToApplyForUpdateImgCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/29.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnAryBlock)(NSArray *imgAry,NSString *name);

@interface ToApplyForUpdateImgCell : UITableViewCell

@property (nonatomic , strong)UILabel *topLbl;
@property (nonatomic , strong)NSMutableArray *muArray;
@property (nonatomic, copy) ReturnAryBlock returnAryBlock;
@property (nonatomic , copy)NSString *name;
@end

NS_ASSUME_NONNULL_END
