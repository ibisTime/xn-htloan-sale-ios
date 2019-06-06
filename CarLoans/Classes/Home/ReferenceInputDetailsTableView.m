//
//  ReferenceInputDetailsTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/19.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ReferenceInputDetailsTableView.h"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "CreditReportingPersonInformationCell.h"
#define CreditReportingPersonInformation @"CreditReportingPersonInformationCell"
#import "SurverCertificateCell.h"
#define SurverCertificate @"SurverCertificateCell"
#import "UsedCarInformationCell.h"
#define UsedCarInformation @"UsedCarInformationCell"
#import "ChooseCell.h"
#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"
@interface ReferenceInputDetailsTableView ()<UITableViewDataSource,UITableViewDelegate,CreditReportingPersonInformationDelegate,CustomCollectionDelegate>

@end
@implementation ReferenceInputDetailsTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[CreditReportingPersonInformationCell class] forCellReuseIdentifier:CreditReportingPersonInformation];
        [self registerClass:[SurverCertificateCell class] forCellReuseIdentifier:SurverCertificate];
        [self registerClass:[UsedCarInformationCell class] forCellReuseIdentifier:UsedCarInformation];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:@"ChooseCell"];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
    
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    if (section == 4) {
        return 2;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"姓名",@"与借款人关系",@"贷款角色",@"手机号",@"身份证号"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",self.dataDic[@"userName"]],
                                  [[BaseModel user] setParentKey:@"credit_user_relation" setDkey:self.dataDic[@"relation"]],
                                  [[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:self.dataDic[@"loanRole"]],
                                  [NSString stringWithFormat:@"%@",self.dataDic[@"mobile"]],
                                  [NSString stringWithFormat:@"%@",self.dataDic[@"idNo"]]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*银行征信结果(是否通过)";
        cell.detailsLabel.text = self.bankResult;
        
        return cell;
    }
    if (indexPath.section == 2) {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *_photoBtn = [UIButton buttonWithTitle:@"评估报告" titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
        _photoBtn.frame = CGRectMake(15 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3);
        [_photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        }];
        
        
        kViewBorderRadius(_photoBtn, 5, 1, HGColor(230, 230, 230));
        
//        [_photoBtn addTarget:self action:@selector(appraisalReportBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
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
            [selectButton addTarget:self action:@selector(SelectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [_photoBtn addTarget:self action:@selector(showimage) forControlEvents:(UIControlEventTouchUpInside)];
//            _photoBtn.userInteractionEnabled = NO;
            selectButton.hidden = NO;
        }else{
            [_photoBtn addTarget:self action:@selector(appraisalReportBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
//            _photoBtn.userInteractionEnabled = YES;
            selectButton.hidden = YES;
        }
        
        
        
        return cell;
    }
    if (indexPath.section == 3) {
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.selectStr = @"*大数据征信报告(多张)";
        cell.collectDataArray = self.dataCreditReport;
        return cell;
    }
    
   
//    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    // 定义cell标识  每个cell对应一个自己的标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    // 通过不同标识创建cell实例
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[TextFieldCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"*信用卡使用占比（%）",@"*征信报告说明"];
    cell.name = nameArray[indexPath.row];
    self.cell = cell;
    NSArray *placArray = @[@"请输入使用占比",@"请输入说明"];
    cell.nameText = placArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.nameTextField.keyboardType = UIKeyboardTypeDecimalPad;
        if ([cell.nameTextField.text isEqualToString:@""] && [self.creditCardOccupation floatValue] != 0) {
            cell.nameTextField.text =[NSString stringWithFormat:@"%.f", [self.creditCardOccupation floatValue] * 100];
        }
    }
    if (indexPath.row == 1) {
        if ([cell.nameTextField.text isEqualToString:@""] && [BaseModel isBlankString:self.creditNote] == NO) {
            cell.nameTextField.text = self.creditNote;
        }
    }
    
    cell.nameTextField.tag = 3000 + indexPath.row;
    return cell;
}
-(void)SelectButtonClick:(UIButton *)sender{
    [self.ButtonDelegate selectButtonClick:sender];
}
-(void)showimage{
    
    NSMutableArray *muArray = [NSMutableArray array];
    NSArray * arr = @[self.secondCarReport];
    for (int i = 0; i < arr.count; i++) {
        [muArray addObject:[arr[i] convertImageUrl]];
    }
    NSArray *seleteArray = muArray;
    
    if (muArray.count > 0) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
            return seleteArray;
        }];
        
    }
}
-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([str isEqualToString:@"银行征信报告(单)"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:100 selectRowState:@"add"];
            
        }
    }else
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:101 selectRowState:@"add"];
            
        }
    }
    
}
-(void)appraisalReportBtnClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:0 selectRowState:@"add"];
    }
}
//删除
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    if ([str isEqualToString:@"银行征信报告(单)"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos1"];
        }
    }else
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos2"];
            
        }
    }
    
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
    if (indexPath.section == 2) {
        float numberToRound;
        int result;
        numberToRound = (self.bankCreditReport.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
    }
    if (indexPath.section == 3) {
        float numberToRound;
        int result;
        numberToRound = (self.dataCreditReport.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    if (section == 2 || section == 3) {
        return 50;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2 || section == 3) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];
        
        NSArray *array = @[@"*银行征信报告(单)",@"*大数据征信报告(多张)"];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section - 2];
        [headView addSubview:nameLabel];
        
        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 4) {
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
