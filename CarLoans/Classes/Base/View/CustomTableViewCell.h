//
//  CustomTableViewCell.h
//  CarLoans
//
//  Created by shaojianfei on 2018/10/25.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
//资信调查
#import "SurveyModel.h"
//准入单
#import "AccessSingleModel.h"
//资料传递
#import "DataTransferModel.h"
@interface CustomTableViewCell : UITableViewCell
@property (nonatomic , strong)UIButton *button;

@property (nonatomic , strong)UILabel *codeLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *InformationLabel;

@property (nonatomic , assign)BOOL  isGps;

@property (nonatomic , assign)BOOL  isXin;

@property (nonatomic , strong)SurveyModel *surveyModel;
@property (nonatomic , strong)AccessSingleModel *accessSingleModel;
@property (nonatomic , strong)DataTransferModel *dataTransferModel;

@end
