//
//  MortgageTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MortgageTableView.h"

#import "MenuInputCell.h"
#import "InstructionsCell.h"
@interface MortgageTableView ()<UITableViewDataSource,UITableViewDelegate>



@end
@implementation MortgageTableView

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
    return [MenuModel new].detailsInfoArray.count;
    
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.model = self.model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = [MenuModel new].detailsInfoArray;
    cell.leftStr = nameArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.type = MenuCheckDetailsType;
        cell.rightLbl.text = self.model.code;
    }else
    {
        cell.type = MenuShowType;
        NSString *bizType;
        if ([self.model.bizType isEqualToString:@"0"]) {
            bizType = @"新车";
        }else
        {
            bizType = @"二手车";
        }
        NSArray *ary = @[@"",
                         [BaseModel convertNull:self.model.creditUser[@"userName"]],
                         [BaseModel convertNull:self.model.loanBankName],
                         bizType,
                         [BaseModel Chu1000:self.model.loanAmount],
                         [[BaseModel user]note:self.model.pledgeNodeCode],
                         [self.model.applyDatetime convertToDetailDate],
                         [NSString stringWithFormat:@"%@（%@）",self.model.saleUserName,self.model.teamName]
                         ];
        cell.rightLbl.text = ary[indexPath.row];
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
    if (section == 1) {
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
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = kHexColor(@"#F5F5F5");
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
