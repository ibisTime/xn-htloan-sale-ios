//
//  AdmissionDetailsTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView.h"
#import "AdmissionDetailsCell.h"

@interface AdmissionDetailsTableView ()<UITableViewDataSource,UITableViewDelegate>


@end
@implementation AdmissionDetailsTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[AdmissionDetailsCell class] forCellReuseIdentifier:@"AdmissionDetailsCell"];
//        [self selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];//设置选中第一行
//        [self didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];//实现点击第一行所调用的方法
        
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
    
    return 16;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AdmissionDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdmissionDetailsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row==0) {//指定第一行为选中状态
        
        [self selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        
    }
//    if (indexPath.row == 0) {
//        cell.backgroundColor = kHexColor(@"#E0EEFA");
//        cell.nameLbl.textColor = kAppCustomMainColor;
//    }else
//    {
//        cell.backgroundColor = kBackgroundColor;
//        cell.nameLbl.textColor = kHexColor(@"#666666");
//    }
    NSArray *array = @[@"基本信息",@"征信列表",@"贷款车辆信息",@"申请人基本信息",@"工作情况",@"其他基本信息",@"配偶信息",@"面签",@"财务垫资",@"银行放款",@"车辆抵押",@"发保合",@"GPS安装列表",@"流转日志",@"还款计划",@"附件池"];
    cell.nameLbl.text = array[indexPath.row];
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
    return 40;
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
