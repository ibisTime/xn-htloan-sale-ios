//
//  DriveCardCell.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol DriveCardDelegate <NSObject>

-(void)DriceCardBtn:(UIButton *)sender;

-(void)SelectButtonClick:(UIButton *)sender;

@end
@interface DriveCardCell : UITableViewCell
@property (nonatomic, assign) id <DriveCardDelegate> IdCardDelegate;

//    身份证正面
@property (nonatomic , copy)NSString *idNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *idNoReverse;

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UIButton *photoBtn;

@property (nonatomic , strong)UIImageView *photoImage;
@end

NS_ASSUME_NONNULL_END
