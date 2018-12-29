//
//  SurveyDetailsTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurveyDetailsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "CreditReportingPersonInformationCell.h"
#define CreditReportingPersonInformation @"CreditReportingPersonInformationCell"
#import "SurverCertificateCell.h"
#define SurverCertificate @"SurverCertificateCell"
#import "UsedCarInformationCell.h"
#define UsedCarInformation @"UsedCarInformationCell"
@interface SurveyDetailsTableView ()<UITableViewDataSource,UITableViewDelegate,CreditReportingPersonInformationDelegate>

@end

@implementation SurveyDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[CreditReportingPersonInformationCell class] forCellReuseIdentifier:CreditReportingPersonInformation];
        [self registerClass:[SurverCertificateCell class] forCellReuseIdentifier:SurverCertificate];
        [self registerClass:[UsedCarInformationCell class] forCellReuseIdentifier:UsedCarInformation];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_model.bizType integerValue] == 0) {
        return 4;
    }else
    {
        return 6;
    }

}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 3;
    }
    if ([_model.bizType integerValue] == 0) {
        return 1;
    }else
    {

        if ([BaseModel isBlankString:_surveyDetailsModel.secondCarReport] == YES) {
            if (section == 2 || section == 1) {
                return 0;
            }else
            {
                return 1;
            }
        }else
        {
            return 1;
        }
    }
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"银行",@"业务种类",@"贷款金额"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSString *bizType;
        if ([_model.bizType integerValue] == 0) {
            bizType = @"新车";
        }
        else
        {
            bizType = @"二手车";
        }
        NSArray *detailsArray = @[
                 [NSString stringWithFormat:@"%@",_model.loanBankName],
                 [NSString stringWithFormat:@"%@",bizType],
                 [NSString stringWithFormat:@"%.2f   ¥",[_model.loanAmount floatValue]/1000]
                 ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if ([_model.bizType integerValue] == 0) {
//        新车
        if (indexPath.section == 1) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"征信人";
            cell.isInput = @"0";
            return cell;
        }
        if (indexPath.section == 2) {
            CreditReportingPersonInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CreditReportingPersonInformation forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.Delegate = self;
            if (self.surveyDetailsModel.creditUserList > 0) {
                cell.model = self.surveyDetailsModel;
            }
            return cell;
        }
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"说明栏";
        cell.isInput = @"0";
        cell.TextFidStr = self.model.note;
        return cell;
    }
    else
    {
//        二手车
        if (indexPath.section == 1) {
            SurverCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:SurverCertificate forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"二手车评估报告";
//            cell.picArray = _model.pics3;
            return cell;
        }
        if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            UIButton *_photoBtn = [UIButton buttonWithTitle:@"" titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
            _photoBtn.frame = CGRectMake(15 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3);
            kViewBorderRadius(_photoBtn, 5, 1, HGColor(230, 230, 230));

            [_photoBtn addTarget:self action:@selector(appraisalReportBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [cell addSubview:_photoBtn];

            UIImageView *photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3)];
            [photoImage sd_setImageWithURL:[NSURL URLWithString:[_surveyDetailsModel.secondCarReport convertImageUrl]]];
            self.photoImage = photoImage;
            [_photoBtn addSubview:photoImage];

            return cell;
        }
        if (indexPath.section == 3) {
            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"征信人";
            cell.isInput = @"0";
            return cell;
        }
        if (indexPath.section == 4) {
            CreditReportingPersonInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:CreditReportingPersonInformation forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.Delegate = self;
            if (self.surveyDetailsModel.creditUserList > 0) {
                cell.model = self.surveyDetailsModel;
            }
            return cell;
        }
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"说明栏";
        cell.isInput = @"0";
        cell.TextFidStr = self.model.note;
        return cell;
    }


}

-(void)appraisalReportBtnClick:(UIButton*)sender
{
    if ([_surveyDetailsModel.secondCarReport isEqualToString:@""] || !_surveyDetailsModel.secondCarReport) {
        return;
    }
    NSMutableArray *imageArray = [NSMutableArray array];
        [imageArray addObject:[_surveyDetailsModel.secondCarReport convertImageUrl]];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
        return imageArray;
    }];
}


-(void)CreditReportingPersonInformationButton:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([_model.bizType integerValue] == 0) {
        if (indexPath.section == 2) {
            return 15 + 135 * self.surveyDetailsModel.creditUserList.count + (self.surveyDetailsModel.creditUserList.count - 1) * 10;
        }
        return 50;
    }else
    {
        if ([BaseModel isBlankString:_surveyDetailsModel.secondCarReport] == YES) {
            if (indexPath.section == 2 || indexPath.section == 1) {
                return 0.01;
            }
        }else
        {
            if (indexPath.section == 1) {
                return 50;
            }
            if (indexPath.section == 2) {
                return SCREEN_WIDTH/3 + 15;
            }
        }
        if (indexPath.section == 4) {
            return 15 + 135 * self.surveyDetailsModel.creditUserList.count + (self.surveyDetailsModel.creditUserList.count - 1) * 10;
        }
        return 50;
    }

}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
