//
//  SenderGPSTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "SenderGPSTableView.h"
#import "CLTextFiled.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#define TextField1 @"TextFieldCell"

#import "ChooseCell.h"
#define Choose @"ChooseCell"

#import "GPSCell.h"
@implementation SenderGPSTableView
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
        return 5;
    }
    if (section == 1) {
        return 2;
    }
    NSArray * array = self.model.gpsApply[@"gpsList"];
    if ([_distributionStr isEqualToString:@"快递"]) {
        if (section == 5) {
            
            return array.count + 1;
        }
    }
    else{
        if (section == 3) {
            
            return array.count + 1;
        }
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *nameArray = @[@"客户姓名",@"业务编号",@"业务团队",@"申领有线个数",@"申领无线个数"];
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_model.userName],
                                  [NSString stringWithFormat:@"%@",_model.bizCode],
                                  [NSString stringWithFormat:@"%@",_model.teamName],
                                  [NSString stringWithFormat:@"%@",_model.gpsApply[@"applyWiredCount"]],
                                  [NSString stringWithFormat:@"%@",_model.gpsApply[@"applyWirelessCount"]]
                                  ];
//        if ([cell.name isEqualToString:@"参考材料清单"]) {
//            self.distributionStr = @"参考材料清单";
//        }
        
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
//    if (indexPath.section == 1) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//
//        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:BackColor font:HGfont(13) textColor:[UIColor blackColor]];
//        nameLabel.text = self.cardStr;
//        kViewRadius(nameLabel, 5);
//        nameLabel.text = @"请选择材料清单";
//
//
//        [cell addSubview:nameLabel];
//        if (self.cardList.count>0) {
//
//            for (int i = 0; i < self.cardList.count; i++) {
//                CLTextFiled *fild = [[CLTextFiled alloc] initWithFrame:CGRectMake(15, 50+i*40, SCREEN_WIDTH-30, 40) leftTitle:@"" titleWidth:10 placeholder:@""];
//                fild.backgroundColor = kLineColor;
//                fild.font = [UIFont systemFontOfSize:13];
//                fild.text = self.cardList[i];
//
//                [cell addSubview:fild];
//                fild.enabled = NO;
//
//            }
//
//        }
//
//        return cell;
//    }
    
    if ([_distributionStr isEqualToString:@"快递"]) {
        if (indexPath.section == 1) {
            ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"*寄送方式",@"*快递公司"];
            cell.name = nameArray[indexPath.row];
            NSArray *detailsArray = @[_distributionStr,_CourierCompanyStr];
            cell.details = detailsArray[indexPath.row];
            return cell;
        }
        if (indexPath.section == 2) {
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
            
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
            view.backgroundColor = kLineColor;
            [cell addSubview:view];
            return cell;
        }
        if (indexPath.section == 3) {
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
        if (indexPath.section == 5) {
            if (indexPath.row == 0) {
                static NSString *rid=@"cell123435";
                GPSCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
                if(cell==nil){
                    cell=[[GPSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
                }
                cell.rightarray = @[@"GPS类型",@"GPS设备号"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            static NSString *rid=@"cell11234";
            GPSCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[GPSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
            }
            cell.rightarray = @[
                                [[BaseModel convertNull:self.model.gpsApply[@"gpsList"][indexPath.row - 1][@"gpsType"]]isEqualToString:@"1"]?@"有线":@"无线",
                                [BaseModel convertNull:self.model.gpsApply[@"gpsList"][indexPath.row - 1][@"gpsDevNo"]]
                                ];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *temp1 = self.remarkField.text;
        if (self.remarkKuaiField.text.length > 0) {
            temp1  = self.remarkKuaiField.text;
        }
        TLTextField *fild = [[TLTextField alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH-30, 40) leftTitle:@"发货说明" titleWidth:80 placeholder:@"选填"];
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
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        view.backgroundColor = kLineColor;
        [cell addSubview:view];
        return cell;
    }else
    {
        if (indexPath.section == 1) {
            ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"*寄送方式",@"*发货时间"];
            cell.name = nameArray[indexPath.row];
            NSArray *detailsArray = @[_distributionStr,_date];
            cell.details = detailsArray[indexPath.row];
            return cell;
        }
        if (indexPath.section == 3) {
            if (indexPath.row == 0) {
                static NSString *rid=@"cell123123";
                GPSCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
                if(cell==nil){
                    cell=[[GPSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
                }
                cell.rightarray = @[@"GPS类型",@"GPS设备号"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            static NSString *rid=@"cell1321";
            GPSCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[GPSCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
            }
            cell.rightarray = @[
                                [[BaseModel convertNull:self.model.gpsApply[@"gpsList"][indexPath.row - 1][@"gpsType"]]isEqualToString:@"1"]?@"有线":@"无线",
                                [BaseModel convertNull:self.model.gpsApply[@"gpsList"][indexPath.row - 1][@"gpsDevNo"]]
                                ];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        NSString *temp2 = self.remarkField.text;
        if (self.remarkField.text.length > 0) {
            temp2  = self.remarkField.text;
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        TLTextField *fild = [[TLTextField alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH-30, 40) leftTitle:@"发货说明" titleWidth:80 placeholder:@"选填"];
        fild.leftLbl.font = Font(14);
        fild.textAlignment = NSTextAlignmentRight;
        fild.backgroundColor = kWhiteColor;
        fild.font = [UIFont systemFontOfSize:14];
        [cell addSubview:fild];
        fild.tag = 10002;
        self.remarkField = fild;
        fild.text = temp2;
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        view.backgroundColor = kLineColor;
        [cell addSubview:view];
        //        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField1 forIndexPath:indexPath];
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.isInput = @"1";
        //        cell.name = @"备注";
        //        cell.nameText = @"选填";
        //        cell.nameTextField.tag = 1001;
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
        return self.cardList .count *40+50;
    }
    if ([_distributionStr isEqualToString:@"快递"]) {
        if (indexPath.section == 4) {
            return 50;
        }
    }else{
        if (indexPath.section == 2) {
            return 50;
        }
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
