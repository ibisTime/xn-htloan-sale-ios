//
//  InformationCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/18.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

//资信调查
#import "SurveyModel.h"
//准入单
#import "AccessSingleModel.h"
//资料传递
#import "DataTransferModel.h"
//gps安装
#import "GPSInstallationModel.h"

@interface InformationCell : UITableViewCell

@property (nonatomic , strong)UIButton *button;

@property (nonatomic , strong)UILabel *codeLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *InformationLabel;

@property (nonatomic , assign)BOOL  isGps;

@property (nonatomic , assign)BOOL  isXin;
@property (nonatomic , assign)BOOL isCar;

@property (nonatomic,assign) BOOL isFinancial;


@property (nonatomic , strong)SurveyModel *surveyModel;
@property (nonatomic , strong)AccessSingleModel *accessSingleModel;
@property (nonatomic , strong)DataTransferModel *dataTransferModel;
@property (nonatomic,strong) GPSInstallationModel * gpsInstallationModel;

@end
