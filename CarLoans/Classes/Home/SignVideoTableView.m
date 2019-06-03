//
//  SignVideoTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "SignVideoTableView.h"
//#import "UploadVideoCell.h"
#define UploadVideo @"UploadVideoCell"
#import "CollectionViewCell.h"
@implementation SignVideoTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.array.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
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
            numberToRound = (_other_video.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/4 + 5) + 15;
        }
    }
    else
    {
        if (indexPath.section == 3) {
            float numberToRound;
            int result;
            numberToRound = (self.idfront.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 4) {
            float numberToRound;
            int result;
            numberToRound = (self.idreverse.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 5) {
            float numberToRound;
            int result;
            numberToRound = (self.bank_photo.count)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 6) {
            float numberToRound;
            int result;
            numberToRound = (self.bank_contract.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 7) {
            float numberToRound;
            int result;
            numberToRound = (self.advance_fund_amount_pdf.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 8) {
            float numberToRound;
            int result;
            numberToRound = (self.company_contract.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        if (indexPath.section == 9) {
            float numberToRound;
            int result;
            numberToRound = (self.interview_other_pdf.count )/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
        }
        
    }
    return SCREEN_WIDTH/3 + 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
            }
            else if (indexPath.section == 2){
                cell.collectDataArray = self.other_video;
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.isEditor = NO;
        cell.selectStr = [NSString stringWithFormat:@"%ld",indexPath.section];
        
        return cell;
    }
    
        static NSString *CellIdentifier = @"Cell";
        CollectionViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[CollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        cell.selectStr = [NSString stringWithFormat:@"%ld",indexPath.section];
        cell.isEditor = NO;
    if (indexPath.section == 3) {
        cell.collectDataArray = self.idfront;
    }else if (indexPath.section == 4)
    {
        cell.collectDataArray = self.idreverse;
    }
    else if (indexPath.section == 5){
        cell.collectDataArray = self.bank_photo;
    }
    else if (indexPath.section == 6)
    {
        cell.collectDataArray = self.bank_contract;
    }
    else if (indexPath.section == 7){
        cell.collectDataArray = self.advance_fund_amount_pdf;
    }
    else if (indexPath.section == 8){
        cell.collectDataArray = self.company_contract;
    }
    else if (indexPath.section == 9){
        cell.collectDataArray = self.interview_other_pdf;
    }
    
        return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:backView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = LineBackColor;
    [headView addSubview:lineView];
    
    NSArray *array = @[@"银行视频",@"公司视频",@"其它视频",@"身份证正面",@"身份证反面",@"银行面签照片",@"银行合同",@"资金划转授权书",@"公司合同",@"其他资料"];
    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    nameLabel.text = array[section];
    [headView addSubview:nameLabel];
    
    return headView;
}
-(void)click:(UIButton *)sender{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"click"];
    }
}

@end
