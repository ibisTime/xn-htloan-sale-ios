//
//  DetailsMenuTableView13.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/31.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DetailsMenuTableView13.h"

#import "InstructionsCell.h"

#import "MenuInputCell.h"
@interface DetailsMenuTableView13 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation DetailsMenuTableView13

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MenuInputCell class] forCellReuseIdentifier:@"MenuInputCell"];
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
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *nameArray = @[@"入档编号",@"存放位置",@"保险公司",@"商业险",@"垫资合同",@"担保和反担保合同",@"抵押合同",@"其他资料"];
    cell.leftStr = nameArray[indexPath.row];
    
    if (indexPath.row >= 4) {
        cell.type = MenuPushType;
//        http.parameters[@"enterLocation"] = enterLocation;
//        http.parameters[@"insuranceCompany"] = insuranceCompany;
//        http.parameters[@"syxDateStart"] = syxDateStart;
//        http.parameters[@"syxDateEnd"] = syxDateEnd;
//        http.parameters[@"advanceContract"] = [advanceContract componentsJoinedByString:@"||"];
//        http.parameters[@"guarantorContract"] = [guarantorContract componentsJoinedByString:@"||"];
//        http.parameters[@"pledgeContract"] = [pledgeContract componentsJoinedByString:@"||"];
//        http.parameters[@"enterOtherPdf"] = [enterOtherPdf componentsJoinedByString:@"||"];
        
//        NSArray *ary = @[@"",
//                         @"",
//                         @"",
//                         @"",
//                         [BaseModel convertNull:self.model.enterLocation],
//                         [BaseModel convertNull:self.model.insuranceCompanyName],
//                         [BaseModel convertNull:[self.model.syxDateStart convertToDetailDate]],
//                         [BaseModel convertNull:[self.model.syxDateEnd convertToDetailDate]]
//                         ];
//        cell.rightStr = ary[indexPath.row];
    }
    else
    {
        NSArray *ary = @[[BaseModel convertNull:self.model.enterCode],
                         [BaseModel convertNull:self.model.enterLocationName],
                         [BaseModel convertNull:self.model.insuranceCompanyName],
                         [NSString stringWithFormat:@"%@-%@",[self.model.syxDateStart convertToDetailDate],[self.model.syxDateEnd convertToDetailDate]]
                         ];
        cell.rightStr = ary[indexPath.row];
        cell.type = MenuShowType;
    }
//    cell.leftLbl.frame = CGRectMake(15, 0, SCREEN_WIDTH, 55);
//    NSArray *ary = @[
//
//                     ];
//    cell.rightStr = ary[indexPath.row];
    
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
    
    return 55;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 3) {
        return 45;
    }
    return 0.01;
}
#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 3) {
        UIView *headView = [[UIView alloc]init];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        NSArray *ary = @[@"收件信息",@"提交银行信息",@"放款信息"];
        nameLbl.text = ary[section];
        [headView addSubview:nameLbl];
        return headView;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

@end
