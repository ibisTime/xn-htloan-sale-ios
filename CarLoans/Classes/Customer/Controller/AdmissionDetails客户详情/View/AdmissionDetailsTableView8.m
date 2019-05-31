//
//  AdmissionDetailsTableView8.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView8.h"

@interface AdmissionDetailsTableView8 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end
@implementation AdmissionDetailsTableView8
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[AdmissionInformationCell class] forCellReuseIdentifier:@"AdmissionInformationCell"];
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 8;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < 3) {
        static NSString *CellIdentifier = @"VideoCell";
        VideoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSArray *array = @[@"银行视频",@"公司视频",@"其他视频"];
        cell.topLbl.text = array[indexPath.row];
        if (indexPath.row == 0) {
            cell.videoAry = self.bank_video;
        }
        if (indexPath.row == 1) {
            cell.videoAry = self.company_video;
        }
        if (indexPath.row == 2) {
            cell.videoAry = self.other_video;
        }
        
        
        
        return cell;
    }


    static NSString *CellIdentifier = @"PhotoCell";
    PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *array = @[@"",@"",@"",@"银行面签图片",@"银行合同",@"公司合同",@"资金划转授权书",@"其他资料"];
    cell.selectStr = array[indexPath.row];
    
    if (indexPath.row == 3) {
        
        cell.collectDataArray = self.bank_photo;
    }
    if (indexPath.row == 4) {
        cell.collectDataArray = self.bank_contract;
    }
    if (indexPath.row == 5) {
        cell.collectDataArray = self.company_contract;
    }
    if (indexPath.row == 6) {
        cell.collectDataArray = self.advance_fund_amount_pdf;
    }
    if (indexPath.row == 7) {
        cell.collectDataArray = self.interview_other_pdf;
    }
    return cell;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}
//    @property (nonatomic , strong)NSArray *bank_video;
//    @property (nonatomic , strong)NSArray *company_video;
//    @property (nonatomic , strong)NSArray *other_video;
//    @property (nonatomic , strong)NSArray *bank_photo;
//    @property (nonatomic , strong)NSArray *bank_contract;
//    @property (nonatomic , strong)NSArray *company_contract;
//    @property (nonatomic , strong)NSArray *advance_fund_amount_pdf;
//    @property (nonatomic , strong)NSArray *interview_other_pdf;
#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array;
    if (indexPath.row == 0) {
        array = _bank_video;
    }
    if (indexPath.row == 1) {
        array = _company_video;
    }
    if (indexPath.row == 2) {
        array = _other_video;
    }
    if (indexPath.row == 3) {
        array = _bank_photo;
    }
    if (indexPath.row == 4) {
        array = _bank_contract;
    }
    if (indexPath.row == 5) {
        array = _company_contract;
    }
    if (indexPath.row == 6) {
        array = _advance_fund_amount_pdf;
    }
    if (indexPath.row == 7) {
        array = _interview_other_pdf;
    }
    if (indexPath.row < 3) {
        return 40 + 20 * array.count;
    }
    float numberToRound;
    int result;
    numberToRound = (array.count + 0.0)/3.0;
    result = (int)ceilf(numberToRound);
    return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 58;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 23;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 107 - 15, 58) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = @"面签";
        [headView addSubview:nameLbl];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 57, SCREEN_WIDTH - 107, 1)];
        lineView.backgroundColor = kLineColor;
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
