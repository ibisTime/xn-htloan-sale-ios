//
//  ToApplyForRightTableView9.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ToApplyForRightTableView9.h"

@implementation ToApplyForRightTableView9

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    else if (section == 1){
        return 2;
    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *rid=@"cell1";
        ToApplyForEncapsulationCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[ToApplyForEncapsulationCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        NSArray * arr =  @[@"抵押代理人",@"代理人身份证号"];
        cell.topLbl.text = arr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.type = InputType;
        cell.inputTextField.tag = 90000 + indexPath.row;
        return cell;
    }
    else if (indexPath.section == 1){
        static NSString *rid=@"cell2";
        ToApplyForUpdateImgCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[ToApplyForUpdateImgCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *topArray = @[@"代理人身份证正面",@"代理人身份证反面"];
        cell.name = topArray[indexPath.row];
        
        if (indexPath.row == 0) {
            cell.muArray = [NSMutableArray array];
            cell.muArray = [NSMutableArray arrayWithArray:self.AgentFontPic];
        }
        else
        {
            cell.muArray = [NSMutableArray array];
            cell.muArray = [NSMutableArray arrayWithArray:self.AgentReversePic];
        }
        
        MJWeakSelf;
        cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
            weakSelf.returnAryBlock(imgAry, name);
            if ([name isEqualToString:@"代理人身份证正面"]) {
                weakSelf.AgentFontPic = imgAry;
            }else
            {
                weakSelf.AgentReversePic = imgAry;
            }
            [self reloadData];
        };
        return cell;
    }
    static NSString *rid=@"cell3";
    ToApplyForEncapsulationCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[ToApplyForEncapsulationCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
    }
    NSArray * arr =  @[@"抵押地点"];
    cell.topLbl.text = arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.type = InputType;
    cell.inputTextField.tag = 90000 + 2;
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
    if (indexPath.section == 0) {
        return 53;
    }
    if (indexPath.section == 2) {
        return 50;
    }
    if (indexPath.row == 0) {
        float numberToRound;
        int result;
        numberToRound = (self.AgentFontPic.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
    }
    float numberToRound;
    int result;
    numberToRound = (self.AgentReversePic.count + 1.0)/3.0;
    result = (int)ceilf(numberToRound);
    return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 58;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 107 - 15, 58) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = @"抵押信息";
        [headView addSubview:nameLbl];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 57, SCREEN_WIDTH - 107, 1)];
        lineView.backgroundColor = kLineColor;
        [headView addSubview:lineView];
        
        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
@end
