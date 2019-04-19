//
//  CreditReportingPersonInformationCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyDetailsModel.h"
#import "SurveyModel.h"
@protocol CreditReportingPersonInformationDelegate <NSObject>

-(void)CreditReportingPersonInformationButton:(UIButton *)sender;

-(void)ReferenceInputButton:(UIButton *)sender;

@end

@interface CreditReportingPersonInformationCell : UITableViewCell

@property (nonatomic, assign) id <CreditReportingPersonInformationDelegate> Delegate;

@property (nonatomic , strong)SurveyDetailsModel *model;
@property (nonatomic , strong)SurveyModel *model1;
@end
