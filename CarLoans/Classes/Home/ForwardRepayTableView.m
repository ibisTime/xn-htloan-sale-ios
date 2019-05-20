//
//  ForwardRepayTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ForwardRepayTableView.h"
#import "CheckRepayCell.h"
#define Information @"CheckRepayCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"
@implementation ForwardRepayTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CheckRepayCell class] forCellReuseIdentifier:Information];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 15;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *rid=TextField;
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        NSArray *nameArray = @[
                               @"业务编号",
                               @"贷款人",
                               @"手机号",
                               @"贷款银行",
                               @"贷款金额（元）",
                               @"贷款期数",
                               @"剩余期数",
                               @"还款日",
                               @"月供（元）",
                               @"剩余欠款(元)",
                               @"未还清收总成本(元)",
                               @"逾期金额(元)",
                               @"累计逾期期数",
                               @"实际逾期期数",
                               @"放款日期"];
        cell.name = nameArray[indexPath.row];
        
        NSArray *InformationArray = @[
                                      [NSString stringWithFormat:@"%@",self.model.code],
                                      [NSString stringWithFormat:@"%@",self.model.user[@"realName"]],
                                      [NSString stringWithFormat:@"%@",self.model.user[@"mobile"]],
                                      [NSString stringWithFormat:@"%@",self.model.loanBankName],
                                      [NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000],
                                      [NSString stringWithFormat:@"%@",self.model.periods],
                                      [NSString stringWithFormat:@"%@",self.model.restPeriods],
                                      [NSString stringWithFormat:@"%@",self.model.monthDatetime],
                                      [NSString stringWithFormat:@"%.2f",[self.model.monthAmount floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.restAmount floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.restTotalCost floatValue]/1000],
                                      [NSString stringWithFormat:@"%.2f",[self.model.overdueAmount floatValue]/1000],
                                      [NSString stringWithFormat:@"%@",self.model.totalOverdueCount],
                                      [NSString stringWithFormat:@"%@",self.model.curOverdueCount],
                                      [self.model.bankFkDatetime convertToDetailDate]
                                      ];

        cell.TextFidStr = InformationArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.section == 1){
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.selectStr = @"纸质申请照片";
        
        cell.collectDataArray = self.picarr;
        return cell;
    }
    static NSString *rid=@"cell";
    TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"备注";
    cell.nameTextField.placeholder = @"请输入备注";
    cell.nameTextField.tag = 100000 + indexPath.section;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 2) {
        return 50;
    }else{
        float numberToRound;
        int result;
        numberToRound = (self.picarr.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([str isEqualToString:@"纸质申请照片"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:100 selectRowState:@"add"];
        }
    }
}
//删除
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    
    
    if ([str isEqualToString:@"纸质申请照片"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos1"];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 || section == 2) {
        return 0.01;
    }
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0 || section == 1) {
        return 0.01;
    }
    return 80;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView * view = [[UIView alloc]init];
        view.backgroundColor = kWhiteColor;
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 0, 200, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(15) textColor:kBlackColor];
        label.text = @"*纸质申请照片";
        [view addSubview:label];
        return view;
    }
    return [UIView new];
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 2) {
        UIView *headView = [[UIView alloc]init];
        
        
        UIButton *initiateButton = [UIButton buttonWithTitle:@"确认" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:18];
        initiateButton.frame = CGRectMake(15, 30, SCREEN_WIDTH - 30, 50);
        kViewRadius(initiateButton, 5);
        [initiateButton addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
        initiateButton.tag = 100;
        [headView addSubview:initiateButton];
        return headView;
    }
    return [UIView new];
}
-(void)Confirm:(UIButton *)sender{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:1000 selectRowState:@"Confirm"];
    }
}
@end
