//
//  NewWaterCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/2.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, UICellType) {
    UIInputType = 0,    //输入
    UIChooseType,    //选择
    UIShowType,  //展示
};

@interface NewWaterCell : UITableViewCell
@property (nonatomic, assign) UICellType type;
@property (nonatomic , strong)UILabel *topLbl;

@property (nonatomic , strong)UITextField *inputTextField;
@property (nonatomic , strong)UILabel *showLbl;
@property (nonatomic , strong)UILabel *chooseLbl;

@property (nonatomic , copy)NSString *bottomStr;

@end

NS_ASSUME_NONNULL_END
