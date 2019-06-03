//
//  AgentTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "AgentTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#define TextField1 @"TextFieldCell"

#define UploadIdCard @"UploadIdCardCell"
@implementation AgentTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[UploadIdCardCell class] forCellReuseIdentifier:UploadIdCard];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 8;
    }
    else if (section == 1){
        return 3;
    }
    if (section == 3) {
        return 1;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0)
    {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务团队",@"业务归属",@"指派归属",@"当前状态"];
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
                                  [BaseModel convertNull:self.model.teamName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                                  [[BaseModel user]note:_model.curNodeCode]
                                  ];
        
            cell.TextFidStr = detailsArray[indexPath.row];
        
        return cell;
    }
    else if (indexPath.section == 1){
        static NSString *rid=@"cell12";
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray * arr = @[@"*代理人",@"*代理人身份证号",@"*抵押地点"];
        if (indexPath.row == 0) {
            NSString * str1 = cell.nameTextField.text;
            if (str1.length == 0) {
                cell.nameTextField.text = self.model.carPledge[@"pledgeUser"];
            }
        }
       
        if (indexPath.row == 1) {
             NSString * str2 = cell.nameTextField.text;
            if (str2.length == 0) {
                cell.nameTextField.text = self.model.carPledge[@"pledgeUserIdCard"];
            }
        }
       
        if (indexPath.row == 2) {
             NSString * str3 = cell.nameTextField.text;
            if (str3.length == 0) {
                cell.nameTextField.text = self.model.carPledge[@"pledgeAddress"];
            }
        }
        
        cell.name = arr[indexPath.row];
        cell.nameTextField.tag = indexPath.row + 10000;
        return cell;
    }
    if (indexPath.section == 2) {
        UploadIdCardCell *cell= [tableView dequeueReusableCellWithIdentifier:UploadIdCard forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLbl.text = @"*代理人身份证";
        cell.nameArray = @[@"代理人身份证正面",@"代理人身份证反面"];
        cell.IdCardDelegate = self;
        cell.idNoFront = self.idNoFront;
        cell.idNoReverse = self.idNoReverse;
        return cell;
    }
//    TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField1 forIndexPath:indexPath];
    static NSString *rid=@"cell098";
    TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"补充说明",@"*审核说明"];
    
    if (indexPath.row == 0) {
        cell.isInput = @"1";
        cell.TextFidStr = self.model.carPledge[@"pledgeSupplementNote"];
    }
    if (indexPath.row == 1) {
//        cell.isInput = @"1";
        cell.nameTextField.placeholder = @"请输入";
    }
    
    cell.name = nameArray[indexPath.row];
    cell.nameTextField.tag = 6000 + indexPath.row;
    return cell;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 3) {
        return 50;
    }
    return SCREEN_WIDTH/3 + 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return 100;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 3) {
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(void)confirmButtonClick:(UIButton *)sender{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"confirm"];
        
    }
}

#pragma mark - UploadIdCardDelegate
//身份证
-(void)UploadIdCardBtn:(UIButton *)sender
{
    if (sender.tag == 50) {
        if (self.idNoFront.length > 0) {
            NSMutableArray *muArray = [NSMutableArray array];
            NSArray * arr = @[self.idNoFront];
            for (int i = 0; i < arr.count; i++) {
                [muArray addObject:[arr[i] convertImageUrl]];
            }
            NSArray *seleteArray = muArray;
            
            if (muArray.count > 0) {
                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                    return seleteArray;
                }];
                
            }
        }
        else{
            if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
                
                [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
                
            }
        }
        
    }
    else if (sender.tag == 51) {
        if (self.idNoReverse.length > 0) {
            NSMutableArray *muArray = [NSMutableArray array];
            NSArray * arr = @[self.idNoReverse];
            for (int i = 0; i < arr.count; i++) {
                [muArray addObject:[arr[i] convertImageUrl]];
            }
            NSArray *seleteArray = muArray;
            
            if (muArray.count > 0) {
                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                    return seleteArray;
                }];
                
            }
        }
        else{
            if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
                
                [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
                
            }
        }
        
    }
    
}

-(void)SelectButtonClick:(UIButton *)sender
{
    [_AgentDelegate selectButtonClick:sender];
}
@end
