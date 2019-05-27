//
//  AdmissionDetailsTableView17.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView17.h"
#import "AdmissionInformationCell.h"
@interface AdmissionDetailsTableView17 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end

@implementation AdmissionDetailsTableView17

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
    
    return 10;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AdmissionInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[AdmissionInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _cell = cell;
    NSArray *topArray = @[@"姓名",@"手机号",@"身份证号",@"性别",@"年龄",@"学历",@"户籍地地址",@"户籍地邮编",@"工作单位名称",@"工作单位地址",@"工作f单位电话"];
    cell.topLbl.text = topArray[indexPath.row];
    NSDictionary  * dic = [[NSDictionary alloc]init];
    for (int i = 0; i < self.model.creditUserList.count; i ++) {
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"2"]) {
            dic = self.model.creditUserList[i];
        }
    }
    
    
    NSArray *bottomArray = @[[BaseModel convertNull:dic[@"userName"]],
                             [BaseModel convertNull:dic[@"mobile"]],
                             [BaseModel convertNull:dic[@"idNo"]],
                             [BaseModel convertNull:dic[@"gender"]],
                             [NSString stringWithFormat:@"%@",dic[@"age"]],
                             [BaseModel convertNull:[[BaseModel user]setParentKey:@"education" setDkey:dic[@"education"]]],
                             [NSString stringWithFormat:@"%@-%@-%@-%@",[BaseModel convertNull:dic[@"birthAddressProvince"]],[BaseModel convertNull:dic[@"birthAddressCity"]],[BaseModel convertNull:dic[@"birthAddressArea"]],[BaseModel convertNull:dic[@"birthAddress"]]],
                             [BaseModel convertNull:dic[@"birthPostCode"]],
                             [BaseModel convertNull:dic[@"companyName"]],
                             [BaseModel convertNull:dic[@"companyAddress"]],
                             [BaseModel convertNull:dic[@"companyContactNo"]]
                             ];
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
    return _cell.bottomLbl.yy;
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
        nameLbl.text = @"共还人人信息";
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
