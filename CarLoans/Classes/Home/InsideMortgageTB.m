//
//  InsideMortgageTB.m
//  CarLoans
//
//  Created by shaojianfei on 2018/11/13.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "InsideMortgageTB.h"
#import "CollectionViewCell.h"
#define CarSettledUpdataPhoto @"CollectionViewCell"
#import "TextFieldCell.h"
#define TextField @"TextFieldCell"

#import "ChooseCell.h"
#define Choose @"ChooseCell"
#define UploadIdCard @"UploadIdCardCell"
@interface InsideMortgageTB ()<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate>


@end
@implementation InsideMortgageTB

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CarSettledUpdataPhoto];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
//        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:@"CollectionViewCell"];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:Choose];
        [self registerClass:[UploadIdCardCell class] forCellReuseIdentifier:UploadIdCard];
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 9;
    }
    else if (section == 1){
        return 7;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
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
                                  [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull:self.model.loanBankName],[BaseModel convertNull:self.model.subbranchBankName]],
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
        if (indexPath.row == 0) {
            ChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"*落户日期";
            cell.tag = 10000 + indexPath.row;
            return cell;
        }
        else if (indexPath.row == 1 || indexPath.row == 2){
            static NSString *rid=@"cell";
            TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray * arr = @[@"*落户地点",@"*车牌号"];
            cell.name = arr[indexPath.row - 1];
            cell.nameTextField.tag = 10000+indexPath.row;
            return cell;
        }
        else if (indexPath.row == 3){
            ChooseCell * cell = [tableView dequeueReusableCellWithIdentifier:Choose forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.name = @"*抵押日期";
            cell.tag = 10000 + indexPath.row;
            return cell;
        }
        else if (indexPath.row == 4 || indexPath.row == 5|| indexPath.row == 6){
            static NSString *rid=@"cell123";
            TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray * arr = @[@"*抵押地点",@"*代理人",@"*代理人身份证号"];
            cell.name = arr[indexPath.row - 4];
            cell.nameTextField.tag = 10000+indexPath.row;
            if (indexPath.row == 4) {
                NSString * str = cell.nameTextField.text;
                if (str.length == 0) {
                    cell.nameTextField.text = self.model.carPledge[@"pledgeAddress"];
                }
            }
            if (indexPath.row == 5) {
                NSString * str = cell.nameTextField.text;
                if (str.length == 0) {
                    cell.nameTextField.text = self.model.carPledge[@"pledgeUser"];
                }
            }
            if (indexPath.row == 6) {
                NSString * str = cell.nameTextField.text;
                if (str.length == 0) {
                    cell.nameTextField.text = self.model.carPledge[@"pledgeUserIdCard"];
                }
            }
            return cell;
        }
    }
    else if (indexPath.section == 2) {
//        UploadIdCardCell *cell= [tableView dequeueReusableCellWithIdentifier:UploadIdCard forIndexPath:indexPath];
//        static NSString *rid=@"UploadIdCardCell";
//        UploadIdCardCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
//        if(cell==nil){
//            cell=[[UploadIdCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
//        }
        UploadIdCardCell *cell = [tableView dequeueReusableCellWithIdentifier:UploadIdCard forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLbl.text = @"*代理人身份证";
        cell.nameArray = @[@"身份证正面",@"身份证反面"];
        cell.IdCardDelegate = self;
        cell.idNoFront = self.idNoFront;
        cell.idNoReverse = self.idNoReverse;
        return cell;
    }
//    static NSString *rid=@"CollectionViewCell";
//    CollectionViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
//    if(cell==nil){
//        cell=[[CollectionViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
//    }
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CarSettledUpdataPhoto forIndexPath:indexPath];
        cell.delegate = self;
        cell.selectStr = [NSString stringWithFormat:@"%ld",indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
        switch (indexPath.section) {
            case 3:
            {
                cell.collectDataArray = self.BankVideoArray;
                break;
                
            }
            case 4:
            {
                cell.collectDataArray = self.CompanyVideoArray;
                break;
            }
            case 5:
            {
                cell.collectDataArray = self.OtherVideoArray;
                break;
            }
            case 6:
            {
                cell.collectDataArray = self.BankSignArray;
                break;
            }
            case 7:
            {
                cell.collectDataArray = self.BankContractArray;
                break;
            }
            case 8:
            {
                cell.collectDataArray = self.CompanyContractArray;
                break;
            }
            default:
                break;
        }
        return cell;

}



-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:[str integerValue] selectRowState:@"add"];
    }
}

-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:[str integerValue] selectRowState:@"delete"];
    }
}

-(void)CarSettledUpdataPhotoBtn:(UIButton *)sender selectStr:(NSString *)Str
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:[Str integerValue] selectRowState:@"add"];
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
    if (indexPath.section == 0 || indexPath.section == 1) {
            return 50;
        }
        if (indexPath.section == 2) {
            return SCREEN_WIDTH/3 + 70;
        }
        if (indexPath.section == 3) {
            float numberToRound;
            int result;
            numberToRound = (_BankVideoArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/4 + 30) + 20;
        }
        if (indexPath.section == 4) {
            float numberToRound;
            int result;
            numberToRound = (_CompanyVideoArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/4 + 30) + 20;
        }
        if (indexPath.section == 5) {
            float numberToRound;
            int result;
            numberToRound = (_OtherVideoArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/4 + 30) + 20;
        }
        if (indexPath.section == 6) {
            float numberToRound;
            int result;
            numberToRound = (self.BankSignArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 30) + 20;
        }
        if (indexPath.section == 7) {
            float numberToRound;
            int result;
            numberToRound = (self.BankContractArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 30) + 20;
        }
        if (indexPath.section == 8) {
            float numberToRound;
            int result;
            numberToRound = (self.CompanyContractArray.count + 1.0)/3.0;
            result = (int)ceilf(numberToRound);
            return result * ((SCREEN_WIDTH - 45)/3 + 30) + 20;
        }
//        if (indexPath.section == 9) {
//            float numberToRound;
//            int result;
//            numberToRound = (self.MoneyArray.count + 1.0)/3.0;
//            result = (int)ceilf(numberToRound);
//            return result * ((SCREEN_WIDTH - 45)/3 + 5) + 15;
//        }


//    }
//    return SCREEN_WIDTH/3 + 15;
    return 0.01;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0 || section == 1 ||  section == 2) {
        return 0.01;
    }else{
        return 50;

    }
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 8) {
        return 80;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section >2) {
        UIView *headView = [[UIView alloc]init];

        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];

        NSArray *array = @[@"*大本扫描件",@"*车钥匙",@"*车辆批单",@"*登记证书",@"*车辆行驶证扫描件",@"*完税证明扫描件"];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section-3];
        [headView addSubview:nameLabel];

        return headView;
    }else{

        return [UIView new];
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 8) {
        UIView *headView = [[UIView alloc]init];
        
        UIButton *confirmButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        confirmButton.frame = CGRectMake(20, 30, (SCREEN_WIDTH-60), 50);
        confirmButton.tag = 10000;
        
        [confirmButton setTitle:@"确认" forState:(UIControlStateNormal)];
        confirmButton.backgroundColor = MainColor;
        kViewRadius(confirmButton, 5);
        confirmButton.titleLabel.font = HGfont(18);
        [confirmButton addTarget:self action:@selector(confirmButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [headView addSubview:confirmButton];
       
        
        return headView;
    }
    return [UIView new];
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}
-(void)saveButtonButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}
#pragma mark - UploadIdCardDelegate
//身份证
-(void)UploadIdCardBtn:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
        
        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
        
    }
}

-(void)SelectButtonClick:(UIButton *)sender
{
    [_AgentDelegate selectButtonClick:sender];
}
@end
