//
//  AdmissionDetailsTableView5.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView5.h"


#import "AdmissionInformationCell.h"
@interface AdmissionDetailsTableView5 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end
@implementation AdmissionDetailsTableView5
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
//    if (indexPath.row == 10) {
//        static NSString *CellIdentifier = @"PhotoCell";
//        PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
//        if (cell == nil) {
//            cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        }
//        if (indexPath.row == 10) {
//            cell.collectDataArray = @[@"",@"",@"",@""];
//            cell.selectStr = @"工作资料上传";
//        }
//
//        return cell;
//
//    }
    static NSString *CellIdentifier = @"Cell";
    AdmissionInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[AdmissionInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _cell = cell;
    NSArray *topArray = @[@"单位名称",@"单位地址",@"所属行业",@"单位经济性质",@"主要收入来源",@"职业",@"职称",@"月收入(元)",@"何时进入现单位工作",@"工作描述及还款来源分析"];
    
    cell.topLbl.text = topArray[indexPath.row];
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *array = [USERDEFAULTS objectForKey:BOUNCEDDATA];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"parentKey"] isEqualToString:@"main_income"]) {
            [dataArray addObject:array[i]];
        }
    }
    NSArray * array1 = [self.model.creditUser[@"mainIncome"] componentsSeparatedByString:@","];
    NSMutableArray *dvalueArray = [NSMutableArray array];
    for (int i = 0; i < array1.count; i ++) {
        for (int j = 0; j < dataArray.count; j ++) {
            if ([array1[i] isEqualToString:dataArray[j][@"dkey"] ]) {
                [dvalueArray addObject:dataArray[j][@"dvalue"] ];
            }
        }
    }
//    right3Label12.text = [dvalueArray componentsJoinedByString:@","];
    
    NSArray *bottomArray = @[[BaseModel convertNull:self.model.creditUser[@"companyName"]],
                             [BaseModel convertNull:self.model.creditUser[@"companyAddress"]],
                             [BaseModel convertNull:self.model.creditUser[@"workBelongIndustry"]],
                             [BaseModel convertNull:[[BaseModel user]setParentKey:@"work_company_property" setDkey:self.model.creditUser[@"workCompanyProperty"]]],
                             [BaseModel convertNull:[dvalueArray componentsJoinedByString:@","]],
                             [BaseModel convertNull:self.model.creditUser[@"workProfession"]],
                             [BaseModel convertNull:self.model.creditUser[@"postTitle"]],
                             [NSString stringWithFormat:@"%.2f",[self.model.creditUser[@"monthIncome"] floatValue]/1000],
                             [BaseModel convertNull:self.model.creditUser[@"workDatetime"]],
                             [BaseModel convertNull:self.model.creditUser[@"otherWorkNote"]]];
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
    if (indexPath.row == 12) {
        float numberToRound;
        int result;
        numberToRound = (4.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
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
        nameLbl.text = @"工作情况";
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
