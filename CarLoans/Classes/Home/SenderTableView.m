//
//  SenderTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SenderTableView.h"
#import "CLTextFiled.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#define TextField1 @"TextFieldCell"

#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "FiledCell.h"
@interface SenderTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SenderTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField1];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell3"];

        self.distributionStr = @"";
        self.date = @"";
        self.CourierCompanyStr = @"";

    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_distributionStr isEqualToString:@"快递"]) {
        return 6;
    }else
    {
        return 4;
    }
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (section == 0) {
        return 8;
    }
    if (section == 1) {
        return self.cardList.count + 1;
    }
    if (section == 2) {
        return 2;
    }
    
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        NSArray *nameArray = @[@"客户姓名",@"业务编号",@"发件节点",@"收件节点",@"业务团队",@"信贷专员",@"内勤专员",@"*参考材料清单"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [BaseModel convertNull:[NSString stringWithFormat:@"%@",_model.customerName]],
                                  [BaseModel convertNull:[NSString stringWithFormat:@"%@",_model.bizCode]],
                                  [BaseModel convertNull:[NSString stringWithFormat:@"%@",[[BaseModel user]note:self.model.fromNodeCode]]],
                                  [BaseModel convertNull:[NSString stringWithFormat:@"%@",[[BaseModel user]note:self.model.toNodeCode]]],
                                  [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.teamName]],
                                  [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.saleUserName]],
                                  [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.insideJobName]],
                                  @" "
                                  ];
        if ([cell.name isEqualToString:@"参考材料清单"]) {
            self.distributionStr = @"参考材料清单";
        }
        
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:BackColor font:HGfont(13) textColor:[UIColor blackColor]];
            nameLabel.text = self.cardStr;
            kViewRadius(nameLabel, 5);
            nameLabel.text = @"请选择材料清单";
            [cell addSubview:nameLabel];
            return cell;
        }
        static NSString *rid=@"filed";
        FiledCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[FiledCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.filedname = self.cardList[indexPath.row - 1];
        return cell;
    }

    if ([_distributionStr isEqualToString:@"快递"]) {
        if (indexPath.section == 2) {
            ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"*寄送方式",@"*快递公司"];
            cell.name = nameArray[indexPath.row];
            NSArray *detailsArray = @[_distributionStr,_CourierCompanyStr];
            if ([cell.detailsLabel.text isEqualToString:@""]) {
                cell.details = detailsArray[indexPath.row];
            }
            
            return cell;
        }
        if (indexPath.section == 3) {
            NSString *temp3 = self.remarkField.text;
            if (self.kuaidField.text.length > 0) {
                temp3  = self.kuaidField.text;
            }
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            TLTextField *fild = [[TLTextField alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH-30, 40) leftTitle:@"*快递单号" titleWidth:100 placeholder:@"请输入快递单号"];
            fild.textAlignment = NSTextAlignmentRight;
            fild.backgroundColor = kWhiteColor;
            fild.font = [UIFont systemFontOfSize:14];
            fild.tag = 10005;
            [cell addSubview:fild];
            self.kuaidField = fild;
            if (self.tempdan) {
                fild.text= self.tempdan;
                
            }else{
                fild.text = temp3;
            }
            return cell;
        }
        if (indexPath.section == 4) {
            ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"*发货时间";
            if (self.tempDate) {
                cell.details= self.tempDate;
                self.date = self.tempDate;
            }else{
                cell.details = self.date;
            }
            return cell;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *temp1 = self.remarkField.text;
        if (self.remarkKuaiField.text.length > 0) {
            temp1  = self.remarkKuaiField.text;
        }
        TLTextField *fild = [[TLTextField alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH-30, 40) leftTitle:@"发货备注" titleWidth:80 placeholder:@"选填"];
        fild.textAlignment = NSTextAlignmentRight;
        fild.backgroundColor = kWhiteColor;
        fild.font = [UIFont systemFontOfSize:14];
        fild.tag = 10001;
        [cell addSubview:fild];
        self.remarkKuaiField = fild;

        if (self.tempRemark) {
            fild.text = self.tempRemark;

        }else{
            fild.text = temp1;
        }
        return cell;
    }else
    {
        if (indexPath.section == 2) {
            ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"*寄送方式",@"*发货时间"];
            cell.name = nameArray[indexPath.row];
            NSArray *detailsArray = @[_distributionStr,_date];
            cell.details = detailsArray[indexPath.row];
            return cell;
        }
        NSString *temp2 = self.remarkField.text;
        if (self.remarkField.text.length > 0) {
            temp2  = self.remarkField.text;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TLTextField *fild = [[TLTextField alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH-30, 40) leftTitle:@"发货备注" titleWidth:80 placeholder:@"选填"];
        fild.textAlignment = NSTextAlignmentRight;

        fild.backgroundColor = kWhiteColor;
        fild.font = [UIFont systemFontOfSize:14];
        [cell addSubview:fild];
        fild.tag = 10002;
        self.remarkField = fild;
        fild.text = temp2;
        return cell;
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
    if (indexPath.section == 1) {
//        return 60;
//            return self.cardList .count *40+50;
        return 40;
        
    }
    return 50;

}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 0.1;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([_distributionStr isEqualToString:@"快递"]) {
        if (section == 5) {
            return 100;
        }
    }else
    {
        if (section == 3) {
            return 100;
        }
    }

    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([_distributionStr isEqualToString:@"快递"]) {
        if (section == 5) {
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
    }else
    {
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
