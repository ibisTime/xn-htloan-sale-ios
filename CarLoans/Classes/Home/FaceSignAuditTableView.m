//
//  FaceSignAuditTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "FaceSignAuditTableView.h"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"

#import "UploadVideoCell.h"
#define UploadVideo @"UploadVideoCell"
#import "CollectionViewCell.h"
#define CarSettledUpdataPhoto @"CollectionViewCell"
@interface FaceSignAuditTableView ()<UITableViewDataSource,UITableViewDelegate,CustomCollectiondelegate1,CustomCollectiondelegate>

@end

@implementation FaceSignAuditTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
//        [self registerClass:[UploadVideoCell class] forCellReuseIdentifier:UploadVideo];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CarSettledUpdataPhoto];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < 3) {
        
        // 定义cell标识  每个cell对应一个自己的标识
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        // 通过不同标识创建cell实例
        UploadVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
        if (!cell) {
            cell = [[UploadVideoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (indexPath.section == 0) {
                cell.collectDataArray = self.BankVideoArray;
            }else if (indexPath.section == 1)
            {
                cell.collectDataArray = self.CompanyVideoArray;
            }else
            {
                cell.collectDataArray = self.OtherVideoArray;
            }
        }
        
//        UploadVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:UploadVideo forIndexPath:indexPath];
//        static NSString *CellIdentifier = @"Cell";
//        UploadVideoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
//        if (cell == nil) {
//            cell = [[UploadVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//
//        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.isEditor = NO;
        cell.selectStr = [NSString stringWithFormat:@"%ld",indexPath.section];
        
        return cell;
    }
    
    if (indexPath.section < 8) {
        static NSString *CellIdentifier = @"Cell";
        CollectionViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[CollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        cell.selectStr = [NSString stringWithFormat:@"%ld",indexPath.section];
        cell.isEditor = NO;
        switch (indexPath.section) {
            case 3:
            {
                cell.collectDataArray = self.BankSignArray;
                
            }
                break;
            case 4:
            {
                cell.collectDataArray = self.BankContractArray;
                
            }
                break;
            case 5:
            {
                cell.collectDataArray = self.CompanyContractArray;
                
                
            }
                break;
            case 6:
            {
                cell.collectDataArray = self.MoneyArray;
                
            }
                break;
            case 7:
            {
                cell.collectDataArray = self.otherArray;
                
            }
                break;
                
            default:
                break;
        }
        //    cell.selectStr = [NSString stringWithFormat:@"%ld",indexPath.section];
        return cell;
    }
    
    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"*审核意见";
    cell.nameText = @"请输入审核意见";
    cell.nameTextField.tag = 3000;
    return cell;
    
    //    CarSettledUpdataPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:CarSettledUpdataPhoto forIndexPath:indexPath];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}



-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:[str integerValue] selectRowState:@"add"];
    }
}

-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:[str integerValue] selectRowState:@"delete"];
    }
}

-(void)CarSettledUpdataPhotoBtn:(UIButton *)sender selectStr:(NSString *)Str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:[Str integerValue] selectRowState:@"add"];
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
    if (indexPath.section == 8) {
        return 50;
    }
    if (indexPath.section < 3)
    {
        if (indexPath.section == 0) {
            float numberToRound;
            int result;
            numberToRound = (_BankVideoArray.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/4 + 5) + 15;
        }
        if (indexPath.section == 1) {
            float numberToRound;
            int result;
            numberToRound = (_CompanyVideoArray.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/4 + 5) + 15;
        }
        if (indexPath.section == 2) {
            float numberToRound;
            int result;
            numberToRound = (_OtherVideoArray.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/4 + 5) + 15;
        }
    }
    else
    {
        if (indexPath.section == 3) {
            float numberToRound;
            int result;
            numberToRound = (self.BankSignArray.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 4) {
            float numberToRound;
            int result;
            numberToRound = (self.BankContractArray.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 5) {
            float numberToRound;
            int result;
            numberToRound = (self.CompanyContractArray.count)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 6) {
            float numberToRound;
            int result;
            numberToRound = (self.MoneyArray.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 7) {
            float numberToRound;
            int result;
            numberToRound = (self.otherArray.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        
    }
    return SCREEN_WIDTH/3 + 15;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 8) {
        return 0.01;
    }
    return 50;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 8) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 8) {
        return nil;
    }
    UIView *headView = [[UIView alloc]init];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:backView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = LineBackColor;
    [headView addSubview:lineView];
    
    NSArray *array = @[@"银行视频",@"公司视频",@"其他视频",@"银行面签图片",@"银行合同",@"公司合同",@"资金划转授权书",@"其他资料"];
    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    nameLabel.text = array[section];
    [headView addSubview:nameLabel];
    
    return headView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 8) {
        UIView *headView = [[UIView alloc]init];
        
        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 30, (SCREEN_WIDTH-60)/2, 50);
        confirmButton.tag = 10000;
        
        [confirmButton setTitle:@"通过" forState:(UIControlStateNormal)];
        confirmButton.backgroundColor = MainColor;
        kViewRadius(confirmButton, 5);
        confirmButton.titleLabel.font = HGfont(18);
        [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:confirmButton];
        UIButton *saveButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        saveButton.frame = CGRectMake((SCREEN_WIDTH-60)/2+30, 30, (SCREEN_WIDTH-60)/2, 50);
        [saveButton setTitle:@"不通过" forState:(UIControlStateNormal)];
        saveButton.backgroundColor = MainColor;
        kViewRadius(saveButton, 5);
        saveButton.titleLabel.font = HGfont(18);
        saveButton.tag = 10001;
        [saveButton addTarget:self action:@selector(saveButtonButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:saveButton];
        
        return headView;
    }
    return nil;
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}
-(void)saveButtonButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

@end
