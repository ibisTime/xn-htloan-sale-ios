//
//  SettlementAuditDetailsTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SettlementAuditDetailsTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"

#import "RepayPlanCell.h"
@interface SettlementAuditDetailsTableView ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>

@end
@implementation SettlementAuditDetailsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
        _date = @"";
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
        return 11;
    }
    if (section == 1) {
        return self.model.repayPlanList.count + 1;
    }
    if (section == 4) {
        return 3;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *rid=TextField;
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"贷款人",@"手机号",@"身份证号",@"贷款金额(元)",@"是否提前还款",@"总期数",@"剩余期数",@"逾期金额",@"剩余欠款",@"未还清收成本",@"未还代偿款"];
        cell.name = nameArray[indexPath.row];
        NSArray * textarray = @[
                                [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.realName]],
                                [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.user[@"mobile"]]],
                                [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.user[@"idNo"]]],
                                [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000],
                                [self.model.isAdvanceSettled isEqualToString:@"1"]?@"是":@"否",
                                [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.periods]],
                                [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.restPeriods]],
                                [BaseModel convertNull:[NSString stringWithFormat:@"%@",self.model.overdueAmount]],
                                [NSString stringWithFormat:@"%.2f",[self.model.restAmount floatValue]/1000 ],
                                [NSString stringWithFormat:@"%.2f",[self.model.restTotalCost floatValue]/1000 ],
                                [NSString stringWithFormat:@"%.2f",[self.model.unRepayTotalAmount floatValue]/1000 ],
                                ];
        
        cell.text = textarray[indexPath.row];
        cell.nameTextField.hidden = YES;
        cell.nameTextLabel.hidden = NO;
        return cell;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            static NSString *rid=@"cell";
            RepayPlanCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[RepayPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
            }
            cell.rightarray = @[@"期数",@"还款日期",@"应还本息",@"实还金额",@"逾期金额",@"剩余欠款"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        static NSString *rid=@"cell1";
        RepayPlanCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[RepayPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.rightarray = @[[NSString stringWithFormat:@"%@",self.model.repayPlanList[indexPath.row - 1][@"curPeriods"]],
                            [NSString stringWithFormat:@"%@",[self.model.repayPlanList[indexPath.row - 1][@"repayDatetime"] convertDate]],
                            [NSString stringWithFormat:@"%.2f",[self.model.repayPlanList[indexPath.row - 1][@"repayCapital"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.repayPlanList[indexPath.row - 1][@"realRepayAmount"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.repayPlanList[indexPath.row - 1][@"overdueAmount"] floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.repayPlanList[indexPath.row - 1][@"overplusAmount"] floatValue]/1000]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 2) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"结清时间";
        cell.details = _date;
        return cell;
    }
    if (indexPath.section == 3) {
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.selectStr = @"结清证明";
        cell.collectDataArray = self.proveArray;
        return cell;
    }
    static NSString *rid=@"cell098";
    TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"可退押金金额",@"扣除违约金额",@"审核意见"];
    cell.name = nameArray[indexPath.row];
    NSArray * textarray = @[[NSString stringWithFormat:@"%.2f", [self.model.retreatDeposit floatValue]/1000],
                            [NSString stringWithFormat:@"%.2f",[self.model.cutLyDeposit floatValue]/1000],
                            @""];
    
    cell.TextFidStr = textarray[indexPath.row];
    cell.nameTextField.tag = 100000 + indexPath.row;
    if (indexPath.row == 0) {
        cell.nameTextField.hidden = YES;
        cell.nameTextLabel.hidden = NO;
    }else if (indexPath.row == 1){
        cell.nameTextField.hidden = YES;
        cell.nameTextLabel.hidden = NO;
    }
    if (indexPath.row == 2) {
        cell.nameTextField.placeholder = @"请输入审核意见";
    }
    return cell;
}

-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:100 selectRowState:@"add"];

    }
}

-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:sender.tag selectRowState:@"delete"];

    }
}


//添加证信人
-(void)buttonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
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
    if (indexPath.section == 3) {
        float numberToRound;
        int result;
        numberToRound = (self.proveArray.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
    }
    return 50;

}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        return 50;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return 100;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 3) {
        UIView *headView = [[UIView alloc]init];

        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];

        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = @"结清证明";
        [headView addSubview:nameLabel];

        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 4) {

        UIView *headView = [[UIView alloc]init];
        UIButton *initiateButton = [UIButton buttonWithTitle:@"通过" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
        initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH/2 - 30, 50);
        kViewRadius(initiateButton, 5);
        [initiateButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        initiateButton.tag = 100;
        [headView addSubview:initiateButton];

        UIButton *saveButton = [UIButton buttonWithTitle:@"不通过" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
        saveButton.frame = CGRectMake(SCREEN_WIDTH/2 + 15, 30, SCREEN_WIDTH/2 - 30, 50);
        kViewRadius(saveButton, 5);
        [saveButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        saveButton.tag = 101;
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
