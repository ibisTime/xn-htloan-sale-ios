//
//  CreditDetailsPeopleTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CreditDetailsPeopleTableView.h"
#import "CustomerDetailsCell.h"
#import "CustomerDetailsChooseCell.h"
#import "CreditDetailsCell.h"
#import "CreditDetailsPeopleIDCardCell.h"
#import "CreditDetailsPeoplePhotoCell.h"
#import "CustomerDetailsChooseCell.h"
@interface CreditDetailsPeopleTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation CreditDetailsPeopleTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CustomerDetailsCell class] forCellReuseIdentifier:@"CustomerDetailsCell"];
//
        [self registerClass:[CreditDetailsPeoplePhotoCell class] forCellReuseIdentifier:@"CreditDetailsPeoplePhotoCell"];
        [self registerClass:[CustomerDetailsChooseCell class] forCellReuseIdentifier:@"CustomerDetailsChooseCell"];
        [self registerClass:[CreditDetailsCell class] forCellReuseIdentifier:@"CreditDetailsCell"];
        [self registerClass:[CreditDetailsPeopleIDCardCell class] forCellReuseIdentifier:@"CreditDetailsPeopleIDCardCell"];
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
        return 2;
    }
    if (section == 1) {
        if (self.dataDic[@"idNoFront"] && self.dataDic[@"idNoReverse"])
        {
            return 1;
        }else
        {
            return 0;
        }
    }
    if (section  == 2) {
        if (self.authPdf.count == 0) {
            return 0;
        }else
        {
            return 1;
        }
    }
    if (section  == 3) {
        if (self.interviewPic.count == 0) {
            return 0;
        }else
        {
            return 1;
        }
    }
    return 3;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CustomerDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *leftAry = @[@"姓名",@"手机号"];
        NSArray *rightAry = @[[BaseModel convertNull:self.dataDic[@"userName"]],
                              [BaseModel convertNull:self.dataDic[@"mobile"]]
                              ];
        cell.leftLbl.text = leftAry[indexPath.row];
        cell.rightLbl.text = rightAry[indexPath.row];
        
        return cell;
    }
    if (indexPath.section == 1) {
        CreditDetailsPeopleIDCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreditDetailsPeopleIDCardCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataDic = self.dataDic;
        return cell;
    }
    if (indexPath.section == 2 || indexPath.section == 3) {
        CreditDetailsPeoplePhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CreditDetailsPeoplePhotoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 2) {
            cell.collectDataArray = self.authPdf;
            cell.selectStr = @"征信查询授权书";
        }else
        {
            cell.collectDataArray = self.interviewPic;
            cell.selectStr = @"面签照片";
        }
        
        return cell;
    }
    
    CustomerDetailsChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerDetailsChooseCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *leftAry = @[@"工行征信附件",
                         @"同盾征信附件",
                         @"立木征信附件",
                         ];
    
    cell.leftLbl.text = leftAry[indexPath.row];
    
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
    if (indexPath.section == 0) {
        return 45;
    }
    if (indexPath.section == 1) {
        return 45 + (SCREEN_WIDTH - 45)/2/300*200 + 41.5;
    }
    if (indexPath.section == 2) {
        float numberToRound;
        int result;
        numberToRound = (self.authPdf.count + 0.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 45)/3 + 15) + 45;
        
    }
    if (indexPath.section == 3) {
        float numberToRound;
        int result;
        numberToRound = (self.interviewPic.count + 0.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 45)/3 + 15) + 45;
    }
    return 45;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}


@end
