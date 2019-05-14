//
//  ConfirmLendingTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/7.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ConfirmLendingTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
@implementation ConfirmLendingTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    }
    return 1;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *rid=@"cell1";
        
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        
        if(cell==nil){
            
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务归属",@"指派归属",@"当前状态"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSString *bizType;
        if ([self.model.bizType integerValue] == 0) {
            bizType = @"新车";
        }
        else
        {
            bizType = @"二手车";
        }
        
        NSArray *detailsArray = @[[NSString stringWithFormat:@"%@",_model.code],
                                  [NSString stringWithFormat:@"%@",_model.creditUser[@"userName"]],
                                  [NSString stringWithFormat:@"%@",_model.loanBankName],
                                  [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000],
                                  bizType,
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                                  [BaseModel convertNull:[[BaseModel user]note:self.model.curNodeCode]]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"*收款银行";
        cell.detailsLabel.text = _bankStr;
        return cell;
    }
    if (indexPath.section == 2) {
        static NSString *rid=@"cell";
        
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        
        if(cell==nil){
            
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            
        }
        cell.name = @"*收款账号";
        cell.nameTextField.text = _bankNo;
        cell.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.tag = 100 + indexPath.row;
        return cell;
    }
    if (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton *_photoBtn = [UIButton buttonWithTitle:@"收款凭证" titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
        _photoBtn.frame = CGRectMake(15 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3);
        //            [_photoBtn setTitle:@"评估报告" forState:(UIControlStateNormal)];
        [_photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        }];
        
        
        kViewBorderRadius(_photoBtn, 5, 1, HGColor(230, 230, 230));
        
        [_photoBtn addTarget:self action:@selector(appraisalReportBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell addSubview:_photoBtn];
        
        UIImageView *photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3)];
        [photoImage sd_setImageWithURL:[NSURL URLWithString:[self.secondCarReport convertImageUrl]]];
        [_photoBtn addSubview:photoImage];
        
        return cell;
    }
    static NSString *rid=@"cell4";
    
    TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        
    }
    cell.name = @"备注";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tag = 200 + indexPath.row;
    return cell;
    
}
#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 130;
    }
    else
        return 50;
}

-(void)appraisalReportBtnClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:0 selectRowState:@"add"];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}


#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3){
        return 50;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    else if (section == 4){
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel * label = [UILabel labelWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kWhiteColor font:Font(14) textColor:kBlackColor];
        label.text = @"*收款凭证";
        [headView addSubview:label];
        
        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        UIView *headView = [[UIView alloc]init];
        
        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 30, SCREEN_WIDTH - 40, 50);
        [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
        confirmButton.backgroundColor = MainColor;
        kViewRadius(confirmButton, 5);
        confirmButton.titleLabel.font = HGfont(18);
        [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:confirmButton];
        
        return headView;
    }
    return nil;
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}
@end
