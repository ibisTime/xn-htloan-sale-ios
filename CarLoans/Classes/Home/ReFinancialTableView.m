//
//  ReFinancialTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ReFinancialTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "InputBoxCell.h"
#define InputBox @"InputBoxCell"
#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
@implementation ReFinancialTableView
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[InputBoxCell class] forCellReuseIdentifier:InputBox];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
    }
    return self;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 11;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 180;
    }
    if (indexPath.section == 1) {
         NSArray * collectDataArray = [self.peopleAray[0][@"advance_fund_amount_pdf"] componentsSeparatedByString:@"||"];
        return 180 * ((collectDataArray.count / 3) + 1);
    }
    if (indexPath.section == 2) {
         NSArray * collectDataArray = [self.peopleAray[0][@"interview_other_pdf"] componentsSeparatedByString:@"||"];
        return 180 * ((collectDataArray.count / 3) + 1);
    }
    return 50;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row < 9) {
            TextFieldCell * cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务归属",@"指派归属",@"当前状态",@"汽车经销商"];
            cell.name = nameArray[indexPath.row];
            cell.isInput = @"0";
            NSString *bizType;
            if ([self.model.credit[@"bizType"] integerValue] == 0) {
                bizType = @"新车";
            }
            else
            {
                bizType = @"二手车";
            }
            
            NSArray *rightAry = @[[BaseModel convertNull:self.model.code],
                                  [NSString stringWithFormat:@"%@",self.model.creditUser[@"userName"]],
                                  [BaseModel convertNull:self.model.loanBankName],
                                  [NSString stringWithFormat:@"%.2f万",[self.model.loanAmount floatValue]/10000],
                                  bizType,
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                                  [BaseModel convertNull:[[BaseModel user]note:self.model.curNodeCode]],
                                  [NSString stringWithFormat:@"%@-%@-%@",self.model.companyName,self.model.teamName,self.model.saleUserName]];
            
            cell.TextFidStr = rightAry[indexPath.row];
            cell.nameTextField.hidden = YES;
            cell.nameTextLabel.hidden = NO;
            return cell;
        }
        else if (indexPath.row == 9) {
            ChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"*垫资日期";
            cell.tag = 1000 + indexPath.row;
            return cell;
        }
        else if (indexPath.row == 10){
            InputBoxCell * cell = [tableView dequeueReusableCellWithIdentifier:InputBox forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"*垫资金额";
            cell.nameText = @"请输入垫资金额";
            cell.nameTextField.keyboardType = UIKeyboardTypeNumberPad;
            cell.symbolLabel.hidden = YES;
            cell.tag = 1000 + indexPath.row;
            return cell;
        }
    }
    if (indexPath.section == 1){
        static NSString *CellIdentifier = @"Cell1";
        CollectionViewCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[CollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.delegate = self;
        cell.selectStr = [NSString stringWithFormat:@"%ld",indexPath.section];
        cell.isEditor = NO;
       
        NSArray * collectDataArray = [self.peopleAray[0][@"advance_fund_amount_pdf"] componentsSeparatedByString:@"||"];
        cell.collectDataArray = collectDataArray;
        return cell;
    }
    if (indexPath.section == 2){
        static NSString *rid=@"qwecell";
        
        CollectionViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[CollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        
        cell.delegate = self;
        cell.selectStr = [NSString stringWithFormat:@"%ld",indexPath.section];
        cell.isEditor = NO;
        NSArray *array = [self.peopleAray[0][@"interview_other_pdf"] componentsSeparatedByString:@"||"];//分隔符
        cell.collectDataArray = array;
        return cell;
    }
    CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.selectStr = @"*水单";
    cell.collectDataArray = self.carInvoice;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([str isEqualToString:@"*水单"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:100 selectRowState:@"add"];
        }
    }
   
}

//删除
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    
    
    if ([str isEqualToString:@"水单"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos1"];
        }
    }
   
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];
        
        NSArray *array = @[@"资金划转授权书"];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section - 1];
        [headView addSubview:nameLabel];
        
        return headView;
    }
    if (section == 2) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];
        
        NSArray *array = @[@"面签其他资料"];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section - 2];
        [headView addSubview:nameLabel];
        
        return headView;
    }
    if (section == 3) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];
        
        NSArray *array = @[@"*水单"];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section - 3];
        [headView addSubview:nameLabel];
        
        return headView;
    }
    return nil;
}
@end
