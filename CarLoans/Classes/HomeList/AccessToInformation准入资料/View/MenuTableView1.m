//
//  MenuTableView1.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MenuTableView1.h"
#import "MenuInputCell.h"
@interface MenuTableView1 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation MenuTableView1

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
//    if ([self.bizType isEqualToString:@"二手车"]) {
//        return [MenuModel new].menuSecondgHandArray1.count;
//    }
    return [MenuModel new].menuArray1.count;
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
    if (indexPath.row == 3) {
        cell.type = MenuPushType;
    }else
    {
        cell.type = MenuChooseType;
    }
    NSArray *ary = @[[BaseModel convertNull:self.saleUserId],
                     [BaseModel convertNull:self.loanBankCode],
                     [BaseModel convertNull:self.region],
                     [BaseModel convertNull:self.shopCarGarage],
                     [BaseModel convertNull:self.ascription],
                     [BaseModel convertNull:self.bizType]
                     ];
    cell.rightStr = ary[indexPath.row];
    NSArray *nameArray = [MenuModel new].menuArray1;
    cell.leftStr = nameArray[indexPath.row];
    cell.rightLbl.tag = 10000 + indexPath.row;
    cell.rightTF.tag = 10000 + indexPath.row;
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
    if (section == 2) {
        return 10;
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
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

@end
