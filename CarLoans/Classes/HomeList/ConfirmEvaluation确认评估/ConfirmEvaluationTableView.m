//
//  ConfirmEvaluationTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/16.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "ConfirmEvaluationTableView.h"

#import "NewLenderCell.h"
#import "MenuInputCell.h"
#import "InstructionsCell.h"
#import "UploadMultiplePicturesCell.h"
@interface ConfirmEvaluationTableView ()<UITableViewDataSource,UITableViewDelegate>
{
    UploadMultiplePicturesCell *_cell1;
    UploadMultiplePicturesCell *_cell;
}


@end
@implementation ConfirmEvaluationTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
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
        return [MenuModel new].detailsInfoArray.count;
    }
    if (section == 3) {
        return 4;
    }
    return 1;
    
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = [MenuModel new].detailsInfoArray;
        cell.leftStr = nameArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.type = MenuCheckDetailsType;
            cell.rightLbl.text = self.model.code;
        }else
        {
            cell.type = MenuShowType;
            NSString *bizType;
            if ([self.model.bizType isEqualToString:@"0"]) {
                bizType = @"新车";
            }else
            {
                bizType = @"二手车";
            }
            NSArray *ary = @[@"",
                             [BaseModel convertNull:self.model.creditUser[@"userName"]],
                             [BaseModel convertNull:self.model.loanBankName],
                             bizType,
                             [BaseModel Chu1000:self.model.loanAmount],
                             [[BaseModel user]note:self.model.materialNodeCode],
                             [self.model.applyDatetime convertToDetailDate],
                             [NSString stringWithFormat:@"%@（%@）",self.model.saleUserName,self.model.teamName]
                             ];
            cell.rightLbl.text = ary[indexPath.row];
        }
        return cell;
    }
    
    if (indexPath.section == 1) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        NewLenderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[NewLenderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isDetails = YES;
        cell.idReverse = self.idReverse;
        cell.idFront = self.idFront;;
        cell.holdIdCardPdf = self.holdIdCardPdf;
        cell.leftLbl.text = @"身份证信息";
        return cell;
    }
    
    if (indexPath.section == 2) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        UploadMultiplePicturesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UploadMultiplePicturesCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"车辆图"];
       
        cell.name = nameArray[indexPath.row];
        cell.isDetails = YES;
        
        cell.collectDataArray = [[BaseModel GetImgAccordingKeyAttachments:self.model.attachments kname:@"car_head"] componentsSeparatedByString:@"||"];;
        _cell1 = cell;
        return cell;
    }
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    UploadMultiplePicturesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UploadMultiplePicturesCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"车辆登记证书（多选）",@"保单图片（多选）",@"发票图片",@"行驶证"];
    if (indexPath.row == 3 || indexPath.row == 2) {
        cell.isSingle = YES;
    }else
    {
        cell.isSingle = NO;
    }
    cell.name = nameArray[indexPath.row];
    cell.isDetails = NO;
    cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
        self.returnAryBlock(imgAry, name, section);
    };

    if (indexPath.row == 0)
    {
        cell.collectDataArray = self.carRegisterCertificateFirst;
    }
    if (indexPath.row == 1)
    {
        cell.collectDataArray = self.policy;
    }
    if (indexPath.row == 2)
    {
        cell.collectDataArray = self.carInvoice;
    }
    if (indexPath.row == 3)
    {
        cell.collectDataArray = self.driveLicense;
    }
    _cell = cell;
    return cell;
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
        return _cell1.collectionView.yy;
    }
    if (indexPath.section == 3) {
        return _cell.collectionView.yy;
    }
    if (indexPath.section == 1) {
        return 162;
    }
    return 55;
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
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = kHexColor(@"#F5F5F5");
        [headView addSubview:lineView];
        return headView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
