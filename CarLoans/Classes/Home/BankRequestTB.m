//
//  BankRequestTB.m
//  CarLoans
//
//  Created by shaojianfei on 2018/11/14.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BankRequestTB.h"
#import "ChooseCell.h"
#define ChooseC @"ChooseCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"
#import "NSString+Date.h"
#import "SurverCertificateCell.h"
#define SurverCertificate @"SurverCertificateCell"

@interface BankRequestTB ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>

@end
@implementation BankRequestTB

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
        [self registerClass:[SurverCertificateCell class] forCellReuseIdentifier:SurverCertificate];

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
        return 8;
    }
    
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"客户姓名",@"业务编号",@"贷款银行",@"贷款金额",@"申请时间",@"是否垫资",@"信贷专员",@"内勤专员"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSString *isAdvanceFund;
        if ([_model.isAdvanceFund isEqualToString:@"1"]) {
            isAdvanceFund = @"已垫资";
        }else
        {
            isAdvanceFund = @"未垫资";
        }
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_model.applyUserName],
                                  [NSString stringWithFormat:@"%@",_model.code],
                                   [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull:self.model.loanBankName],[BaseModel convertNull:self.model.subbranchBankName]],
                                  [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@" ,[_model.applyDatetime convertToDetailDate]
                                  ],
                                  isAdvanceFund,
                                  [NSString stringWithFormat:@"%@",_model.saleUserName],
                                  [NSString stringWithFormat:@"%@",_model.insideJobName]
                                  
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"抵押代理人";
        cell.TextFidStr = _model.pledgeUser;

        cell.nameTextField.tag = 100 + indexPath.row;
        return cell;
    }
    if (indexPath.section == 2) {
        
       
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"补充说明"];
        cell.nameTextField.placeholder = @"请输入补充说明";
        cell.name = nameArray[indexPath.row];
        cell.nameTextField.tag = 100 + indexPath.row;
        return cell;
    }
    SurverCertificateCell *cell = [tableView dequeueReusableCellWithIdentifier:SurverCertificate forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"身份证附件";
    cell.picArray = _model.pics8;

    
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
    
    switch (indexPath.section) {
        case 0:
        {
            return 50;
        }
            break;
        case 1:
        {
            return 50;
        }
            break;
        case 2:
        {
            return 50;

         
        }
            break;
        case 3:
        {
            
            float numberToRound;
            int result;
            numberToRound = (_GreenBigBenArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
        }
            break;
            
        default:
            break;
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
//    if (section == 3) {
//        UIView *headView = [[UIView alloc]init];
//
//        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//        backView.backgroundColor = [UIColor whiteColor];
//        [headView addSubview:backView];
//
//        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
//        lineView.backgroundColor = LineBackColor;
//        [headView addSubview:lineView];
//
//        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
//        nameLabel.text = @"身份证附件";
//        [headView addSubview:nameLabel];
//
//        return headView;
//    }
    return [UIView new];
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


@end
