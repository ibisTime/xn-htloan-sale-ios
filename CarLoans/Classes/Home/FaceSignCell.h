//
//  FaceSignCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceSignModel.h"
@interface FaceSignCell : UITableViewCell

@property (nonatomic , strong)FaceSignModel *model;

@property (nonatomic , strong)UIButton *button;

@property (nonatomic , strong)UILabel *codeLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *InformationLabel;


@end
