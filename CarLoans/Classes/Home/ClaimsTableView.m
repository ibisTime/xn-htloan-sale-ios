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
#import "MenuInputCell.h"
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

    return 4;

}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if (indexPath.row == 2 || indexPath.row == 3) {
        cell.type = MenuInputType;
    }else
    {
        cell.type = MenuShowType;
    }
//    cell.rightStr = ary[indexPath.row];
    //        }
    
    NSDictionary *dataDic = [USERDEFAULTS objectForKey:USERDATA];
//    _companyLbl.text = [NSString stringWithFormat:@"%@-%@-%@",[BaseModel convertNull: dataDic[@"companyName"]],[BaseModel convertNull:dataDic[@"departmentName"]],[BaseModel convertNull:dataDic[@"postName"]]];
    
    NSArray *ary = @[[BaseModel convertNull: dataDic[@"companyName"]],[NSString stringWithFormat:@"%@-%@-%@",[BaseModel convertNull: dataDic[@"companyName"]],[BaseModel convertNull:dataDic[@"departmentName"]],[BaseModel convertNull:dataDic[@"postName"]]],@"",@""];
    cell.rightStr = ary[indexPath.row];
    
    
    
    NSArray *nameArray = @[@"所在团队",@"申请人",@"*申领个数",@"*申领原因"];
    cell.leftStr = nameArray[indexPath.row];
    NSArray *placAry = @[@"",@"",@"请填写申领个数",@"请填写申领原因"];
    //    }
    cell.placStr = placAry[indexPath.row];
    cell.rightLbl.tag = 10000 + indexPath.row;
    cell.rightTF.tag = 10000 + indexPath.row;
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
        [confirmButton setTitle:@"确定" forState:(UIControlStateNormal)];
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
