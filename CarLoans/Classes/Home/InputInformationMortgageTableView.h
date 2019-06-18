//
//  InputInformationMortgageTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "AccessSingleModel.h"
#import "UploadIdCardCell.h"
@protocol SelectButtonDelegate <NSObject>

-(void)selectButtonClick:(UIButton *)sender;

@end

@interface InputInformationMortgageTableView : TLTableView<UploadIdCardDelegate>
@property (nonatomic,weak) id<SelectButtonDelegate> AgentDelegate;
@property (nonatomic , strong)AccessSingleModel *model;
@property (nonatomic , copy)NSString *date;
//绿大本扫描件
@property (nonatomic , strong)NSArray *GreenBigBenArray;

//    身份证正面
@property (nonatomic , copy)NSString *idNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *idNoReverse;

@property (nonatomic,strong) IdCardFrontModel * idcardfrontmodel;
@property (nonatomic,strong) IdCradReverseModel * idcardreversemodel;
@end
