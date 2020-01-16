//
//  AddTaskTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AddTaskTableView1.h"


#import "MenuInputCell.h"
#import "InstructionsCell.h"
@interface AddTaskTableView1 ()<UITableViewDataSource,UITableViewDelegate>



@end
@implementation AddTaskTableView1

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
    NSArray *nameArray = @[@"任务名称",@"任务时效(小时)",@"执行人"];
    if (indexPath.row == 2) {
        cell.type = MenuPushType;
        cell.rightStr = self.realName;
    }else
    {
        cell.type =  MenuInputType;
        cell.rightTF.tag = 100 + indexPath.row;
    }
    
    if (indexPath.row == 0) {
        if ([cell.rightTF.text isEqualToString:@""]) {
            cell.rightStr = [BaseModel convertNull:self.name];
        }
        
        
    }
    if (indexPath.row == 1) {
        if ([cell.rightTF.text isEqualToString:@""]) {
            cell.rightStr = [BaseModel convertNull:self.time];
        }
    }
    
    cell.leftStr = nameArray[indexPath.row];
    cell.placStr = [NSString stringWithFormat:@"请输入%@",nameArray[indexPath.row]];
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
    
    return 0.01;
}
#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 145;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *headView = [[UIView alloc]init];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 145)];
    backView.backgroundColor = kWhiteColor;
    [headView addSubview:backView];
    
    
    UIButton *throughBtn = [UIButton buttonWithTitle:@"返回" titleColor:kHexColor(@"#028EFF") backgroundColor:RGB(210, 231, 253) titleFont:16 cornerRadius:2];
    throughBtn.frame = CGRectMake(15, 100, (SCREEN_WIDTH - 45)/2, 45);
    [throughBtn addTarget:self action:@selector(throughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:throughBtn];
    
    UIButton *noThroughBtn = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:2];
    noThroughBtn.frame = CGRectMake(throughBtn.xx + 15, 100, (SCREEN_WIDTH - 45)/2, 45);
    [noThroughBtn addTarget:self action:@selector(noThroughBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:noThroughBtn];
    
    
    return headView;
}

-(void)throughBtnClick
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:100 selectRowState:@"返回"];
}

-(void)noThroughBtnClick
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:101 selectRowState:@"确认"];
}

@end
