//
//  DetailsMenuTableView11.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/31.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DetailsMenuTableView11.h"

#import "InstructionsCell.h"

#import "MenuInputCell.h"
@interface DetailsMenuTableView11 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation DetailsMenuTableView11

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
    return 2;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 2;
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
    
    if (indexPath.section == 0) {
        NSArray *nameArray = @[@"打件时间",@"打件说明"];
        cell.leftStr = nameArray[indexPath.row];
        cell.type = MenuShowType;
        NSArray *ary = @[
                         [BaseModel convertNull:[self.model.hitPieceDatetime convertToDetailDate]],
                         [BaseModel convertNull:self.model.hitPieceNote]
                         ];
        cell.rightStr = ary[indexPath.row];
    }
    if (indexPath.section == 1) {
        NSArray *nameArray = @[@"理件时间",@"理件说明"];
        cell.leftStr = nameArray[indexPath.row];
        cell.type = MenuShowType;
        NSArray *ary = @[
                         [BaseModel convertNull:[self.model.rationaleDatetime convertToDetailDate]],
                         [BaseModel convertNull:self.model.rationaleNote]
                         ];
        cell.rightStr = ary[indexPath.row];
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
        NSArray *ary = @[@"打件信息",@"理件信息"];
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
