//
//  ToApplyForRightTableView1.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForRightTableView1.h"

@interface ToApplyForRightTableView1 ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation ToApplyForRightTableView1
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
    return 1;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [TopModel user].ary1.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义cell标识  每个cell对应一个自己的标识
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    // 通过不同标识创建cell实例
    ToApplyForEncapsulationCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
    if (!cell) {
        cell = [[ToApplyForEncapsulationCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        NSArray *bottomAry = @[[NSString stringWithFormat:@"%@",self.model.loanBankName],
                              [NSString stringWithFormat:@"%@",self.model.repayBiz[@"periods"]],
                               ];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.topLbl.text = [TopModel user].ary1[indexPath.row];
    
    
//    right1Label0.text = [NSString stringWithFormat:@"%@",self.model.loanBankName];
//
//    right1Label3.text = self.model.loanAmount;
//
//
//    if ([BaseModel isBlankString:self.model.repayBiz[@"loanProductName"]] == NO) {
//        right1Label1.text = [NSString stringWithFormat:@"%@",self.model.repayBiz[@"periods"]];
//        right1Label4.text = [BaseModel convertNull:self.model.repayBiz[@"loanProductName"]];
//        TLNetworking *http = [TLNetworking new];
//        http.isShowMsg = NO;
//        http.code = @"632177";
//        http.parameters[@"status"] = @"3";
//        [http postWithSuccess:^(id responseObject) {
//            LoanProductsArray = responseObject[@"data"];
//
//            for (int i = 0; i < LoanProductsArray.count; i ++) {
//                if ([LoanProductsArray[i][@"code"] isEqualToString:self.model.repayBiz[@"loanProductCode"]]) {
//                    LoanProductsDic = LoanProductsArray[i];
//                    right1Label5.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"yearRate"] floatValue]];
//                    right1Label6.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"gpsFee"] floatValue]/1000];
//                    right1Label7.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"authRate"] floatValue]/1000];
//                    right1Label8.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"backRate"] floatValue]/1000];
//                    right1Label9.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"preRate"] floatValue]/1000];
//                };
//            }
//        } failure:^(NSError *error) {
//
//        }];
//        right1Label10.text = [NSString stringWithFormat:@"%.2f",[self.model.repayBiz[@"sfAmount"] floatValue]/1000];
//        right1Label11.text = [NSString stringWithFormat:@"%@",self.model.repayBiz[@"sfRate"]];
//        right1Label12.text = [_baseModel setParentKey:@"can_or_no" setDkey:self.model.isFinacing];
//        right1Label13.text = [_baseModel setParentKey:@"can_or_no" setDkey:self.model.isAdvanceFund];
//        right1Label14.text = [_baseModel setParentKey:@"can_or_no" setDkey:self.model.isGpsAz];
//        right1Label15.text = [_baseModel setParentKey:@"can_or_no" setDkey:self.model.isPlatInsure];
//
//        [self.rightTableView1 reloadData];
//    }
    
    
    
    
    
    if (indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 12 || indexPath.row == 13 || indexPath.row == 14 || indexPath.row == 15 ) {
        cell.type = ChooseType;
        cell.chooseLbl.tag = 10000 + indexPath.row;
    }else if (indexPath.row == 10 || indexPath.row == 11 || indexPath.row == 12 || indexPath.row == 13|| indexPath.row == 16 || indexPath.row == 17 || indexPath.row == 18 || indexPath.row == 19|| indexPath.row == 20)
    {
        cell.type = InputType;
        cell.inputTextField.tag = 10000 + indexPath.row;
    }
    else
    {
        cell.type = ShowType;
        cell.showLbl.tag = 10000 + indexPath.row;
    }
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
    return 53;
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
    
    return 23;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 107 - 15, 58) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = @"贷款信息";
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
