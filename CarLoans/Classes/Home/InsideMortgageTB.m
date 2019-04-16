//
//  InsideMortgageTB.m
//  CarLoans
//
//  Created by shaojianfei on 2018/11/13.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "InsideMortgageTB.h"
#import "CollectionViewCell.h"
#define CarSettledUpdataPhoto @"CollectionViewCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
@interface InsideMortgageTB ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>


@end
@implementation InsideMortgageTB

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CarSettledUpdataPhoto];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];

        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
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
        NSArray *nameArray = @[@"业务编号",@"业务团队",@"区域经理",@"贷款金额",@"信贷专员",@"内勤专员",@"客户姓名",@"车牌号"];
        cell.name = nameArray[indexPath.row];
        if (indexPath.row == 7) {
            cell.isInput = @"1";
            cell.nameText = @"请输入车牌号";
            cell.nameTextField.tag = 100 +indexPath.row;
        }else{
            cell.isInput = @"0";

        }
        NSString *isAdvanceFund;
        if ([_model.isAdvanceFund isEqualToString:@"1"]) {
            isAdvanceFund = @"已垫资";
        }else
        {
            isAdvanceFund = @"未垫资";
        }
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_model.code],

                                  [NSString stringWithFormat:@"%@",_model.teamName],
                                  [NSString stringWithFormat:@"%@",_model.areaName],
                                  [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",_model.saleUserName],
                                  [NSString stringWithFormat:@"%@",_model.insideJobName],
                                  [NSString stringWithFormat:@"%@",_model.applyUserName]
                                  ,@""
                                  ];
        if (indexPath.row == 7) {

        }else{
            cell.TextFidStr = detailsArray[indexPath.row];

        }
        return cell;
    }else{
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CarSettledUpdataPhoto forIndexPath:indexPath];
        
        cell.delegate = self;
        cell.selectStr = [NSString stringWithFormat:@"%ld",indexPath.section];
        
        
        switch (indexPath.section) {
            case 1:
            {
                cell.collectDataArray = self.BankVideoArray;
                break;
                
            }
            case 2:
            {
                cell.collectDataArray = self.CompanyVideoArray;
                break;
                
            }
            case 3:
            {
                cell.collectDataArray = self.OtherVideoArray;
                break;
                
            }
            case 4:
            {
                cell.collectDataArray = self.BankSignArray;
                break;
                
            }
            case 5:
            {
                cell.collectDataArray = self.BankContractArray;
                break;
                
            }
            case 6:
            {
                cell.collectDataArray = self.CompanyContractArray;
                break;
                
                
            }
            
                
                
            default:
                break;
        }
        //    cell.selectStr = [NSString stringWithFormat:@"%ld",indexPath.section];
        return cell;
        
    }
    
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
    if (indexPath.section < 4)
    {
        if (indexPath.section == 0) {
            return 50;
        }
        if (indexPath.section == 1) {
            float numberToRound;
            int result;
            numberToRound = (_BankVideoArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/4 + 5) + 15;
        }
        if (indexPath.section == 2) {
            float numberToRound;
            int result;
            numberToRound = (_CompanyVideoArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/4 + 5) + 15;
        }
        if (indexPath.section == 3) {
            float numberToRound;
            int result;
            numberToRound = (_OtherVideoArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/4 + 5) + 15;
        }
    }
    else
    {
        if (indexPath.section == 4) {
            float numberToRound;
            int result;
            numberToRound = (self.BankSignArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 5) {
            float numberToRound;
            int result;
            numberToRound = (self.BankContractArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 6) {
            float numberToRound;
            int result;
            numberToRound = (self.CompanyContractArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 7) {
            float numberToRound;
            int result;
            numberToRound = (self.MoneyArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        
        
    }
    return SCREEN_WIDTH/3 + 15;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 0.01;
    }else{
        return 50;

    }
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 6) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section >0) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];
        
        NSArray *array = @[@"大本扫描件",@"车钥匙",@"车辆批单",@"登记证书",@"车辆行驶证扫描件",@"完税证明扫描件"];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section-1];
        [headView addSubview:nameLabel];
        
        return headView;
    }else{
        
        return [UIView new];
    }
   
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 6) {
        UIView *headView = [[UIView alloc]init];
        
        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 30, (SCREEN_WIDTH-60), 50);
        confirmButton.tag = 10000;
        
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
