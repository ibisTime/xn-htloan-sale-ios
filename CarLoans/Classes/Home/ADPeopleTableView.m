//
//  ADPeopleTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ADPeopleTableView.h"
#import "ChooseCell.h"
#define ChooseC @"ChooseCell"

#import "TextFieldCell.h"
#define TextField @"TextFieldCell"

#import "UploadIdCardCell.h"
#define UploadIdCard @"UploadIdCardCell"

#import "CollectionViewCell.h"
#define CollectionView @"CollectionViewCell"

@interface ADPeopleTableView ()<UITableViewDataSource,UITableViewDelegate,UploadIdCardDelegate,CustomCollectionDelegate>


@end
@implementation ADPeopleTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:ChooseC];
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[UploadIdCardCell class] forCellReuseIdentifier:UploadIdCard];
        [self registerClass:[CollectionViewCell class] forCellReuseIdentifier:CollectionView];
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
        return 3;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 7;
    }
    return 1;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
//            TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
            static NSString *rid=@"mobile";
            TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *nameArray = @[@"*手机号"];
            NSArray *placeholderArray = @[@"请输入手机号"];
            cell.name = nameArray[indexPath.row];
            cell.nameText = placeholderArray[indexPath.row];
            cell.nameTextField.tag = 20000 + indexPath.row;
            cell.nameTextField.keyboardType = UIKeyboardTypePhonePad;
            if (indexPath.row == 0) {
                if ([cell.nameTextField.text isEqualToString:@""]) {
                    cell.TextFidStr = [BaseModel convertNull: _dataDic[@"mobile"]];
                }
            }
            return cell;
        }
    if (indexPath.row == 1 || indexPath.row == 2) {
        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:ChooseC forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*贷款角色",@"*与借款人关系"];
        cell.name = nameArray[indexPath.row - 1];
        if (indexPath.row == 1) {
            if ([BaseModel isBlankString:self.loanRole] == NO) {
                cell.details = [[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:self.loanRole];
            }
        }else
        {
            if ([BaseModel isBlankString:self.relation] == NO) {
                cell.details = [[BaseModel user] setParentKey:@"credit_user_relation" setDkey:self.relation];
            }
        }
        return cell;
    }
    }
    if (indexPath.section == 1) {
        UploadIdCardCell *cell = [tableView dequeueReusableCellWithIdentifier:UploadIdCard forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameArray = @[@"身份证正面",@"身份证反面"];
        cell.nameLbl.text = @"*身份证";
        cell.IdCardDelegate = self;
        cell.idNoFront = self.idNoFront;
        cell.idNoReverse = self.idNoReverse;
        return cell;
    }
    if (indexPath.section == 2) {
//        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        NSString *rid=@"TextFieldCell123123";
        TextFieldCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[TextFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"*姓名",@"*身份证号",@"出生年月日",@"民族",@"性别",@"住址",@"签发机关"];
        cell.name = nameArray[indexPath.row];
        cell.nameTextField.tag = 21000 + indexPath.row;
        if (indexPath.row < 6) {
            if (_dataDic) {
                NSArray * array = @[[BaseModel convertNull: _dataDic[@"idCardInfo"][@"userName"]],
                                    [BaseModel convertNull: _dataDic[@"idCardInfo"][@"idNo"]],
                                    [BaseModel convertNull: _dataDic[@"idCardInfo"][@"customerBirth"]],
                                    [BaseModel convertNull: _dataDic[@"idCardInfo"][@"nation"]],
                                    [BaseModel convertNull: _dataDic[@"idCardInfo"][@"gender"]],
                                    [BaseModel convertNull: _dataDic[@"idCardInfo"][@"birthAddress"]]];
                NSString * str = cell.nameTextField.text;
                if (str.length == 0) {
                    cell.TextFidStr = array[indexPath.row];
                }else
                {
                    cell.TextFidStr = cell.nameTextField.text;
                }
                
            }
            else  {
                if (_idcardfrontmodel){
                NSArray * array = @[[BaseModel convertNull: _idcardfrontmodel.userName],
                                    [BaseModel convertNull: _idcardfrontmodel.idNo],
                                    [BaseModel convertNull: _idcardfrontmodel.customerBirth],
                                    [BaseModel convertNull: _idcardfrontmodel.nation],
                                    [BaseModel convertNull: _idcardfrontmodel.gender],
                                    [BaseModel convertNull: _idcardfrontmodel.birthAddress]];
                NSString * str = cell.nameTextField.text;
                if (str.length == 0) {
                    cell.TextFidStr = array[indexPath.row];
                }else
                {
                    cell.TextFidStr = cell.nameTextField.text;
                }
                }
                
            else{
//                NSArray * array = @[@"",@"",@"",@"",@"",@""];
                cell.text = @"";
            }
        }
            
        }
        else{
            if (_dataDic1) {
//                NSArray * array = @[[BaseModel convertNull: _dataDic1[@"idCardInfo"][@"authref"]]];
                NSString * str = cell.nameTextField.text;
                if (str.length == 0) {
                    cell.TextFidStr = [BaseModel convertNull: _dataDic1[@"idCardInfo"][@"authref"]];
                }
            }
            else if (_idcardreversemodel) {
//                NSArray * array = @[[BaseModel convertNull: _idcardreversemodel.authref]];
                NSString * str = cell.nameTextField.text;
                if (str.length == 0) {
                    cell.TextFidStr = [BaseModel convertNull: _idcardreversemodel.authref];
                }else
                {
                    cell.TextFidStr = cell.nameTextField.text;
                }
            }else{
//                NSArray * array = @[@""];
                cell.text = @"";
            }
        }
        
        return cell;
    }
    if (indexPath.section == 3) {
        CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.selectStr = @"证书";
        cell.collectDataArray = self.certificateArray;
        return cell;
    }
    CollectionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CollectionView forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.selectStr = @"面签";
    cell.collectDataArray = self.faceToFaceArray;
    return cell;

}

-(void)SelectButtonClick:(UIButton *)sender
{
    [_ButtonDelegate selectButtonClick:sender];
}

-(void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString *)str
{
    if ([str isEqualToString:@"证书"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:104 selectRowState:@"add"];

        }
    }else
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
            [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:105 selectRowState:@"add"];

        }
    }

}

//删除
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str
{
    if ([str isEqualToString:@"证书"]) {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos1"];
        }
    }else
    {
        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"DeletePhotos2"];

        }
    }

}

//身份证
-(void)UploadIdCardBtn:(UIButton *)sender
{
//    if (self.idNoFront.length == 0) {
//        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
//
//            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
//        }
//    }
//    if (self.idNoReverse.length == 0){
//        if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
//
//            [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
//        }
//    }
//    else{
        if (sender.tag == 50) {
            if (self.idNoFront.length == 0) {
                if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
                    
                    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
                }
            }
            else{
                NSMutableArray *muArray = [NSMutableArray array];
                NSArray * arr = @[self.idNoFront];
                for (int i = 0; i < arr.count; i++) {
                    [muArray addObject:[arr[i] convertImageUrl]];
                }
                NSArray *seleteArray = muArray;
                
                if (muArray.count > 0) {
                    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                    [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                        return seleteArray;
                    }];
                    
                }
            }
            
        }
        else{
            if (self.idNoReverse.length == 0){
                if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {
                    
                    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"IDCard"];
                }
            }
            else{
                NSMutableArray *muArray = [NSMutableArray array];
                NSArray * arr = @[self.idNoReverse];
                for (int i = 0; i < arr.count; i++) {
                    [muArray addObject:[arr[i] convertImageUrl]];
                }
                NSArray *seleteArray = muArray;
                
                if (muArray.count > 0) {
                    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                    [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                        return seleteArray;
                    }];
                    
                }

            }
            
        }
    }
    
//}

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
        return SCREEN_WIDTH/3 + 70;
    }
    if (indexPath.section == 3) {
        float numberToRound;
        int result;
        numberToRound = (self.certificateArray.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
    }
    if (indexPath.section == 4) {
        float numberToRound;
        int result;
        numberToRound = (self.faceToFaceArray.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 50)/3 + 10) + 20;
    }
    return 50;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 3 || section == 4) {
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
    if (section == 3 || section == 4) {
        UIView *headView = [[UIView alloc]init];

        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        backView.backgroundColor = [UIColor whiteColor];
        [headView addSubview:backView];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [headView addSubview:lineView];

        NSArray *array = @[@"*征信查询授权书",@"*手持授权书照片"];
        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
        nameLabel.text = array[section - 3];
        [headView addSubview:nameLabel];

        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    if (section == 4) {
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

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:selectRowState:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag selectRowState:@"confirm"];

    }
}


@end
