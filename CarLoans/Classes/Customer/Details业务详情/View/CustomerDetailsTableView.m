//
//  CustomerDetailsTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CustomerDetailsTableView.h"
#import "CustomerDetailsCell.h"
#import "CustomerDetailsChooseCell.h"
@interface CustomerDetailsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation CustomerDetailsTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CustomerDetailsCell class] forCellReuseIdentifier:@"CustomerDetailsCell"];
        
        [self registerClass:[CustomerDetailsChooseCell class] forCellReuseIdentifier:@"CustomerDetailsChooseCell"];
        
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
    if (section == 0) {
        return 8;
    }
    return 6;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        CustomerDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *leftAry = @[@"业务编号",@"主贷人",@"经办银行",@"业务种类",@"贷款金额",@"当前节点",@"对应业务员",@"对应内勤"];
        NSArray *rightAry = @[@"689035602",@"张三",@"中国工商银行",@"新车/二手车",@"100，000元",@"100，000元",@"张三（xx团队）",@"李四"];
        cell.leftLbl.text = leftAry[indexPath.row];
        cell.rightLbl.text = rightAry[indexPath.row];
        
        return cell;
    }
    CustomerDetailsChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomerDetailsChooseCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *leftAry = @[@"代办事项（4个）",@"操作日志（10条）",@"征询单详情",@"准入单详情",@"附件详情（10个）",@"还款计划表"];
    
    cell.leftLbl.text = leftAry[indexPath.row];
    
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
    return 45;
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
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

@end
