//
//  CheckRepayCell.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CheckRepayCell : UITableViewCell

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


//@property (nonatomic,assign) BOOL isFinancial;

//
//@property (nonatomic , strong)SurveyModel *surveyModel;
//@property (nonatomic , strong)AccessSingleModel *accessSingleModel;
//@property (nonatomic , strong)AccessSingleModel *CarMortgageModel;
//@property (nonatomic , strong)DataTransferModel *dataTransferModel;
//@property (nonatomic,strong) GPSInstallationModel * gpsInstallationModel;
@property (nonatomic,strong) RepayModel * repayModel;
@property (nonatomic,strong) RepayModel * ConfirmrepayModel;
@property (nonatomic,strong) SettlementAuditModel * settlementAuditModel;

@end

NS_ASSUME_NONNULL_END
