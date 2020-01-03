//
//  MenuTableView3.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MenuTableView3.h"

#import "MenuInputCell.h"
@interface MenuTableView3 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation MenuTableView3

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
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
    return 3;
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
    NSArray *nameArray = @[@"*姓名",@"*与主贷人关系",@"*手机号"];
    
    cell.leftStr = nameArray[indexPath.row];
    
    NSArray *ary1 = @[[BaseModel convertNull:self.emergencyName1],
                      [BaseModel convertNull:[[BaseModel user]setParentKey:@"credit_user_relation" setDkey:self.emergencyRelation1]],
                      [BaseModel convertNull:self.emergencyMobile1]];
    
    NSArray *ary2 = @[[BaseModel convertNull:self.emergencyName2],
                      [BaseModel convertNull:[[BaseModel user]setParentKey:@"credit_user_relation" setDkey:self.emergencyRelation2]],
                      [BaseModel convertNull:self.emergencyMobile2]];
    
    if (indexPath.row == 1) {
        if (self.isDetails == YES) {
            cell.type = MenuShowType;
        }else
        {
            cell.type = MenuChooseType;
        }
        
        if (indexPath.section == 0) {
            cell.rightLbl.text = ary1[indexPath.row];
        }
        if (indexPath.section == 1) {
            cell.rightLbl.text = ary2[indexPath.row];
        }
    }else
    {
        if (indexPath.section == 0) {
            if (self.isDetails == YES) {
                cell.rightLbl.text = ary1[indexPath.row];
            }else
            {
                if ([cell.rightTF.text isEqualToString:@""]) {
                    cell.rightTF.text = ary1[indexPath.row];
                }
            }
            if (indexPath.row == 0) {
                cell.rightTF.tag = 3000;
            }else
            {
                cell.rightTF.tag = 3001;
            }
        }
        if (indexPath.section == 1) {
            if (self.isDetails == YES) {
                cell.rightLbl.text = ary2[indexPath.row];
            }else
            {
                if ([cell.rightTF.text isEqualToString:@""]) {
                    cell.rightTF.text = ary2[indexPath.row];
                }
            }
            if (indexPath.row == 0) {
                cell.rightTF.tag = 3002;
            }else
            {
                cell.rightTF.tag = 3003;
            }
        }
        if (self.isDetails == YES) {
            cell.type = MenuShowType;
        }else
        {
            cell.type = MenuInputType;
        }
        
        cell.placStr = [NSString stringWithFormat:@"请输入%@",nameArray[indexPath.row]];
        
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
    
    return 45;
}
#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    backView.backgroundColor = kWhiteColor;
    [headView addSubview:backView];
    
    NSArray *ary = @[@"紧急联系人1",@"紧急联系人2"];
    UILabel *namelbl = [UILabel labelWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
    namelbl.text = ary[section];
    [backView addSubview:namelbl];
    
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    backView.backgroundColor = kHexColor(@"#F5F5F5");
    [headView addSubview:backView];
    
    return headView;
}

@end
