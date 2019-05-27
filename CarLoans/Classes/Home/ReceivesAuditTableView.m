//
//  ReceivesAuditTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/8.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ReceivesAuditTableView.h"
#import "CLTextFiled.h"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "TLTextField.h"
@interface ReceivesAuditTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ReceivesAuditTableView

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
    return 1;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_model.sendType isEqualToString:@"1"]) {
        return 13;
    }
    return 15;

   
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int count;
    if ([_model.sendType isEqualToString:@"1"]) {
        count = 12;
    }else{
        count = 14;
    }
    if (indexPath.row < count) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray  = [NSArray array];
        if ([_model.sendType isEqualToString:@"1"]) {
            nameArray = @[@"客户姓名",@"业务编号",@"发件节点",@"收件节点",
                          @"发件人",
                          @"业务团队",
                          @"信贷专员",
                          @"内勤专员",@"参考材料清单",@"寄送方式",@"发货时间",@"发货备注"];
        }else{
            nameArray = @[@"客户姓名",@"业务编号",@"发件节点",@"收件节点",
                          @"发件人",
                          @"业务团队",
                          @"信贷专员",
                          @"内勤专员",@"参考材料清单",@"寄送方式",@"快递公司",@"快递单号",@"发货时间",@"发货备注"];
        }
        cell.name = nameArray[indexPath.row];
        cell.isInput = @"0";
        if (indexPath.row == 4 || indexPath.row == 9) {
            cell.isInput = @"1";
            
        }else{
            cell.isInput = @"0";
            
        }
        NSString *kuaidi = [_model.sendType isEqualToString:@"2"] ? @"快递":@"线下";
        NSArray *idArr = [_model.filelist componentsSeparatedByString:@","];
        NSMutableArray *cadArray = [NSMutableArray array];
        if (idArr.count > 0  && self.models.count > 0) {
            
            for (int i = 0; i <idArr.count; i++) {
                for (CadListModel*mode in self.models) {
                    if ([idArr[i] isEqualToString:mode.id]) {
                        [cadArray addObject:[NSString stringWithFormat:@"%@-%@份",mode.vname,mode.number]];
                    }
                }
            }
            
        }
        NSArray *detailsArray = [NSArray array];
        if ([_model.sendType isEqualToString:@"1"]) {
            detailsArray = @[
                             [NSString stringWithFormat:@"%@",_model.customerName],
                             [NSString stringWithFormat:@"%@",_model.bizCode],
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:_model.fromNodeCode]],
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:_model.toNodeCode]],
                             [NSString stringWithFormat:@"%@",_model.senderName],
                             [NSString stringWithFormat:@"%@",_model.teamName],
                             [NSString stringWithFormat:@"%@",_model.saleUserName],
                             [NSString stringWithFormat:@"%@",_model.insideJobName],
                             [NSString stringWithFormat:@"%@",[cadArray componentsJoinedByString:@","]],
                             kuaidi,
                             [NSString stringWithFormat:@"%@",[_model.sendDatetime convertToDetailDate]],
                             [NSString stringWithFormat:@"%@",_model.sendNote]
                             
                             ];
        }else{
            detailsArray = @[
                             [NSString stringWithFormat:@"%@",_model.customerName],
                             [NSString stringWithFormat:@"%@",_model.bizCode],
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:_model.fromNodeCode]],
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:_model.toNodeCode]],
                             [NSString stringWithFormat:@"%@",_model.senderName],
                             [NSString stringWithFormat:@"%@",_model.teamName],
                             [NSString stringWithFormat:@"%@",_model.saleUserName],
                             [NSString stringWithFormat:@"%@",_model.insideJobName],
                             [NSString stringWithFormat:@"%@",[cadArray componentsJoinedByString:@","]],
                             kuaidi,
                             [NSString stringWithFormat:@"%@",[[BaseModel user] setParentKey:@"kd_company" setDkey:_model.logisticsCompany]],
                             [NSString stringWithFormat:@"%@",_model.logisticsCode],
                             [NSString stringWithFormat:@"%@",[_model.sendDatetime convertToDetailDate]],
                             [NSString stringWithFormat:@"%@",_model.sendNote]
                             
                             ];
        }
        if (indexPath.row ==8) {
            if (cadArray.count>1) {
                
                for (int i = 0; i < cadArray.count; i++) {
                    CLTextFiled *fild = [[CLTextFiled alloc] initWithFrame:CGRectMake(15, 50+i*40, SCREEN_WIDTH-30, 40) leftTitle:@"" titleWidth:10 placeholder:@""];
                    fild.backgroundColor = kLineColor;
                    fild.font = [UIFont systemFontOfSize:13];
                    
                    fild.contentLab.text = cadArray[i];
                    [cell addSubview:fild];
                    fild.enabled = NO;
                    
                }
                
            }
        }else{
            cell.TextFidStr = detailsArray[indexPath.row];
            
        }
        return cell;
    }
    static NSString *rid=@"textcel";
    TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"备注";
    cell.nameTextField.placeholder = @"请输入备注";
    cell.nameTextField.tag = 10000;
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
    if (indexPath.section ==0) {
        if (indexPath.row ==8) {
            return [_model.filelist componentsSeparatedByString:@","].count *45+50;
        }
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
    if (section == 0) {
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
    if (section == 0) {
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
