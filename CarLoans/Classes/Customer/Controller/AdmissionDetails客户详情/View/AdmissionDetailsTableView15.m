//
//  AdmissionDetailsTableView15.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/23.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView15.h"

#import "AdmissionDetailsRepaymentPlanCell.h"
#import "RepaymentPlanHeadView.h"
@interface AdmissionDetailsTableView15 ()<UITableViewDataSource,UITableViewDelegate>
//@property (nonatomic,strong) RepaymentPlanHeadView * topView;
@end
@implementation AdmissionDetailsTableView15
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[AdmissionDetailsRepaymentPlanCell class] forCellReuseIdentifier:@"RepaymentPlanCell"];
//        _topView = [[RepaymentPlanHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 107, 114 + 20)];
//        self.tableHeaderView = _topView;
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
    
    return self.model.repayPlanList.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rid=@"RepaymentPlanCell";
    AdmissionDetailsRepaymentPlanCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[AdmissionDetailsRepaymentPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.dic = self.model.repayPlanList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
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
    return 67;
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
