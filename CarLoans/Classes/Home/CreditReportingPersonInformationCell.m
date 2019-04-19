//
//  CreditReportingPersonInformationCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CreditReportingPersonInformationCell.h"
#import "SurveyInformationVC.h"
@implementation CreditReportingPersonInformationCell
{
    SurveyDetailsModel *surModel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {



    }
    return self;
}

-(void)setModel:(SurveyDetailsModel *)model
{
    surModel = model;
    NSArray *nameArray = @[@"姓    名:",
                           @"手机号:",
                           @"身份证:",
                           @"角    色:",
                           @"关    系:"];
    NSArray *listArray = model.creditUserList;
    for (int i = 0; i < listArray.count; i ++ ) {

        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 15 + i % listArray.count * 145, SCREEN_WIDTH - 30, 135)];
        backView.backgroundColor = BackColor;
        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
        [self addSubview:backView];

        for (int j = 0; j < 5; j ++) {
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 10 + j%5*25, 60, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
            nameLabel.text = nameArray[j];
            [backView addSubview:nameLabel];

            UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 10+j%5*25, SCREEN_WIDTH - 120, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];
            NSArray *detailsArray = @[
                          [NSString stringWithFormat:@"%@",listArray[i][@"userName"]],
                          [NSString stringWithFormat:@"%@",listArray[i][@"mobile"]],
                          [NSString stringWithFormat:@"%@",listArray[i][@"idNo"]],
                          [[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:listArray[i][@"loanRole"]],
                          [[BaseModel user] setParentKey:@"credit_user_relation" setDkey:listArray[i][@"relation"]]
                          ];
            informationLabel.text = detailsArray[j];
            [backView addSubview:informationLabel];
        }

        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        backButton.frame = CGRectMake(15, 15 + i % listArray.count * 145, SCREEN_WIDTH - 30, 135);
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        backButton.tag = 123 + i;
        [self addSubview:backButton];
    }
}

-(void)setModel1:(SurveyModel *)model1
{
//    surModel = model;
    NSArray *nameArray = @[@"姓    名:",
                           @"手机号:",
                           @"身份证:",
                           @"角    色:",
                           @"关    系:"];
    NSArray *listArray = model1.creditUserList;
    for (int i = 0; i < listArray.count; i ++ ) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 15 + i % listArray.count * 145, SCREEN_WIDTH - 30, 135)];
        backView.backgroundColor = BackColor;
        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
        [self addSubview:backView];
        
        
        
        
        
        for (int j = 0; j < 5; j ++) {
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 10 + j%5*25, 60, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
            nameLabel.text = nameArray[j];
            [backView addSubview:nameLabel];
            
            UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 10+j%5*25, SCREEN_WIDTH - 120, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%@",listArray[i][@"userName"]],
                                      [NSString stringWithFormat:@"%@",listArray[i][@"mobile"]],
                                      [NSString stringWithFormat:@"%@",listArray[i][@"idNo"]],
                                      [[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:listArray[i][@"loanRole"]],
                                      [[BaseModel user] setParentKey:@"credit_user_relation" setDkey:listArray[i][@"relation"]]
                                      ];
            informationLabel.text = detailsArray[j];
            [backView addSubview:informationLabel];
            
            
        }
        
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        backButton.frame = CGRectMake(0, 0, SCREEN_WIDTH - 30, 135);
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        backButton.tag = 123 + i;
        [backView addSubview:backButton];
        
        UIButton *luruBtn = [UIButton buttonWithTitle:@"录入" titleColor:kAppCustomMainColor backgroundColor:kClearColor titleFont:13];
        luruBtn.frame = CGRectMake(SCREEN_WIDTH - 30 - 65 - 50, 0, 100, 35);
        luruBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [luruBtn addTarget:self action:@selector(luruBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        luruBtn.tag = 1000 + i;
        [backView addSubview:luruBtn];
        
    }
}

-(void)luruBtnClick:(UIButton *)sender
{
    [_Delegate ReferenceInputButton:sender];
}

-(void)backButtonClick:(UIButton *)sender
{
    NSLog(@"1");
    [_Delegate CreditReportingPersonInformationButton:sender];
}

@end
