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

    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 8;
    }
//    if (section == 1) {
//        return 1;
//    }
    
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务归属",@"指派归属",@"当前状态"];
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
                                  [NSString stringWithFormat:@"%@",_model.loanBankName],
                                  [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",bizType],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                                  [[BaseModel user]note:_model.curNodeCode]

                                ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
//    if (indexPath.section == 1) {
//        SurverCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:SurverCertificate1 forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        NSArray *array = @[@"机动车登记证书",@"批单",@"车钥匙",@"大本扫描件",@"车辆驾驶证扫描件",@"完税证明扫描件"];
//        cell.name = array[indexPath.row];
//        switch (indexPath.row) {
//            case 0:
//            {
//                cell.picArray = _model.Newpics2;
//            }
//                break;
//            case 1:
//            {
//                cell.picArray = _model.Newpics3;
//            }
//                break;
//            case 2:
//            {
//                cell.picArray = _model.Newpics4;
//            }
//                break;
//            case 3:
//            {
//                cell.picArray = _model.Newpics5;
//            }
//                break;
//            case 4:
//            {
//                cell.picArray = _model.Newpics6;
//            }
//                break;
//            case 5:
//            {
//                cell.picArray = _model.Newpics7;
//            }
//                break;
//                
//            default:
//                break;
//        }
//        return cell;
//    }
//    if (indexPath.section == 2) {
//        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.name = @"提交时间";
//        cell.details = _date;
//        return cell;
//    }
//    
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
//    float numberToRound;
//    int result;
//    if (indexPath.section == 1) {
//        switch (indexPath.row) {
//            case 0:
//            {
//                numberToRound = (_model.Newpics2.count)/3.0;
//                result = (int)ceilf(numberToRound);
//                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
//            }
//                break;
//            case 1:
//            {
//                numberToRound = (_model.Newpics3.count)/3.0;
//                result = (int)ceilf(numberToRound);
//                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
//            }
//                break;
//            case 2:
//            {
//                numberToRound = (_model.Newpics4.count)/3.0;
//                result = (int)ceilf(numberToRound);
//                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
//            }
//                break;
//            case 3:
//            {
//                numberToRound = (_model.Newpics5.count)/3.0;
//                result = (int)ceilf(numberToRound);
//                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
//            }
//                break;
//            case 4:
//            {
//                numberToRound = (_model.Newpics6.count)/3.0;
//                result = (int)ceilf(numberToRound);
//                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
//            }
//                break;
//            case 5:
//            {
//                numberToRound = (_model.Newpics7.count)/3.0;
//                result = (int)ceilf(numberToRound);
//                return result * ((SCREEN_WIDTH - 50)/3 + 10) + 60;
//            }
//                break;
//            default:
//                break;
//        }
//    }else{
//        return 50;
//    }
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
    if (section == 1) {
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

    if (section == 1) {
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


@end
