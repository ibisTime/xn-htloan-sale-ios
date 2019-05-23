//
//  SurveyPeopleTableViewCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPSInstallationModel.h"
#import "GPSInstallationDetailsModel.h"


@protocol SurveyPeopleDelegate <NSObject>

-(void)SurveyPeopleSelectButton:(UIButton *)sender;
-(void)selectbutton:(UIButton *)sender;
@end

@interface SurveyPeopleTableViewCell : UITableViewCell

@property (nonatomic, assign) id <SurveyPeopleDelegate> delegate;

@property (nonatomic , strong)NSArray *GPSArray;

@property (nonatomic , strong)NSArray *peopleArray;

@property (nonatomic , strong)NSDictionary *peopleDic;

@property (nonatomic , copy)NSString *name;

@property (nonatomic , copy)NSString *btnStr;

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UIButton *photoBtn;

@property (nonatomic,strong) UIButton *selectButton;

@property (nonatomic , strong)GPSInstallationModel *model;

@property (nonatomic , strong)GPSInstallationDetailsModel *detalisModel;



@end
