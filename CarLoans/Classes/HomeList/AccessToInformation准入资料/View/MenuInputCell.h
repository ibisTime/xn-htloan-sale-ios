//
//  MenuInputCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, MenuType) {
    MenuInputType = 0,
    MenuPushType,
    MenuChooseType,
    MenuShowType,
    MenuCheckDetailsType,
    MenuCheckDetailsType1,
    
};

NS_ASSUME_NONNULL_BEGIN

@interface MenuInputCell : UITableViewCell
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic, assign) MenuType type;
@property (nonatomic, strong) UILabel *leftLbl;
@property (nonatomic, strong) UITextField *rightTF;
@property (nonatomic, strong) UIImageView *youImg;
@property (nonatomic, strong) UILabel *rightLbl;
@property (nonatomic, strong) UIButton *checkDetailsBtn;
@property (nonatomic, strong) UIButton *checkDetailsBtn1;

@property (nonatomic, copy)NSString *leftStr;
@property (nonatomic, copy)NSString *placStr;
@property (nonatomic, copy)NSString *rightStr;

@end

NS_ASSUME_NONNULL_END
