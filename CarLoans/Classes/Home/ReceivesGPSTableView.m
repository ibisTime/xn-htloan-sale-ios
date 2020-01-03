//
//  ReceivesGPSTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ReceivesGPSTableView.h"
#import "CLTextFiled.h"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "TLTextField.h"

#import "GPSCell.h"
@implementation ReceivesGPSTableView


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if ([_model.sendType isEqualToString:@"1"]) {
            return 8;
        }
        else{
            return 10;
        }
    }
    NSArray * array = _model.gpsApply[@"gpsList"];
    return array.count + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        static NSString *rid = TextField;
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        //        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = [NSArray array];
        NSArray *detailsArray  = [NSArray array];
        
        if ([_model.sendType isEqualToString:@"1"]) {
            nameArray = @[@"发件人",@"收件人姓名",@"业务团队",@"申领有线个数",@"申领无线个数",@"传递方式",@"发货时间",@"发货说明",@"备注"];
        }else{
            nameArray = @[@"发件人",@"收件人姓名",@"业务团队",@"申领有线个数",@"申领无线个数",@"传递方式",@"快递公司",@"快递单号",@"发货时间",@"发货说明",@"备注"];
        }
        
        NSString *kuaidi = [_model.sendType isEqualToString:@"2"] ? @"快递":@"线下";
        if ([_model.sendType isEqualToString:@"1"]) {
        detailsArray = @[
                                  [NSString stringWithFormat:@"%@",_model.senderName],
                                  [NSString stringWithFormat:@"%@",_model.receiverName],
                                  [NSString stringWithFormat:@"%@",_model.teamName],
                                  [NSString stringWithFormat:@"%@",_model.gpsApply[@"applyWiredCount"]],
                                  [NSString stringWithFormat:@"%@",_model.gpsApply[@"applyWirelessCount"]],
                                  kuaidi,
                                  [NSString stringWithFormat:@"%@",[_model.sendDatetime convertToDetailDate]],
                                  [NSString stringWithFormat:@"%@",_model.sendNote],
                                  ];
        }
        else{
            detailsArray = @[
                             [NSString stringWithFormat:@"%@",_model.senderName],
                             [NSString stringWithFormat:@"%@",_model.receiverName],
                             [NSString stringWithFormat:@"%@",_model.teamName],
                             [NSString stringWithFormat:@"%@",_model.gpsApply[@"applyWiredCount"]],
                             [NSString stringWithFormat:@"%@",_model.gpsApply[@"applyWirelessCount"]],
                             kuaidi,
                             [NSString stringWithFormat:@"%@",[[BaseModel user] setParentKey:@"kd_company" setDkey:_model.logisticsCompany]],
                             [NSString stringWithFormat:@"%@",_model.logisticsCode],
                             [NSString stringWithFormat:@"%@",[_model.sendDatetime convertToDetailDate]],
                             [NSString stringWithFormat:@"%@",_model.sendNote],
                             ];
        }
        
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        
        cell.TextFidStr = detailsArray[indexPath.row];
        if ([_model.sendType isEqualToString:@"1"]) {
            if (indexPath.row == 8) {
                cell.isInput = @"1";
            }
        }else{
            if (indexPath.row == 10) {
                cell.isInput = @"1";
            }
        }
        
        return cell;
    }
   
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section ==0) {
//        if (indexPath.row ==4) {
//            return [_model.filelist componentsSeparatedByString:@","].count *45+50;
//        }
//    }
//    if ([_model.sendType isEqualToString:@"1"]) {
//        if (indexPath.row == 6 || indexPath.row == 7) {
//            return 0;
//        }
//    }
    return 50;
    
}
#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    return 0.01;
    
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 100;
    }
    
    
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        UIButton *initiateButton = [UIButton buttonWithTitle:@"收件并审核通过" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
        initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH/2 - 30, 50);
        kViewRadius(initiateButton, 5);
        [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        initiateButton.tag = 1;
        [headView addSubview:initiateButton];
        
        UIButton *saveButton = [UIButton buttonWithTitle:@"收件待补件" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
        saveButton.frame = CGRectMake(SCREEN_WIDTH/2 + 15, 30, SCREEN_WIDTH/2 - 30, 50);
        kViewRadius(saveButton, 5);
        [saveButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        saveButton.tag = 0;
        [headView addSubview:saveButton];
        
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
