//
//  AdmissionDetailsTableView7.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView7.h"

#import "AdmissionInformationCell.h"
@interface AdmissionDetailsTableView7 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
    NSMutableArray * array;
}
@end
@implementation AdmissionDetailsTableView7
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
    array = [NSMutableArray array];
    for (int i = 0; i < self.model.creditUserList.count; i ++) {
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"3"]) {
            [array addObject:self.model.creditUserList[i]];
        }
    }
    
    return 1 * array.count;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 12 ;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    array = [NSMutableArray array];
    for (int i = 0; i < self.model.creditUserList.count; i ++) {
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"3"]) {
            [array addObject:self.model.creditUserList[i]];
        }
    }
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"Cell";
        AdmissionInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[AdmissionInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        _cell = cell;
        NSArray *topArray = @[@"姓名",@"与主贷人关系",@"手机号",@"身份证号",@"性别",@"年龄",@"学历",@"户籍地地址",@"户籍地邮编",@"工作单位名称",@"工作单位地址",@"工作f单位电话"];
        cell.topLbl.text = topArray[indexPath.row];

        NSArray *bottomArray = @[[BaseModel convertNull:array[0][@"userName"]],
                                 [BaseModel convertNull:[[BaseModel user] setParentKey:@"credit_user_relation" setDkey:array[0][@"relation"]]],
                                 [BaseModel convertNull:array[0][@"mobile"]],
                                 [BaseModel convertNull:array[0][@"idNo"]],
                                 [BaseModel convertNull:array[0][@"gender"]],
                                 [NSString stringWithFormat:@"%@",array[0][@"age"]],
                                 [BaseModel convertNull:[[BaseModel user]setParentKey:@"education" setDkey:array[0][@"education"]]],
                                 [NSString stringWithFormat:@"%@-%@-%@-%@",[BaseModel convertNull:array[0][@"birthAddressProvince"]],[BaseModel convertNull:array[0][@"birthAddressCity"]],[BaseModel convertNull:array[0][@"birthAddressArea"]],[BaseModel convertNull:array[0][@"birthAddress"]]],
                                 [BaseModel convertNull:array[0][@"birthPostCode"]],
                                 [BaseModel convertNull:array[0][@"companyName"]],
                                 [BaseModel convertNull:array[0][@"companyAddress"]],
                                 [BaseModel convertNull:array[0][@"companyContactNo"]]
                                 ];
        cell.bottomLbl.frame = CGRectMake(15, 39, SCREEN_WIDTH - 137, 14);
        cell.bottomLbl.numberOfLines = 0;
        cell.bottomLbl.text = bottomArray[indexPath.row];
        [cell.bottomLbl sizeToFit];
        return cell;
    }
    static NSString *CellIdentifier = @"Cell123";
    AdmissionInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[AdmissionInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _cell = cell;
    NSArray *topArray = @[@"姓名",@"与主贷人关系",@"手机号",@"身份证号",@"性别",@"年龄",@"学历",@"户籍地地址",@"户籍地邮编",@"工作单位名称",@"工作单位地址",@"工作单位电话"];
    cell.topLbl.text = topArray[indexPath.row];
    
 
    NSArray *bottomArray = @[[BaseModel convertNull:array[1][@"userName"]],
                             [[BaseModel user] setParentKey:@"credit_user_relation" setDkey:array[1][@"relation"]],
                             [BaseModel convertNull:array[1][@"mobile"]],
                             [BaseModel convertNull:array[1][@"idNo"]],
                             [BaseModel convertNull:array[1][@"gender"]],
                             [NSString stringWithFormat:@"%@",array[1][@"age"]],
                             [BaseModel convertNull:[[BaseModel user]setParentKey:@"education" setDkey:array[1][@"education"]]],
                             [NSString stringWithFormat:@"%@-%@-%@-%@",[BaseModel convertNull:array[1][@"birthAddressProvince"]],[BaseModel convertNull:array[1][@"birthAddressCity"]],[BaseModel convertNull:array[1][@"birthAddressArea"]],[BaseModel convertNull:array[1][@"birthAddress"]]],
                             [BaseModel convertNull:array[1][@"birthPostCode"]],
                             [BaseModel convertNull:array[1][@"companyName"]],
                             [BaseModel convertNull:array[1][@"companyAddress"]],
                             [BaseModel convertNull:array[1][@"companyContactNo"]]
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
        nameLbl.text = @"担保人信息";
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
