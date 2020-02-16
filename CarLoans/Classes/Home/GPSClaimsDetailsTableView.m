//
//  GPSClaimsDetailsTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSClaimsDetailsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "GPSCell.h"
#import "MenuInputCell.h"
@interface GPSClaimsDetailsTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation GPSClaimsDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];

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
//    if (section == 0) {
//        return 7;
//    }
//    return 1;
    if (section == 1) {
        if (self.model.gpsList.count == 0) {
            return 0;
        }
        else{
            return self.model.gpsList.count + 1;
        }
    }
    else
//        if (self.model.gpsList.count == 0) {
//            return 7;
//        }
        return 5;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.type = MenuShowType;
        
        
        
        NSArray *nameArray = @[@"状态",@"客户姓名",@"业务团队",@"申请个数",@"申领原因"];
        cell.leftStr = nameArray[indexPath.row];
//        cell.isInput = @"0";
        NSString *state;
        if (_model.status == 0) {
            state = @"待审核";
        }else if (_model.status == 1)
        {
            state = @"审核通过,待发货";
        }
        else if (_model.status == 2)
        {
            state = @"审核不通过";
        }
        else if (_model.status == 3)
        {
            state = @"已发货,待收货";
        }else
        {
            state = @"已收货";
        }
        NSArray *textFidArray = @[
                                  state,
                                  [NSString stringWithFormat:@"%@-%@",_model.applyUserName,_model.roleName],
                                  [NSString stringWithFormat:@"%@",_model.teamName],
                                  [NSString stringWithFormat:@"%@个",_model.applyCount],
                                  [BaseModel convertNull:_model.applyReason]
                                  ];
        cell.rightStr = textFidArray[indexPath.row];
        return cell;
    }
    
    if (indexPath.row == 0) {
        static NSString *rid=@"cell";
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.type = MenuShowType;
        cell.leftStr = @"GPS设备号";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *rid=@"cell";
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.leftStr = [BaseModel convertNull:self.model.gpsList[indexPath.row - 1][@"gpsDevNo"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

//添加证信人
-(void)photoBtnClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
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
    return 50;
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
