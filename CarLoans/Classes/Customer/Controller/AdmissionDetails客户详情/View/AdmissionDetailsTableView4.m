//
//  AdmissionDetailsTableView4.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView4.h"
#import "PhotoCell.h"
#import "AdmissionInformationCell.h"
@interface AdmissionDetailsTableView4 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end
@implementation AdmissionDetailsTableView4
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
    
    return 27;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 26) {
        static NSString *CellIdentifier = @"PhotoCell";
        PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 16) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"house_contract"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"购房合同及房产本";
        }
        if (indexPath.row == 17) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"house_picture_apply"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"家访照片";
        }
        
        if (indexPath.row == 26) {
            cell.collectDataArray = @[[BaseModel convertNull:[[BaseModel user]FindUrlWithModel:self.model ByKname:@"pledge_user_id_card_front"]],[BaseModel convertNull:[[BaseModel user]FindUrlWithModel:self.model ByKname:@"pledge_user_id_card_reverse"]]];
            cell.selectStr = @"抵押代理人身份证复印件";
        }
        
        return cell;
        
    }
    static NSString *CellIdentifier = @"Cell";
    AdmissionInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[AdmissionInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _cell = cell;
    NSArray *topArray = @[@"姓名",
                          @"性别",
                          @"年龄",
                          @"身份证号",
                          @"婚姻状况",
                          @"民族",
                          @"学历",
                          @"政治面貌",
                          @"家庭人口",
                          @"联系电话",
                          @"现居住地址",
                          @"现居住地址邮编",
                          @"户口所在地",
                          @"户口所在地邮编",
                          @"家庭主要财产(元)",
                          @"主要财产说明",
                          @"",@"",
                          @"联系人1姓名",
                          @"与申请人关系",
                          @"手机号码",
                          @"联系人2姓名",
                          @"与申请人关系",
                          @"手机号码",
                          @"抵押代理人",
                          @"抵押地点",
                          @""];
    cell.topLbl.text = topArray[indexPath.row];
    NSDictionary * dic = [[NSDictionary alloc]init];
    if (self.model.creditUserList.count > 0) {
        dic = self.model.creditUserList[0];
    }
    
    
    NSArray *bottomArray = @[[BaseModel convertNull: self.model.creditUser[@"userName"]],
                             [NSString stringWithFormat:@"%@",[[BaseModel user]setParentKey:@"gender" setDkey:self.model.creditUser[@"gender"]]],
                             [BaseModel convertNull:[NSString stringWithFormat:@"%@", self.model.creditUser[@"age"]]],
                             [BaseModel convertNull: self.model.creditUser[@"idNo"]],
                             [BaseModel convertNull:[[BaseModel user]setParentKey:@"marry_state" setDkey:self.model.creditUser[@"marryState"]]],
                             [BaseModel convertNull: self.model.creditUser[@"nation"]],
                             [BaseModel convertNull:[[BaseModel user]setParentKey:@"education" setDkey:self.model.creditUser[@"education"]]],
                             [BaseModel convertNull:[[BaseModel user]setParentKey:@"politics" setDkey:self.model.creditUser[@"political"]]],
                             [NSString stringWithFormat:@"%@", self.model.creditUser[@"familyNumber"]],
                             [BaseModel convertNull: self.model.creditUser[@"familyPhone"]],
                             [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.creditUser[@"nowAddressProvince"],self.model.creditUser[@"nowAddressCity"],self.model.creditUser[@"nowAddressArea"],self.model.creditUser[@"nowAddress"]],
                             [BaseModel convertNull:self.model.creditUser[@"nowPostCode"]],
                             [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.creditUser[@"birthAddressProvince"],self.model.creditUser[@"birthAddressCity"],self.model.creditUser[@"birthAddressArea"],self.model.creditUser[@"nowAddress"]],
                             [BaseModel convertNull:self.model.creditUser[@"birthPostCode"]],
                             @"10000.00",
                             [BaseModel convertNull:self.model.creditUser[@"mainAssetInclude"]],
                             @"",
                             @"",
                             [BaseModel convertNull:dic[@"emergencyName1"]],
                             [BaseModel convertNull:[[BaseModel user]setParentKey:@"credit_contacts_relation" setDkey:dic[@"emergencyRelation1"]]],
                             [BaseModel convertNull:dic[@"emergencyMobile1"]],
                             [BaseModel convertNull:dic[@"emergencyName2"]],
                             [BaseModel convertNull:[[BaseModel user]setParentKey:@"credit_contacts_relation" setDkey:dic[@"emergencyRelation2"]]],
                             [BaseModel convertNull:dic[@"emergencyMobile2"]],
                             [BaseModel convertNull:self.model.carPledge[@"pledgeUser"]],
                             [BaseModel convertNull:self.model.carPledge[@"pledgeAddress"]],
                             @""];
    cell.bottomLbl.frame = CGRectMake(15, 39, SCREEN_WIDTH - 137, 14);
    cell.bottomLbl.numberOfLines = 0;
    cell.bottomLbl.text = bottomArray[indexPath.row];
    [cell.bottomLbl sizeToFit];
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
    if (indexPath.row == 17) {
        float numberToRound;
        int result;
        numberToRound = ([[[BaseModel user]FindUrlWithModel:self.model ByKname:@"house_picture_apply"] componentsSeparatedByString:@"||"].count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
    }
    if (indexPath.row == 16) {
        float numberToRound;
        int result;
        numberToRound = ([[[BaseModel user]FindUrlWithModel:self.model ByKname:@"house_contract"] componentsSeparatedByString:@"||"].count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ) + 32;
    }

    if (indexPath.row == 26) {
        float numberToRound;
        int result;
        numberToRound = (2.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ) + 32;
    }
    return _cell.bottomLbl.yy ;
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
        nameLbl.text = @"申请人基本信息";
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
