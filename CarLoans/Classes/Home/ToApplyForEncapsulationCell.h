//
//  ToApplyForEncapsulationCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, UIType) {
    InputType = 0,    //输入
    ChooseType,    //选择
    ShowType,  //展示
};

@interface ToApplyForEncapsulationCell : UITableViewCell

@property (nonatomic, assign) UIType type;
@property (nonatomic , strong)UILabel *topLbl;

@property (nonatomic , strong)UITextField *inputTextField;
@property (nonatomic , strong)UILabel *showLbl;
@property (nonatomic , strong)UILabel *chooseLbl;

@property (nonatomic , copy)NSString *bottomStr;

@end

NS_ASSUME_NONNULL_END
