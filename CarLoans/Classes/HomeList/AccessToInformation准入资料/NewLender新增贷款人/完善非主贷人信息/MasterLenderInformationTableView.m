//
//  MasterLenderInformationTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/1.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "MasterLenderInformationTableView.h"
#import "MenuInputCell.h"
@interface MasterLenderInformationTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation MasterLenderInformationTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
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
    return 5;
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
    NSArray *nameArray = @[@"工作单位",@"职业",@"现住地址",@"单位地址",@"与主贷人关系"];
    cell.leftStr = nameArray[indexPath.row];

    NSArray *ary = @[[BaseModel convertNull:self.companyName],
                     [BaseModel convertNull:[[BaseModel user] setParentKey:@"work_profession" setDkey:self.position]],
                     [BaseModel convertNull:self.nowAddress],
                     [BaseModel convertNull:self.companyAddress],
                     [BaseModel convertNull:[[BaseModel user] setParentKey:@"credit_user_relation" setDkey:self.relation]]];

    
    if (indexPath.row ==  1 || indexPath.row == 4) {
        if (self.isDetails == YES) {
            cell.type = MenuShowType;
        }else
        {
            cell.type = MenuChooseType;
        }
        
        cell.rightLbl.text = ary[indexPath.row];
    }else
    {
        if (self.isDetails == YES) {
            cell.type = MenuShowType;
            cell.rightLbl.text = ary[indexPath.row];
        }else
        {
            cell.type = MenuInputType;
            if ([cell.rightTF.text isEqualToString:@""]) {
                cell.rightTF.text = ary[indexPath.row];
            }
            
            cell.rightTF.tag = 1000 + indexPath.row;
            cell.placStr = [NSString stringWithFormat:@"请输入%@",nameArray[indexPath.row]];
        }
        
        
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
