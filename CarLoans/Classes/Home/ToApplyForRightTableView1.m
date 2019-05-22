//
//  ToApplyForRightTableView1.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForRightTableView1.h"

@interface ToApplyForRightTableView1 ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end
@implementation ToApplyForRightTableView1
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
//        [self registerClass:[ToApplyForEncapsulationCell class] forCellReuseIdentifier:ToApplyForEncapsulation];
        
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
    
    return [TopModel user].ary1.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义cell标识  每个cell对应一个自己的标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    // 通过不同标识创建cell实例
    ToApplyForEncapsulationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[ToApplyForEncapsulationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.topLbl.text = [TopModel user].ary1[indexPath.row];
    
    if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 13 || indexPath.row == 10  || indexPath.row == 11 || indexPath.row == 12 ) {
        cell.type = ChooseType;
        cell.chooseLbl.tag = 10000 + indexPath.row;
    }else if (indexPath.row == 7 || indexPath.row == 14 || indexPath.row == 15 || indexPath.row == 16)
    {
        cell.type = InputType;
        cell.inputTextField.tag = 10000 + indexPath.row;
        if (indexPath.row == 7) {
            cell.inputTextField.delegate = self;
            
        }
        cell.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    else
    {
        cell.type = ShowType;
        cell.showLbl.tag = 10000 + indexPath.row;
    }
    return cell;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString * resultStr = textField.text;
    
    NSLog(@"%@",resultStr);
    UITextField * text = [self viewWithTag:10000+ 8];
    text.text = [NSString stringWithFormat:@"%.f",[resultStr floatValue] - ([self.model.loanAmount floatValue ] /1000)];
    
    UITextField * text1 = [self viewWithTag:10000+ 9];
    text1.text = [NSString stringWithFormat:@"%.2f",([text.text floatValue] / [resultStr floatValue]) * 100 ];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString * resultStr = [textField.text stringByAppendingString:string];
//    if ([resultStr floatValue] > ([self.model.loanAmount floatValue ] /1000)) {
        NSLog(@"%@",resultStr);
        UITextField * text = [self viewWithTag:10000+ 8];
        text.text = [NSString stringWithFormat:@"%.f",[resultStr floatValue] - ([self.model.loanAmount floatValue ] /1000)];
        
        UITextField * text1 = [self viewWithTag:10000+ 9];
        text1.text = [NSString stringWithFormat:@"%.2f",([text.text floatValue] / [resultStr floatValue] ) * 100];
        
        return YES;
//    }
//    else{
//        [TLAlert alertWithInfo:@"开票价输入不合理"];
//        return NO;
//    }
    
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
    return 53;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 58;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 23;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 107 - 15, 58) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = @"贷款信息";
        [headView addSubview:nameLbl];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 57, SCREEN_WIDTH - 107, 1)];
        lineView.backgroundColor = kLineColor;
        [headView addSubview:lineView];
        
        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}



@end
