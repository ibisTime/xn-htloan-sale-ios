//
//  DetailsMenuTableView10.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/31.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DetailsMenuTableView10.h"
#import "InstructionsCell.h"

#import "MenuInputCell.h"
@interface DetailsMenuTableView10 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation DetailsMenuTableView10

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
    return 4;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    if (section == 1) {
        return 2;
    }
    if (section == 2) {
        return 3;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 3) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) {
            NSArray *nameArray = @[@"团队账号",@"收款银行名",@"收款支行名",@"返点信息"];
            cell.leftStr = nameArray[indexPath.row];
            cell.type = MenuShowType;
            NSArray *ary = @[
                             [BaseModel convertNull:self.dataDic[@"accountNo"]],
                             [BaseModel convertNull:self.dataDic[@"bankName"]],
                             [BaseModel convertNull:self.dataDic[@"subbranch"]],
                             [NSString stringWithFormat:@"%@  %@（用款2）",[BaseModel convertNull:self.model.teamName],self.model.repointAmount]
                             ];
            cell.rightStr = ary[indexPath.row];
        }
        if (indexPath.section == 1) {
            NSArray *nameArray = @[@"户号",@"账号"];
            cell.leftStr = nameArray[indexPath.row];
            cell.type = MenuShowType;
            NSArray *ary = @[[BaseModel convertNull:self.model.advance[@"advanceOutCard"][@"realName"]],
                             [BaseModel convertNull:self.model.advance[@"advanceOutCard"][@"bankcardNumber"]],
                             ];
            cell.rightStr = ary[indexPath.row];
        }
        if (indexPath.section == 2) {

            NSArray *nameArray = @[@"垫资日期",@"垫资金额",@"水单"];
            cell.leftStr = nameArray[indexPath.row];
            if (indexPath.row == 2) {
                cell.type = MenuPushType;
            }else
            {
                cell.type = MenuShowType;
            }
            
            if (indexPath.row == 0) {
                NSString *advanceFundDatetime;
                if ([BaseModel isBlankString:self.model.advance[@"advanceFundDatetime"]] == YES) {
                    advanceFundDatetime = @"";
                }else
                {
                    advanceFundDatetime = [self.model.advance[@"advanceFundDatetime"] convertToDetailDate];
                }
                cell.rightStr = advanceFundDatetime;
            }
            if (indexPath.row == 1) {
                cell.rightStr = [BaseModel Chu1000:self.model.advance[@"advanceFundAmount"]];
            }
            
            
        }
        return cell;
    }
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    InstructionsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[InstructionsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textView.tag = 1000;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textView.editable = NO;
    cell.textView.text = self.model.advance[@"makeBillNote"];
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
    if (indexPath.section == 3) {
        return 125;
    }
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
        NSArray *ary = @[@"收款账号信息",@"付款账号信息",@"垫资信息"];
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
