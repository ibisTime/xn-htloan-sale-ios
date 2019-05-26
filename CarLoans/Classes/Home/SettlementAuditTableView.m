//
//  SettlementAuditTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SettlementAuditTableView.h"
#import "SettlementAuditCell.h"
#define SettlementAudit @"SettlementAuditCell"
//#import "SettlementAuditCell.h"

@interface SettlementAuditTableView ()<UITableViewDataSource,UITableViewDelegate>


@end

@implementation SettlementAuditTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[SettlementAuditCell class] forCellReuseIdentifier:SettlementAudit];

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

    return self.model.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{



    static NSString *CellIdentifier = @"Cell";
    SettlementAuditCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[SettlementAuditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SettlementAudit];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

//    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
//         // 通过不同标识创建cell实例
//    CustomerInvalidCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
//    UIButton *button;
//    if (!cell) {
//        cell = [[CustomerInvalidCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        button = [UIButton buttonWithTitle:@"审核" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
//        button.frame = CGRectMake(SCREEN_WIDTH - 115, 255, 100, 30);
//        kViewBorderRadius(button, 5, 1, MainColor);
//         forControlEvents:(UIControlEventTouchUpInside)];
//        [cell addSubview:button];
//    }
    cell.button.tag = indexPath.row;
    [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.model.count > 0) {
        cell.settlementAuditModel = self.model[indexPath.row];
    }

    SettlementAuditModel *model = self.model[indexPath.row];
    if ([model.curNodeCode isEqualToString:@"003_02"]) {
        cell.button.hidden = NO;
        [cell.button setTitle:@"清欠催收部审核" forState:(UIControlStateNormal)];
        
    }
    else if ([model.curNodeCode isEqualToString:@"003_03"]) {
        cell.button.hidden = NO;
        [cell.button setTitle:@"驻行人员审核" forState:(UIControlStateNormal)];
    }
    else if ([model.curNodeCode isEqualToString:@"003_04"]) {
        cell.button.hidden = NO;
        [cell.button setTitle:@"总经理审核" forState:(UIControlStateNormal)];
    }
    else if ([model.curNodeCode isEqualToString:@"003_05"]) {
        cell.button.hidden = NO;
        [cell.button setTitle:@"财务审核" forState:(UIControlStateNormal)];
    }
    else
    {
        cell.button.hidden = YES;
    }
    [cell.button.titleLabel sizeToFit];
    
    cell.button.frame = CGRectMake(SCREEN_WIDTH - cell.button.titleLabel.width - 15, 310, cell.button.titleLabel.width, 30);
    [cell.button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    return cell;


}

//添加证信人
-(void)buttonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:self.model[sender.tag].curNodeCode];
        
    }
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
//    SettlementAuditModel *model = self.model[indexPath.row];
    return 350;
//    if ([model.curNodeCode  isEqualToString:@"003_03"]) {
//        return 295;
//    }else
//    {
//        return 245;
//    }

}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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
