//
//  InputInformationMortgageTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "InputInformationMortgageTableView.h"
#import "ChooseCell.h"
#define ChooseC @"ChooseCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#define TextField1 @"TextFieldCell1"

#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"
#import "SurverCertificateCell.h"
#define SurverCertificate1 @"SurverCertificateCell"

#define UploadIdCard @"UploadIdCardCell"

@interface InputInformationMortgageTableView ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>

@end
@implementation InputInformationMortgageTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField1];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
        [self registerClass:[SurverCertificateCell class] forCellReuseIdentifier:SurverCertificate1];
        [self registerClass:[UploadIdCardCell class] forCellReuseIdentifier:UploadIdCard];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 9;
    }if (section == 1) {
        return 3;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务团队",@"业务归属",@"指派归属",@"当前状态"];
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
                                  [NSString stringWithFormat:@"%@",_model.code],
                                  [NSString stringWithFormat:@"%@",_model.creditUser[@"userName"]],
                                   [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull:self.model.loanBankName],[BaseModel convertNull:self.model.subbranchBankName]],
                                  [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",bizType],
                                  [BaseModel convertNull:self.model.teamName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                                  [[BaseModel user]note:_model.curNodeCode]

                                ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1){
        static NSString *rid=@"cell12";
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        NSArray * arr = @[@"*代理人",@"*代理人身份证号",@"*抵押地点"];
        if (indexPath.row == 0) {
            NSString * str1 = cell.nameTextField.text;
            if (str1.length == 0) {
                cell.nameTextField.text = self.model.carPledge[@"pledgeUser"];
            }
        }
       
        if (indexPath.row == 1) {
             NSString * str2 = cell.nameTextField.text;
            if (str2.length == 0) {
                cell.nameTextField.text = self.model.carPledge[@"pledgeUserIdCard"];
            }
        }
        
        if (indexPath.row == 2) {
            NSString * str3 = cell.nameTextField.text;
            if (str3.length == 0) {
                cell.nameTextField.text = self.model.carPledge[@"pledgeAddress"];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = arr[indexPath.row];
        cell.nameTextField.tag = indexPath.row + 20000;
        return cell;
    }
    if (indexPath.section == 2) {
        UploadIdCardCell *cell= [tableView dequeueReusableCellWithIdentifier:UploadIdCard forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLbl.text = @"*代理人身份证";
        cell.nameArray = @[@"代理人身份证正面",@"代理人身份证反面"];
        cell.IdCardDelegate = self;
        cell.idNoFront = self.idNoFront;
        cell.idNoReverse = self.idNoReverse;
        return cell;
    }
    
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField1 forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"*车辆抵押补充说明"];
    cell.nameTextField.placeholder = @"请输入车辆抵押补充说明";
    cell.name = nameArray[indexPath.row];
    cell.nameTextField.tag = 1000 + indexPath.row;
    return cell;
}

-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{

    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:1 selectRowState:@"add"];

    }

}


//删除
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos1"];
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
    if (indexPath.section == 2) {
        return SCREEN_WIDTH/3 + 70;
    }
    return 50;
    

}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if (section == 3) {
        UIView *headView = [[UIView alloc]init];

        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
        [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
        confirmButton.backgroundColor = MainColor;
        kViewRadius(confirmButton, 5);
        confirmButton.titleLabel.font = HGfont(18);
        [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:confirmButton];

        return headView;
    }

    return nil;
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"confirm"];

    }
}

#pragma mark - UploadIdCardDelegate
//身份证
-(void)UploadIdCardBtn:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
        
    }
}

-(void)SelectButtonClick:(UIButton *)sender
{
    [_AgentDelegate selectButtonClick:sender];
}
@end
