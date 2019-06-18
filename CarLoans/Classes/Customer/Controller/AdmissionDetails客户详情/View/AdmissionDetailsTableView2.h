//
//  AdmissionDetailsTableView2.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
NS_ASSUME_NONNULL_BEGIN

@interface AdmissionDetailsTableView2 : TLTableView
@property (nonatomic , strong)SurveyModel *model;

@property (nonatomic , strong)NSString *id_no_front_apply;
@property (nonatomic , strong)NSString *id_no_reverse_apply;
@property (nonatomic , strong)NSArray *auth_pdf_apply;
@property (nonatomic , strong)NSArray *interview_pic_apply;
@property (nonatomic , strong)NSArray *bank_report_apply;
@property (nonatomic,strong) NSArray * data_report_apply;


@property (nonatomic , strong)NSString *id_no_front_gua;
@property (nonatomic , strong)NSString *id_no_reverse_gua;
@property (nonatomic , strong)NSArray *auth_pdf_gua;
@property (nonatomic , strong)NSArray *interview_pic_gua;
@property (nonatomic , strong)NSArray *bank_report_gua;
@property (nonatomic,strong) NSArray * data_report_gua;

@property (nonatomic , strong)NSString *id_no_front_gua1;
@property (nonatomic , strong)NSString *id_no_reverse_gua1;
@property (nonatomic , strong)NSArray *auth_pdf_gua1;
@property (nonatomic , strong)NSArray *interview_pic_gua1;
@property (nonatomic , strong)NSArray *bank_report_gua1;
@property (nonatomic,strong) NSArray * data_report_gua1;

@property (nonatomic , strong)NSString *id_no_front_gh;
@property (nonatomic , strong)NSString *id_no_reverse_gh;
@property (nonatomic , strong)NSArray *auth_pdf_gh;
@property (nonatomic , strong)NSArray *interview_pic_gh;
@property (nonatomic , strong)NSArray *bank_report_gh;
@property (nonatomic,strong) NSArray * data_report_gh;

@end

NS_ASSUME_NONNULL_END
