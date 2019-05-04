//
//  ToApplyForRightTableView2.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForRightTableView2.h"

@interface ToApplyForRightTableView2 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation ToApplyForRightTableView2
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        //        [self registerClass:[ToApplyForEncapsulationCell class] forCellReuseIdentifier:ToApplyForEncapsulation];
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [TopModel user].ary2.count;
    }
    return 2;
}



#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        // 定义cell标识  每个cell对应一个自己的标识
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
        // 通过不同标识创建cell实例
        ToApplyForEncapsulationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
        if (!cell) {
            cell = [[ToApplyForEncapsulationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        NSArray *topArray = @[@"*业务类型",@"*机动车销售公司",@"*开票单价",@"*开票价格",@"*车辆类型",@"*车辆品牌",@"*车辆车系",@"*车辆车型",@"*车辆颜色",@"*车架号",@"*发动机号",@"*市场指导价",@"*所属区域",@"*厂家贴息",@"*油补公里数",@"油补（元）",@"抵押代理人",@"抵押地点",@"*落户地点"];
        cell.topLbl.text = [TopModel user].ary2[indexPath.row];
        
        if (indexPath.row == 1 || indexPath.row == 4 ||indexPath.row == 5 ||indexPath.row == 6 ||indexPath.row == 7 || indexPath.row == 12)
        {
            cell.type = ChooseType;
            cell.chooseLbl.tag = 20000 + indexPath.row;
        }else if (indexPath.row == 0)
        {
            cell.type = ShowType;
            cell.showLbl.tag = 20000 + indexPath.row;
        }
        else
        {
            cell.type = InputType;
            cell.inputTextField.tag = 20000 + indexPath.row;
        }
        if (indexPath.row == 0) {
            cell.bottomStr = self.model.bizTypeStr;
        }
        
        return cell;
    }
    // 定义cell标识  每个cell对应一个自己的标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    // 通过不同标识创建cell实例
    ToApplyForUpdateImgCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[ToApplyForUpdateImgCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *topArray = @[@"合格证",@"车辆照片"];
    cell.name = topArray[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.muArray = [NSMutableArray array];
        cell.muArray = [NSMutableArray arrayWithArray:self.carHgzPic];
    }
    else
    {
        cell.muArray = [NSMutableArray array];
        cell.muArray = [NSMutableArray arrayWithArray:self.carPic];
    }
    
    MJWeakSelf;
    cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {

        weakSelf.returnAryBlock(imgAry, name);
        if ([name isEqualToString:@"合格证"]) {
            weakSelf.carHgzPic = imgAry;
        }else
        {
            weakSelf.carPic = imgAry;
        }
        [self reloadData];
    };
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
    if (indexPath.row == 0) {
        float numberToRound;
        int result;
        numberToRound = (self.carHgzPic.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
    }
    float numberToRound;
    int result;
    numberToRound = (self.carPic.count + 1.0)/3.0;
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
        nameLbl.text = @"车辆信息";
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
