//
//  SurveyACreditTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurveyACreditTableView.h"
#import "ChooseCell.h"
#import "InputBoxCell.h"
#import "SurveyPeopleTableViewCell.h"
#import "TextFieldCell.h"
#define ChooseC @"ChooseCell"
#define InputBox @"InputBoxCell"
#define SurveyPeople @"SurveyPeopleTableViewCell"
#define TextField @"TextFieldCell"
#import "CarSettledUpdataPhotoCell.h"
#define CarSettledUpdataPhoto @"CarSettledUpdataPhotoCell"
#import "DriveCardCell.h"
#define DriveCard @"DriveCardCell"
#import "UploadIdCardCell.h"
#define UploadIdCard @"UploadIdCardCell"
#import "AddPeopleCell.h"
#define AddPeople @"AddPeopleCell"

@interface SurveyACreditTableView ()<UITableViewDataSource,UITableViewDelegate,SurveyPeopleDelegate,DriveCardDelegate,UploadIdCardDelegate>

@end

@implementation SurveyACreditTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
        [self registerClass:[SurveyPeopleTableViewCell class] forCellReuseIdentifier:SurveyPeople];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[CarSettledUpdataPhotoCell class] forCellReuseIdentifier:CarSettledUpdataPhoto];
        [self registerClass:[DriveCardCell class] forCellReuseIdentifier:DriveCard];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[UploadIdCardCell class] forCellReuseIdentifier:UploadIdCard];
        [self registerClass:[AddPeopleCell class] forCellReuseIdentifier:AddPeople];

    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
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
        return 2;
    }
    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        if (section == 2) {
            return self.peopleAray.count;
        }
    }
    else{
        if (section == 4) {
            return self.peopleAray.count;
        }
    }
    
    
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSArray *nameArray = @[@"*银行",@"*业务种类"];
        cell.name = nameArray[indexPath.row];
        NSArray *detailsArray = @[_bankStr,_speciesStr];
        cell.detailsLabel.text = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        InputBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*贷款金额(元)";
//        cell.nameText = @"请输入贷款金额";
//        cell.nameTextField.placeholder = @"请输入贷款金额";
        cell.nameTextField.tag = 300;
        cell.nameTextField.keyboardType = UIKeyboardTypeDecimalPad;
        return cell;
    }

    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        if (indexPath.section == 2) {
            static NSString *rid=@"SurveyPeopleTableViewCell";
            SurveyPeopleTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[SurveyPeopleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"*征信人";
            cell.btnStr = @"添加征信人";
            cell.delegate = self;
            if (_peopleAray.count > 0) {
                cell.peopleDic = _peopleAray[indexPath.row];
            }
            [cell.selectButton addTarget:self action:@selector(SelectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            cell.selectButton.tag = indexPath.row + 900000;
            return cell;
        }
        if (indexPath.section == 3) {
            AddPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:AddPeople forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            return cell;
        }
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"说明栏";
        cell.nameTextField.placeholder = @"请输入";
        cell.nameTextField.tag = 301;
        return cell;
    }else
    {
        if (indexPath.section == 2) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIButton *_photoBtn = [UIButton buttonWithTitle:@"评估报告" titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
            _photoBtn.frame = CGRectMake(15 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3);
            [_photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
                [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
            }];
            kViewBorderRadius(_photoBtn, 5, 1, HGColor(230, 230, 230));
            [cell addSubview:_photoBtn];
            
            UIImageView *photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3)];
            [photoImage sd_setImageWithURL:[NSURL URLWithString:[self.secondCarReport convertImageUrl]]];
            [_photoBtn addSubview:photoImage];
            
            UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            selectButton.frame = CGRectMake((SCREEN_WIDTH - 40)/2-15 , 0, 30, 30);
            [selectButton setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
           
            selectButton.tag = 50000 + indexPath.section;
            selectButton.hidden= NO;
            [cell addSubview:selectButton];
            if (self.secondCarReport.length > 0) {
                [_photoBtn addTarget:self action:@selector(appraisalReportBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
                 [selectButton addTarget:self action:@selector(SelectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
                _photoBtn.userInteractionEnabled = YES;
                selectButton.hidden = NO;
            }else{
                [_photoBtn addTarget:self action:@selector(appraisalReportBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
                _photoBtn.userInteractionEnabled = YES;
                selectButton.hidden = YES;
            }

            return cell;
        }
        if (indexPath.section == 3) {
            UploadIdCardCell *cell = [tableView dequeueReusableCellWithIdentifier:UploadIdCard forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameArray = @[@"行驶证正面",@"行驶证反面"];
            cell.nameLbl.text = @"*行驶证";
            cell.IdCardDelegate = self;
            cell.idNoFront = self.xszFront;
            cell.idNoReverse = self.xszReverse;
            return cell;

        }
        if (indexPath.section == 4) {
            SurveyPeopleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SurveyPeople forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"*征信人";
            cell.btnStr = @"添加征信人";
            cell.delegate = self;
            if (_peopleAray.count > 0) {
                cell.peopleDic = _peopleAray[indexPath.row];
            }
            [cell.selectButton addTarget:self action:@selector(SelectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            cell.selectButton.tag = indexPath.row + 900000;
            return cell;
        }
        if (indexPath.section == 5) {
            AddPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:AddPeople forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            return cell;
        }
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"说明栏";
        cell.nameTextField.placeholder = @"请输入";
        cell.nameTextField.tag = 301;
        return cell;
    }

}
-(void)SelectButtonClick:(UIButton *)sender{
    [_ButtonDelegate selectButtonClick:sender];
}

//-(void)delateButton:(UIButton *)sender{
//    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
//        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"delete"];
//    }
//}
-(void)appraisalReportBtnClick:(UIButton *)sender
{
    if (self.secondCarReport.length > 0) {
//        return;
        [[BaseModel user]AlterImageByUrl:self.secondCarReport];
    }
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:0 selectRowState:@"add"];
    }
}
-(void)selectbutton:(UIButton *)sender{
    [_ButtonDelegate selectButtonClick:sender];
}

-(void)SurveyPeopleSelectButton:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

//添加证信人
-(void)photoBtnClick:(UIButton *)sender
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

    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        if (indexPath.section == 2) {
            return 145;
        }
        if (indexPath.section == 3) {
            return 145;
        }
        return 50;
    }else
    {
        if (indexPath.section == 2) {
            return SCREEN_WIDTH/3 + 15;
        }
        if (indexPath.section == 3) {
            return SCREEN_WIDTH/3 + 70;
        }
        
        if (indexPath.section == 4) {
            return 145;
        }
        if (indexPath.section == 5) {
            return 145;
        }
        return 50;
    }

}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        if (section == 0 || section == 4) {
            return 0.01;
        }
        return 10;
    }else
    {
        if (section == 0 || section == 5 || section == 6 || section == 1 || section == 4 || section == 3) {
            return 0.01;
        }
//        if (section == 4) {
            return 50;
//        }
//        return 0.01;
    }

}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        if (section == 3) {
            return 100;
        }
        return 0.01;
    }else
    {
        if (section == 5) {
            return 100;
        }
        return 0.01;
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([_speciesStr isEqualToString:@"二手车"]) {
        if (section == 2) {
            UIView *headView = [[UIView alloc]init];

            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
            backView.backgroundColor = [UIColor whiteColor];
            [headView addSubview:backView];

            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
            lineView.backgroundColor = LineBackColor;
            [headView addSubview:lineView];
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
            nameLabel.text = @"*二手车评估报告";
            [headView addSubview:nameLabel];

            return headView;
        }

    }

    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([_speciesStr isEqualToString:@"新车"] || [_speciesStr isEqualToString:@""]) {
        if (section == 3) {
            UIView *headView = [[UIView alloc]init];


            UIButton *initiateButton = [UIButton buttonWithTitle:@"发起" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
            initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH/2 - 30, 50);
            kViewRadius(initiateButton, 5);
            [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            initiateButton.tag = 100;
            [headView addSubview:initiateButton];


            UIButton *saveButton = [UIButton buttonWithTitle:@"保存" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
            saveButton.frame = CGRectMake(SCREEN_WIDTH/2 + 15, 30, SCREEN_WIDTH/2 - 30, 50);
            kViewRadius(saveButton, 5);
            [saveButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            saveButton.tag = 101;
            [headView addSubview:saveButton];

            return headView;
        }
    }else
    {
        if (section == 5) {
            UIView *headView = [[UIView alloc]init];


            UIButton *initiateButton = [UIButton buttonWithTitle:@"发起" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
            initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH/2 - 30, 50);
            kViewRadius(initiateButton, 5);
            [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            initiateButton.tag = 100;
            [headView addSubview:initiateButton];


            UIButton *saveButton = [UIButton buttonWithTitle:@"保存" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
            saveButton.frame = CGRectMake(SCREEN_WIDTH/2 + 15, 30, SCREEN_WIDTH/2 - 30, 50);
            kViewRadius(saveButton, 5);
            [saveButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            saveButton.tag = 101;
            [headView addSubview:saveButton];

            return headView;
        }
    }

    return nil;
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}
//-(void)DriceCardBtn:(UIButton *)sender{
//    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
//        
//        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
//        
//    }
//}
//身份证
-(void)UploadIdCardBtn:(UIButton *)sender
{
    NSLog(@"sender %ld",sender.tag);
    if (sender.tag == 50) {
        if (self.xszFront.length > 0) {
            [[BaseModel user]AlterImageByUrl:self.xszFront];
        }
        else{
            if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
                
                [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
                
            }
        }
    }
    if (sender.tag == 51) {
        if (self.xszReverse.length > 0) {
            [[BaseModel user]AlterImageByUrl:self.xszReverse];
        }
        else{
            if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
                
                [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
                
            }
        }
    }
    
}
@end
