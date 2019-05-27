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
        return 6;
    }
    if (section == 1) {
        return self.gpsArray.count;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 70;
    }
    if ( indexPath.section == 2) {
        return 150;
    }
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
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"状态",@"客户姓名",@"业务团队",@"申请个数",@"有线个数",@"无线个数",@"申领原因"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
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
                                  [NSString stringWithFormat:@"%@个",_model.applyWiredCount],
                                  [NSString stringWithFormat:@"%@个",_model.applyWirelessCount],
                                  [BaseModel convertNull:_model.applyReason]
                                  ];
        cell.TextFidStr = textFidArray[indexPath.row];
        return cell;
    }
    else if (indexPath.section == 1){
        static NSString *rid=@"addgps";
        AddGPSCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[AddGPSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"任务";
        cell.delegate = self;
        cell.photoBtn.tag = indexPath.row;
        [cell.photoBtn addTarget:self action:@selector(SurveyTaskSelectButton:) forControlEvents:(UIControlEventTouchUpInside)];
        if (self.gpsArray.count > 0) {
            cell.taskDic = self.gpsArray[indexPath.row];
        }
        cell.selectButton.tag = indexPath.row;
        [cell.selectButton addTarget:self action:@selector(deleteButton:) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }
    if (indexPath.section == 2) {
        AddPeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:AddPeople forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.photoBtn setTitle:@"添加GPS" forState:(UIControlStateNormal)];
        return cell;
    }
    InputBoxCell * cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"审核意见";
    cell.nameText = @"请输入审核意见";
    cell.symbolLabel.hidden = YES;
    cell.nameTextField.tag = 400;
    return cell;
    
}
-(void)photoBtnClick:(UIButton *)sender
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
