//
//  AdmissionDetailsTableView1.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView1.h"
#import "AdmissionInformationCell.h"
@interface AdmissionDetailsTableView1 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end
@implementation AdmissionDetailsTableView1
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[AdmissionInformationCell class] forCellReuseIdentifier:@"AdmissionInformationCell"];
        
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
    
    return 11;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AdmissionInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
    if (cell == nil) {
        cell = [[AdmissionInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    _cell = cell;
    NSArray *topArray = @[@"业务编号",@"客户姓名",@"业务公司",@"区域经理",@"业务团队",@"信贷专员",@"业务内勤",@"贷款金额",@"贷款银行",@"档案存放位置",@"档案目录"];
    cell.topLbl.text = topArray[indexPath.row];
    
    NSArray *bottomArray = @[@"BO201811301836510872191",@"王壮壮",@"乌鲁木齐华途威通汽车销售有限公司",@"区域经理",@"乌鲁木齐业务二部",@"信贷专员",@"业务内勤",@"800000",@"贷款银行",@"档案存放位置",@"档案目录1-申请人及相关人员身份证件-2份、4-申请人婚姻状况证明-1份、9-保单（交强险、商业险）-1份、14-担保承诺函-1份、18-信用卡汽车分期付款业务客户告知书-1份、22-公司合同-2份、23-抵押合同-3份、15-中国工商银行信用卡汽车专项分期付款/ 担保（抵押、质押及保证）合同-3份、10-车辆完税证-1份、5-征信查询授扠书及个人信用报告査询结杲-1份、2-中国工商银行信用卡汽车专项分期付款业 务申请表-1份、19-收费告知书-1份、11-机动车登记证-1份、20-委托书-1份、12-车辆行驶证-1份、6-首付款收据-1份、3-申请人及其相关人员收入证明/收入声明-1份、7-车辆合格证-1份、13-业务核准通知书-1份、8-购车发票-1份、17-续保承诺书-1份、16-购车合同-1份、21-持卡人提供的其他资料（户口本、房产、流水、驾照）-1份"];
    cell.bottomLbl.frame = CGRectMake(15, 39, SCREEN_WIDTH - 137, 14);
    cell.bottomLbl.numberOfLines = 0;
    cell.bottomLbl.text = bottomArray[indexPath.row];
    [cell.bottomLbl sizeToFit];
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
    return _cell.bottomLbl.yy ;
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
        nameLbl.text = @"基本信息";
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
