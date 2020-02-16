//
//  CheckInputGPSTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CheckInputGPSTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "AddPeopleCell.h"
#define AddPeople @"AddPeopleCell"
#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
#import "MenuInputCell.h"
#import "DeleteGPSCell.h"
@implementation CheckInputGPSTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[AddPeopleCell class] forCellReuseIdentifier:AddPeople];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }
    if (section == 2) {
        return self.gpsArray.count;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *rid=@"cell";
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.type = MenuShowType;
        NSArray *nameArray = @[@"状态",@"客户姓名",@"业务团队",@"申请个数",@"申领原因"];
        cell.leftStr = nameArray[indexPath.row];
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
    if (indexPath.section == 1) {
        static NSString *rid=@"cell";
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.type = MenuPushType;
        cell.leftStr = @"*GPS编号";
        return cell;
    }
    
    if (indexPath.section == 2) {
        static NSString *rid=@"cell";
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        DeleteGPSCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[DeleteGPSCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.text = self.gpsArray[indexPath.row];
        [cell.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.selectButton.tag = indexPath.row;
        return cell;
    }
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.type = MenuInputType;
    cell.leftStr = @"*审核意见";
    cell.placStr = @"请输入审核意见";
    cell.rightTF.tag = 400;
    return cell;
    
}
-(void)selectButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

-(void)SurveyTaskSelectButton:(UIButton *)sender{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

-(void)deleteButton:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"delete"];
}

@end
