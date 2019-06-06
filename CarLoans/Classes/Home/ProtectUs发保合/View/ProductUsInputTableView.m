//
//  ProductUsInputTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/5.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ProductUsInputTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "CreditReportingPersonInformationCell.h"
#define CreditReportingPersonInformation @"CreditReportingPersonInformationCell"
#import "SurverCertificateCell.h"
#define SurverCertificate @"SurverCertificateCell"
#import "UsedCarInformationCell.h"
#define UsedCarInformation @"UsedCarInformationCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"

@interface ProductUsInputTableView()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>

@end

@implementation ProductUsInputTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{

    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
    }
    return self;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务归属",@"指派归属",@"当前状态"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSString *bizType;
        if ([self.model.bizType integerValue] == 0) {
            bizType = @"新车";
        }
        else
        {
            bizType = @"二手车";
        }
        
        NSArray *rightAry = @[[BaseModel convertNull:self.model.code],
                              [NSString stringWithFormat:@"%@",self.model.creditUser[@"userName"]],
                              [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull:self.model.loanBankName],[BaseModel convertNull:self.model.subbranchBankName]],
                              [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000],
                              bizType,
                              [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                              [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                              [BaseModel convertNull:[[BaseModel user]note:self.model.fbhgpsNode]]];
        
        cell.TextFidStr = rightAry[indexPath.row];
        
        cell.nameTextField.hidden = YES;
        cell.nameTextLabel.hidden = NO;
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.delegate = self;
            cell.name = @"*保单开始日期";
            cell.details = self.policyDatetime;
            cell.tag = 1000 + indexPath.row;
            return cell;
        }
        else{
            ChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            //            cell.delegate = self;
            cell.name = @"*保单到期日期";
            cell.tag = 1000 + indexPath.row;
            cell.details = self.policyDueDate;
            return cell;
        }
    }
    if (indexPath.section == 2) {
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.selectStr = @"发票";
        cell.collectDataArray = self.carInvoice;
        return cell;
    }
    if (indexPath.section == 3) {
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.selectStr = @"交强险";
        
        cell.collectDataArray = self.carJqx;
        return cell;
    }
    if (indexPath.section == 4) {
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.selectStr = @"商业险";
        cell.collectDataArray = self.carSyx;
        return cell;
    }
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    if ([self.model.bizType isEqualToString:@"1"]) {
        cell.selectStr = @"绿大本";
    }else if([self.model.bizType isEqualToString:@"0"]){
        cell.selectStr = @"合格证";
    }
        cell.collectDataArray = self.carHgzPic;
        return cell;


}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;

}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }
    else if (section == 1){
        return 2;
    }
    else
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 50;
    }else{
        switch (indexPath.section) {
            case 2:{
                float numberToRound;
                int result;
                numberToRound = (self.carInvoice.count + 1.0)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }
                break;
            case 3:{
                float numberToRound;
                int result;
                numberToRound = (self.carJqx.count + 1.0)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }
                break;
            case 4:{
                float numberToRound;
                int result;
                numberToRound = (self.carSyx.count + 1.0)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }
                break;
            case 5:{
                float numberToRound;
                int result;
                numberToRound = (self.carHgzPic.count + 1.0)/3.0;
                result = (int)ceilf(numberToRound);
                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
            }
                break;
                
            default:
                break;
        }
        
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 2 || section == 3|| section == 4|| section == 5) {
        return 50;
    }
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 3|| section == 4|| section == 5 ) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];
        
        NSArray *array = [NSArray array];
        if ([self.model.bizType isEqualToString:@"1"]) {
            array = @[@"*发票",@"*交强险",@"*商业险",@"绿大本"];
        }
        else if ([self.model.bizType isEqualToString:@"0"]){
            array = @[@"*发票",@"*交强险",@"*商业险",@"*合格证"];
        }
        
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section - 2];
        [headView addSubview:nameLabel];
        
        return headView;
    }
    return nil;
}

-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([str isEqualToString:@"发票"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:100 selectRowState:@"add"];
        }
    }
    else if ([str isEqualToString:@"交强险"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:101 selectRowState:@"add"];
        }
    }
    else if ([str isEqualToString:@"商业险"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:102 selectRowState:@"add"];
        }
    }
    else if ([str isEqualToString:@"绿大本"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:103 selectRowState:@"add"];
        }
    }
    else if ([str isEqualToString:@"合格证"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:103 selectRowState:@"add"];
        }
    }
    else if ([str isEqualToString:@"其它资料"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:104 selectRowState:@"add"];
        }
    }
}

//删除
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    
    
    if ([str isEqualToString:@"发票"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos1"];
        }
    }
    else if ([str isEqualToString:@"交强险"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos2"];
        }
    }
    else if ([str isEqualToString:@"商业险"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
           [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos3"];
        }
    }
    else if ([str isEqualToString:@"绿大本"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos4"];
        }
    }
    else if ([str isEqualToString:@"合格证"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos4"];
        }
    }
    else if ([str isEqualToString:@"其它资料"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos5"];
        }
    }
    
}

@end
