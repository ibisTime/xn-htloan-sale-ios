//
//  InputTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/11.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "InputTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"

@implementation InputTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务归属",@"指派归属",@"当前状态"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSString *bizType;
        if ([_model.bizType integerValue] == 0) {
            bizType = @"新车";
        }
        else
        {
            bizType = @"二手车";
        }
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_model.code],
                                  [NSString stringWithFormat:@"%@",_model.creditUser[@"userName"]],
                                  [NSString stringWithFormat:@"%@",_model.loanBankName],
                                  [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",bizType],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                                  [[BaseModel user]note:_model.curNodeCode]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*档案存放位置";
        cell.detailsLabel.text = self.location;
        return cell;
    }
    static NSString *rid=@"upload";
    TaskCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[TaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.name = @"档案";
    cell.btnStr = @"新增档案";
    cell.delegate = self;
    [cell.photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    if (_FileArray.count > 0) {
        cell.FileArray = _FileArray;
    }
    [cell.deleteBtn addTarget:self action:@selector(deleteButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.deleteBtn.tag = indexPath.row;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 50 + 15 + (_FileArray.count + 1)*145 + 5;
    }
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
    if (section == 2) {
        return 100;
    }
    return 0.01;
}
-(void)photoBtnClick:(UIButton *)sender{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}

-(void)deleteButtonClick:(UIButton *)sender{
     [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"delect"];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        UIView *headView = [[UIView alloc]init];
        UIButton *initiateButton = [UIButton buttonWithTitle:@"确认" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
        initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH - 30, 50);
        kViewRadius(initiateButton, 5);
        [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        initiateButton.tag = 100;
        [headView addSubview:initiateButton];
        return headView;
    }
    return [UIView new];
}
-(void)confirmButtonClick:(UIButton *)sender{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"confirm"];
}

-(void)SurveyTaskSelectButton:(UIButton *)sender{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}
@end
