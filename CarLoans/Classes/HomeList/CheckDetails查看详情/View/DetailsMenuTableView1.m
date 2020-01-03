//
//  DetailsMenuTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/31.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DetailsMenuTableView1.h"

#import "MenuInputCell.h"
@interface DetailsMenuTableView1 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation DetailsMenuTableView1

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
    if ([self.model.bizType isEqualToString:@"二手车"]) {
        return [MenuModel new].menuSecondgHandArray1.count;
    }
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
    if ([self.bizType isEqualToString:@"二手车"]) {
        NSArray *nameArray = [MenuModel new].menuSecondgHandArray1;
        cell.leftStr = nameArray[indexPath.row];
        NSArray *ary = @[[BaseModel convertNull:self.saleUserId],
                         [BaseModel convertNull:self.loanBankCode],
                         [BaseModel convertNull:self.region],
                         [BaseModel convertNull:self.shopCarGarage],
                         [BaseModel convertNull:self.bizType],
                         [BaseModel convertNull:self.carBrand],
                         [BaseModel convertNull:self.carSeries],
                         [BaseModel convertNull:self.carModel],
                         [BaseModel convertNull:self.regDate],
                         [BaseModel convertNull:self.secondCarReport]
                         ];
        cell.rightStr = ary[indexPath.row];
        cell.type = MenuShowType;
        
    }else
    {
        NSArray *ary = @[[BaseModel convertNull:self.saleUserId],
                         [BaseModel convertNull:self.loanBankCode],
                         [BaseModel convertNull:self.region],
                         [BaseModel convertNull:self.shopCarGarage],
                         [BaseModel convertNull:self.bizType],
                         [BaseModel convertNull:self.carBrand],
                         [BaseModel convertNull:self.carSeries],
                         [BaseModel convertNull:self.carModel]
                         ];
        cell.rightStr = ary[indexPath.row];
        NSArray *nameArray = [MenuModel new].menuSecondgHandArray1;
        cell.leftStr = nameArray[indexPath.row];
        cell.type = MenuShowType;
    }
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
