//
//  SignCell.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignCell : UITableViewCell

@property (nonatomic , strong)UIButton *button;
@property (nonatomic,strong)UIButton *button1;
@property (nonatomic,strong)UIButton *button2;

@property (nonatomic , strong)UILabel *codeLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *InformationLabel;

@property (nonatomic , assign)BOOL  isGps;

@property (nonatomic , assign)BOOL  isXin;
@property (nonatomic , assign)BOOL isCar;

@property (nonatomic,assign) BOOL isFinancial;
@property (nonatomic,strong) SignModel * signModel;
@end

NS_ASSUME_NONNULL_END
