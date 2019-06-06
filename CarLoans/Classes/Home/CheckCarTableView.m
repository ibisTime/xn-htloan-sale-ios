//
//  CheckCarTableView.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckCarTableView.h"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"
#import "ChooseCell.h"
#define Choose @"ChooseCell"
#import "CollectionViewCell.h"
@implementation CheckCarTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        [self registerClass:[UploadIdCardCell class] forCellReuseIdentifier:UploadIdCard];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 9;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 15;
    }
    if (section > 0 && section < 8) {
        return 1;
    }
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"业务编号",@"客户姓名",@"贷款银行",@"贷款金额",@"业务类型",@"业务团队",@"业务归属",@"指派归属",@"当前状态",@"落户日期",@"落户地点",@"车牌号",@"抵押日期",@"抵押地点",@"代理人",@"代理人身份证号"];
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
                                   [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull:self.model.loanBankName],[BaseModel convertNull:self.model.subbranchBankName]],
                                  [NSString stringWithFormat:@"%.2f",[_model.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",bizType],
                                  [BaseModel convertNull:self.model.teamName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.saleUserCompanyName,self.model.saleUserDepartMentName,self.model.saleUserPostName,self.model.saleUserName],
                                  [NSString stringWithFormat:@"%@-%@-%@-%@",self.model.insideJobCompanyName,self.model.insideJobDepartMentName,self.model.insideJobPostName,self.model.insideJobName],
                                  [[BaseModel user]note:_model.curNodeCode],
                                  [BaseModel convertNull:[self.model.carInfoRes[@"carSettleDatetime"] convertDate]],
                                  [BaseModel convertNull:self.model.carInfoRes[@"settleAddress"]],
                                  [BaseModel convertNull:self.model.carInfoRes[@"carNumber"]],
                                  [BaseModel convertNull:[self.model.carPledge[@"pledgeDatetime"] convertDate]],
                                  [BaseModel convertNull:self.model.carPledge[@"pledgeAddress"]],
                                  [BaseModel convertNull:self.model.carPledge[@"pledgeUser"]],
                                  [BaseModel convertNull:self.model.carPledge[@"pledgeUserIdCard"]]
                                  ];
        cell.TextFidStr = detailsArray[indexPath.row];
        return cell;
    }
    if (indexPath.section == 1) {
        UploadIdCardCell *cell= [tableView dequeueReusableCellWithIdentifier:UploadIdCard forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLbl.text = @"*代理人身份证";
        cell.nameArray = @[@"身份证正面",@"身份证反面"];
        cell.IdCardDelegate = self;
        cell.idNoFront = self.idNoFront;
        cell.idNoReverse = self.idNoReverse;
        return cell;
    }
    if (indexPath.section == 8) {
        if (indexPath.row == 0) {
            ChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"*提交时间";
            cell.tag = 1000 + indexPath.row;
            return cell;
        }
        static NSString *rid=@"cell123";
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.name = @"*提交说明";
        cell.nameTextField.tag = 1000+indexPath.row;
        return cell;
    }

    static NSString *rid=@"CollectionViewCell";
    CollectionViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[CollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
    }
    cell.delegate = self;
    cell.isEditor = NO;
    cell.selectStr = [NSString stringWithFormat:@"%ld",indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.section) {
        case 2:
        {
            cell.collectDataArray = self.BankVideoArray;
            break;
            
        }
        case 3:
        {
            cell.collectDataArray = self.CompanyVideoArray;
            break;
        }
        case 4:
        {
            cell.collectDataArray = self.OtherVideoArray;
            break;
        }
        case 5:
        {
            cell.collectDataArray = self.BankSignArray;
            break;
        }
        case 6:
        {
            cell.collectDataArray = self.BankContractArray;
            break;
        }
        case 7:
        {
            cell.collectDataArray = self.CompanyContractArray;
            break;
        }
        default:
            break;
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return SCREEN_WIDTH/3 + 70;
    }
    if (indexPath.section == 2) {
        float numberToRound;
        int result;
        numberToRound = (_BankVideoArray.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 45)/4 + 30) + 15;
    }
    if (indexPath.section == 3) {
        float numberToRound;
        int result;
        numberToRound = (_CompanyVideoArray.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 45)/4 + 30) + 15;
    }
    if (indexPath.section == 4) {
        float numberToRound;
        int result;
        numberToRound = (_OtherVideoArray.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 45)/4 + 30) + 15;
    }
    if (indexPath.section == 5) {
        float numberToRound;
        int result;
        numberToRound = (self.BankSignArray.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 45)/3 + 30) + 15;
    }
    if (indexPath.section == 6) {
        float numberToRound;
        int result;
        numberToRound = (self.BankContractArray.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 45)/3 + 30) + 15;
    }
    if (indexPath.section == 7) {
        float numberToRound;
        int result;
        numberToRound = (self.CompanyContractArray.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 45)/3 + 30) + 15;
    }
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 8) {
        return 100;
    }
    return 0.01;
}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
//    return 0.01;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    return 0.001;
    if (section==0 || section == 1 || section == 8) {
        return 0.01;
    }else{
        return 50;
        
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 8) {
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section >1 && section <8) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];
        
        NSArray *array = @[@"*绿大本",@"*车钥匙",@"*车辆批单",@"*登记证书",@"*车辆行驶证",@"*完税证明"];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section-2];
        [headView addSubview:nameLabel];
        
        return headView;
    }else{
        
        return [UIView new];
    }
}

-(void)confirmButtonClick:(UIButton *)sender{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"confirm"];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}
-(void)UploadIdCardBtn:(UIButton *)sender{
    if (sender.tag == 50) {
        [[BaseModel user]AlterImageByUrl:self.idNoFront];
    }
    if (sender.tag == 51) {
        [[BaseModel user]AlterImageByUrl:self.idNoReverse];
    }
    
}
@end
