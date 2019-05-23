//
//  ClaimsTableView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ClaimsTableView.h"
#import "TextFieldCell.h"
#import "ChooseCell.h"
#define TextField @"TextFieldCell"
#define TextFiel @"ChooseCell"

@interface ClaimsTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic ,strong) UILabel * nameLabel;
@property (nonatomic ,strong) UILabel * carLabel;
@property (nonatomic ,strong) UILabel * numberLabel;
@property (nonatomic ,strong) UILabel * name;
@property (nonatomic ,strong) UILabel * car;
@property (nonatomic ,strong) UILabel * number;

@end
@implementation ClaimsTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[TextFieldCell class] forCellReuseIdentifier:TextField];
        [self registerClass:[ChooseCell class] forCellReuseIdentifier:TextFiel];

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
//    if (section ==0) {
//        return 1;
//
//    }
    return 3;
//    else{
//        if (self.teamStr) {
//            return 4;
//
//        }else{
//            return 3;
//
//        }
//
//    }
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section ==0) {
//        ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:TextFiel forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.name = @"申领类型";
//        cell.details = self.teamStr;
//        cell.xiaImage.image = HGImage(@"you");
//        cell.xiaImage.frame = CGRectMake(SCREEN_WIDTH - 25, 17.5, 7.5, 15);
//        return cell;
//    }
//    else{
//        if (self.teamStr) {
//            if (indexPath.row == 0) {
//                ChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:TextFiel forIndexPath:indexPath];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                if ([self.teamStr isEqualToString:@"本部"]) {
//                    cell.name = @"匹配客户";
//                    cell.details = self.teamname;
//
//                }else{
//                    cell.name = @"匹配团队";
//                    cell.details = self.teamname;
//
//                    self.isList = NO;
//                    self.carLabel.hidden = YES;
//                    self.nameLabel.hidden = YES;
//                    self.numberLabel.hidden = YES;
//                    self.car.hidden = YES;
//                    self.number.hidden = YES;
//                    self.name.hidden = YES;
//                }
//                cell.xiaImage.image = HGImage(@"you");
//                cell.details = self.teamname;
//                cell.xiaImage.frame = CGRectMake(SCREEN_WIDTH - 25, 17.5, 7.5, 15);
//                if (self.isList == YES) {
//                    self.carLabel.hidden = YES;
//                    self.nameLabel.hidden = YES;
//                    self.numberLabel.hidden = YES;
//                    self.car.hidden = YES;
//                    self.number.hidden = YES;
//                    self.name.hidden = YES;
//
//                    UILabel * nameLabel = [UILabel labelWithFrame:CGRectMake(15, 50, 100, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//                    self.nameLabel = nameLabel;
//                    UILabel * carLabel = [UILabel labelWithFrame:CGRectMake(15, 90, 100, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//                    self.carLabel = carLabel;
//
//                    UILabel * numberLabel = [UILabel labelWithFrame:CGRectMake(15, 130, 100, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//                    self.numberLabel = numberLabel;
//
//                    UILabel * name = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH-150, 50, 130, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//                    UILabel * car = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH-150, 90, 130, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//                    UILabel * number = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH-150, 130, 130, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(13) textColor:[UIColor blackColor]];
//                    self.name = name;
//                    self.number = number;
//                    self.car = car;
//
//
//
//                    nameLabel.text = @"客户姓名";
//                    carLabel.text = @"客户手机号";
//                    numberLabel.text = @"车架号";
//                    name.text = self.model.applyUserName;
//                    car.text = self.model.mobile;
//                    number.text = self.model.carFrameNo;
//                    [cell addSubview:nameLabel];
//                    [cell addSubview:carLabel];
//                    [cell addSubview:numberLabel];
//                    [cell addSubview:name];
//                    [cell addSubview:car];
//                    [cell addSubview:number];
//
//                }
//                return cell;
//            }
//        }
        TextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:TextField forIndexPath:indexPath];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray;
        NSArray *nameTextArray;
//        if (self.teamStr) {
//            nameArray = @[@"",@"申领有线个数",@"申领无线个数",@"申领说明"];
//            nameTextArray = @[@"",@"请输入申领个数",@"申领无线个数",@"请输入申领说明"];
//
//        }else{
//            nameArray = @[@"申领有线个数",@"申领无线个数",@"申领说明"];
//            nameTextArray = @[@"请输入申领个数",@"申领无线个数",@"请输入申领说明"];
//        }
    nameArray = @[@"申领有线个数",@"申领无线个数",@"申领说明"];
    nameTextArray = @[@"请输入申领个数",@"申领无线个数",@"请输入申领说明"];
        cell.nameTextField.tag = 100 + indexPath.row;
        cell.name = nameArray[indexPath.row];
        cell.nameText = nameTextArray[indexPath.row];
        
        return cell;
        
//    }
    
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
//    if (indexPath.section == 0) {
//        return 50;
//
//    }else{
//    if (indexPath.row == 0) {
//        if (self.isList == YES) {
//            return SCREEN_HEIGHT/667*180;
//        }
//      return 50;
//    }
    return 50;
//    }
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
//    if (section == 1) {
        return 100;

//    }else{
//        return 0.01;
//
//    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
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
    }else{
        return [UIView new];
    }
   
}

-(void)confirmButtonClick:(UIButton *)sender
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {

        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:sender.tag];
    }
}


@end
