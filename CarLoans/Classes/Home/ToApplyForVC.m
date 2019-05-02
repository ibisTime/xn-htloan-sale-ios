//
//  ToApplyForVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForVC.h"
#import "ToApplyForVCTableView.h"
#import "ToApplyForRightTableView1.h"
#import "ToApplyForRightTableView2.h"
#import "ToApplyForRightTableView3.h"
#import "ToApplyForRightTableView4.h"
#import "ToApplyForRightTableView5.h"
#import "ToApplyForRightTableView6.h"
#import "ToApplyForRightTableView7.h"
#import "ToApplyForRightTableView8.h"
#import "JHAddressPickView.h"
#import "TopModel.h"
#import "NewWaterVC.h"
@interface ToApplyForVC ()<RefreshDelegate,BaseModelDelegate>
{
    UILabel *right1Label0;    UILabel *right1Label1;    UILabel *right1Label2;    UILabel *right1Label3;    UILabel *right1Label4;    UILabel *right1Label5;    UILabel *right1Label6;    UILabel *right1Label7;    UILabel *right1Label8;    UILabel *right1Label9;    UILabel *right1Label10;    UILabel *right1Label11;    UILabel *right1Label12;    UILabel *right1Label13;    UILabel *right1Label14;    UILabel *right1Label15;    UILabel *right1Label16;    UILabel *right1Label17;    UILabel *right1Label18;    UILabel *right1Label19;    UILabel *right1Label20;    UILabel *right1Label21;
    
    UILabel *right2Label0;    UILabel *right2Label1;    UILabel *right2Label2;    UILabel *right2Label3;    UILabel *right2Label4;    UILabel *right2Label5;    UILabel *right2Label6;    UILabel *right2Label7;    UILabel *right2Label8;    UILabel *right2Label9;    UILabel *right2Label10;    UILabel *right2Label11;    UILabel *right2Label12;    UILabel *right2Label13;    UILabel *right2Label14;    UILabel *right2Label15;    UILabel *right2Label16;    UILabel *right2Label17;    UILabel *right2Label18;    UILabel *right2Label19;
    
    UILabel *right3Label0;    UILabel *right3Label1;    UILabel *right3Label2;    UILabel *right3Label3;    UILabel *right3Label4;    UILabel *right3Label5;    UILabel *right3Label6;    UILabel *right3Label7;    UILabel *right3Label8;    UILabel *right3Label9;    UILabel *right3Label10;    UILabel *right3Label11;    UILabel *right3Label12;    UILabel *right3Label13;    UILabel *right3Label14;    UILabel *right3Label15;    UILabel *right3Label16;    UILabel *right3Label17;    UILabel *right3Label18;
    
    UILabel *right4Label0;    UILabel *right4Label1;    UILabel *right4Label2;    UILabel *right4Label3;    UILabel *right4Label4;    UILabel *right4Label5;    UILabel *right4Label6;    UILabel *right4Label7;    UILabel *right4Label8;
    
    UILabel *right5Label0;    UILabel *right5Label1;    UILabel *right5Label2;    UILabel *right5Label3;    UILabel *right5Label4;    UILabel *right5Label5;    UILabel *right5Label6;    UILabel *right5Label7;    UILabel *right5Label8;    UILabel *right5Label9;    UILabel *right5Label10;
    
    UILabel *right6Label0;    UILabel *right6Label1;    UILabel *right6Label2;    UILabel *right6Label3;    UILabel *right6Label4;    UILabel *right6Label5;    UILabel *right6Label6;    UILabel *right6Label7;    UILabel *right6Label8;    UILabel *right6Label9;    UILabel *right6Label10;
    
    UILabel *right7Label0;    UILabel *right7Label1;    UILabel *right7Label2;    UILabel *right7Label3;    UILabel *right7Label4;    UILabel *right7Label5;    UILabel *right7Label6;    UILabel *right7Label7;    UILabel *right7Label8;    UILabel *right7Label9;

//    银行字典
    NSDictionary *LoanBankDic;
//    选中贷款产品字典
    NSArray *LoanProductsArray;
    NSDictionary *LoanProductsDic;
    
    
    
}
@property (nonatomic , strong)ToApplyForVCTableView *leftTableView;
@property (nonatomic , strong)ToApplyForRightTableView1 *rightTableView1;
@property (nonatomic , strong)ToApplyForRightTableView2 *rightTableView2;
@property (nonatomic , strong)ToApplyForRightTableView3 *rightTableView3;
@property (nonatomic , strong)ToApplyForRightTableView4 *rightTableView4;
@property (nonatomic , strong)ToApplyForRightTableView5 *rightTableView5;
@property (nonatomic , strong)ToApplyForRightTableView6 *rightTableView6;
@property (nonatomic , strong)ToApplyForRightTableView7 *rightTableView7;
@property (nonatomic , strong)ToApplyForRightTableView8 *rightTableView8;
@property (nonatomic , strong)BaseModel *baseModel;

@property (nonatomic , strong)UILabel *addressLabel1;
@property (nonatomic , strong)UILabel *addressLabel2;

@property (nonatomic , copy)NSString *province1;
@property (nonatomic , copy)NSString *city1;
@property (nonatomic , copy)NSString *area1;
@property (nonatomic , copy)NSString *province2;
@property (nonatomic , copy)NSString *city2;
@property (nonatomic , copy)NSString *area2;

//车辆照片
@property (nonatomic , strong)NSArray *carPic;
//合格证
@property (nonatomic , strong)NSArray *carHgzPic;
// 户口本资料
@property (nonatomic , strong)NSArray *hkBookPdf;
// 结婚证资料
@property (nonatomic , strong)NSArray *marryPdf;
// 购房合同
@property (nonatomic , strong)NSArray *houseContract;
// 购房发票
@property (nonatomic , strong)NSArray *houseInvoice;
// 居住证明
@property (nonatomic , strong)NSArray *liveProvePdf;
// 自建房证明
@property (nonatomic , strong)NSArray *buildProvePdf;
// 家访照片
@property (nonatomic , strong)NSArray *housePictureApply;
// 收入证明
@property (nonatomic , strong)NSArray *improvePdf;
// 单位前台照片
@property (nonatomic , strong)NSArray *frontTablePic;
// 单位场地照片
@property (nonatomic , strong)NSArray *workPlacePic;
// 业务员与客户合影
@property (nonatomic , strong)NSArray *salerAndcustomer;
//共还人其他资料
@property (nonatomic , strong)NSArray *mateAssetPdf;
@property (nonatomic , strong)NSArray *guaAssetPdf;

//选中单元格tag
@property (nonatomic , assign)NSInteger SelectTag;

@property (nonatomic ,strong) JHAddressPickView * pickView;


@end

@implementation ToApplyForVC

- (JHAddressPickView *)pickView{
    if (!_pickView) {
        _pickView = [[JHAddressPickView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 350 , SCREEN_WIDTH, 350)];
        _pickView.columns = 3;
        // 关闭默认支持打开上次的结果
        MJWeakSelf;
        _pickView.pickBlock = ^(NSDictionary *dic) {
            if (weakSelf.SelectTag == 60005) {
                weakSelf.province1 = dic[@"province"];
                weakSelf.city1 = dic[@"city"];
                weakSelf.area1 = dic[@"town"];
                weakSelf.addressLabel1.text = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.province1,weakSelf.city1,weakSelf.area1];
            }
            if (weakSelf.SelectTag == 70005) {
                weakSelf.province2 = dic[@"province"];
                weakSelf.city2 = dic[@"city"];
                weakSelf.area2 = dic[@"town"];
                weakSelf.addressLabel2.text = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.province2,weakSelf.city2,weakSelf.area2];
            }
        };
        //        _pickerView.isAutoOpenLast = NO;
    }
    return _pickView;
}

-(void)viewWillAppear:(BOOL)animated
{
     [self CreditFlowingWater];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"准入申请";
    [self initTableView];
//    [self.view addSubview:self.pickView];
    _baseModel = [BaseModel new];
    _baseModel.ModelDelegate = self;
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIButton *saveBtn = [UIButton buttonWithTitle:@"保存" titleColor:kWhiteColor backgroundColor:kClearColor titleFont:14];
    saveBtn.frame = CGRectMake(0, 0, 50, 44);
    [rightView addSubview:saveBtn];
    
    UIButton *applyBtn = [UIButton buttonWithTitle:@"申请" titleColor:kWhiteColor backgroundColor:kClearColor titleFont:14];
    [rightView addSubview:applyBtn];
    applyBtn.frame = CGRectMake(50, 0, 50, 44);
    
    saveBtn.tag = 100;
    applyBtn.tag = 101;
    saveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    applyBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [saveBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [applyBtn addTarget:self action:@selector(rightButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:rightView]];
    
    [self LoanBank];
   
}

//申请
-(void)rightButtonClick:(UIButton *)sender
{
    BOOL isLoanRole2 = NO;
    BOOL isLoanRole3 = NO;
    for (int i = 0; i < self.model.creditUserList.count; i ++) {
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"2"]) {
            
            isLoanRole2 = YES;
        }
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"3"]) {
            isLoanRole3 = YES;
        }
    }
    
    if (sender.tag == 101) {
        NSString *name = @"";
        for (int i = 0; i < [TopModel user].ary1.count; i ++) {
            name = [self WarningContent:[TopModel user].ary1[i] CurrentTag:10000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        
        for (int i = 0; i < [TopModel user].ary2.count; i ++) {
            name = [self WarningContent:[TopModel user].ary2[i] CurrentTag:20000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        
        
        for (int i = 0; i < [TopModel user].ary3.count; i ++) {
            name = [self WarningContent:[TopModel user].ary3[i] CurrentTag:30000 + i];
            if (![name isEqualToString:@""]) {
                
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        
        for (int i = 0; i < [TopModel user].ary4.count; i ++) {
            name = [self WarningContent:[TopModel user].ary4[i] CurrentTag:40000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        
        for (int i = 0; i < [TopModel user].ary5.count; i ++) {
            name = [self WarningContent:[TopModel user].ary5[i] CurrentTag:50000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        if (isLoanRole2 == YES) {
            for (int i = 0; i < [TopModel user].ary6.count; i ++) {
                name = [self WarningContent:[TopModel user].ary6[i] CurrentTag:60000 + i];
                if (![name isEqualToString:@""]) {
                    [TLAlert alertWithInfo:name];
                    return;
                }
            }
        }
        if (isLoanRole3 == YES) {
            for (int i = 0; i < [TopModel user].ary7.count; i ++) {
                name = [self WarningContent:[TopModel user].ary7[i] CurrentTag:70000 + i];
                if (![name isEqualToString:@""]) {
                    [TLAlert alertWithInfo:name];
                    return;
                }
            }
        }
        [self access:sender.tag - 100];
    }else
    {
        [self access:sender.tag - 100];
    }
}

-(NSString *)WarningContent:(NSString *)name CurrentTag:(NSInteger)tag
{
    UILabel *label = [self.view viewWithTag:tag];
    NSString *str = [name stringByReplacingOccurrencesOfString:@"*" withString:@""];
    if (![name hasPrefix:@"*"]) {
        return @"";
    }else if([label.text isEqualToString:@""]) {
        return [NSString stringWithFormat:@"请输入%@",str];
    }else if ([label.text isEqualToString:@"请选择"]) {
        return [NSString stringWithFormat:@"请选择%@",str];
    }else{
        return @"";
    }
}

-(void)access:(NSInteger)dealType
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.code = @"632120";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    //   处理类型(0 保存 1 发送)
    http.parameters[@"dealType"] = @(dealType);
    
//    ===================  贷款信息  ===================
    //   贷款期限
    http.parameters[@"loanPeriod"] = right1Label2.text;
    //   银行利率
    http.parameters[@"bankRate"] = right1Label3.text;
//       贷款金额（未确定）
//    http.parameters[@"loanAm"] = right1Label4.text;
    //   银行利率
    http.parameters[@"loanProductCode"] = LoanProductsDic[@"code"];
    //   年化费率
    http.parameters[@"yearRate"] = right1Label6.text;
    //   GPS费用
    http.parameters[@"gpsFee"] = @([right1Label7.text floatValue]*1000);
    //   公证费用
    http.parameters[@"authFee"] = @([right1Label8.text floatValue]*1000);
    //   返点利率
    http.parameters[@"backRate"] = right1Label9.text;
    //   前置利率
    http.parameters[@"preRate"] = right1Label10.text;
    //   首付金额
    http.parameters[@"firstAmount"] = @([right1Label11.text floatValue]*1000);
    //   首付比例
    http.parameters[@"firstRate"] = right1Label12.text;
    //   首月月供
    http.parameters[@"firstRepayAmount"] = @([right1Label13.text floatValue]*1000);
    //   月供金额
    http.parameters[@"monthAmount"] = @([right1Label14.text floatValue]*1000);
    //   是否垫资
    http.parameters[@"isAdvanceFund"] = [_baseModel setParentKey:@"can_or_no" setDvalue:right1Label15.text];
    //   是否融资
    http.parameters[@"isFinancing"] = [_baseModel setParentKey:@"can_or_no" setDvalue:right1Label16.text];
    //   是否安装gps
    http.parameters[@"isAzGps"] = [_baseModel setParentKey:@"can_or_no" setDvalue:right1Label17.text];
    //   是否我司续保
    http.parameters[@"isCompanyContinue"] = [_baseModel setParentKey:@"can_or_no" setDvalue:right1Label18.text];
    //   月供保证金
    http.parameters[@"monthDeposit"] = @([right1Label19.text floatValue]*1000);
    //   履约保证金
    http.parameters[@"lyDeposit"] = @([right1Label20.text floatValue]*1000);
    //   团队服务费
    http.parameters[@"teamFee"] = @([right1Label21.text  floatValue]*1000);
    
//    ===================  车辆信息  ===================
    //   机动车销售公司
    http.parameters[@"vehicleCompanyName"] = right2Label1.text;
    //   开票单位
    http.parameters[@"invoiceCompany"] = right2Label2.text;
    //   开票价
    http.parameters[@"invoicePrice"] = right2Label3.text;
    //   车辆类型
    http.parameters[@"carType"] = right2Label4.text;
    //   品牌
    http.parameters[@"carBrand"] = right2Label5.text;
    //   车系
    http.parameters[@"carSeries"] = right2Label6.text;
    //   车型
    http.parameters[@"carModel"] = right2Label7.text;
    //   颜色
    http.parameters[@"carColor"] = right2Label8.text;
    //   车架号
    http.parameters[@"carFrameNo"] = right2Label9.text;
    //   发动机号
    http.parameters[@"carEngineNo"] = right2Label10.text;
    //   市场指导价
    http.parameters[@"originalPrice"] = right2Label11.text;
    //   所属区域
    http.parameters[@"region"] = right2Label12.text;
    //   厂家贴息
    http.parameters[@"carDealerSubsidy"] = right2Label13.text;
    //   油补公里数
    http.parameters[@"oilSubsidyKil"] = right2Label14.text;
    //   油补
    http.parameters[@"oilSubsidy"] = right2Label15.text;
    //   代理人
    http.parameters[@"pledgeUser"] = right2Label16.text;
    //   抵押地点
    http.parameters[@"pledgeAddress"] = right2Label17.text;
    //   落户地点
    http.parameters[@"settleAddress"] = right2Label18.text;
    
//    ===================  车辆信息  ===================
    //   性别
    http.parameters[@"gender"] = [_baseModel setParentKey:@"gender" setDvalue:right3Label3.text];
    //   年龄
    http.parameters[@"age"] = right3Label4.text;
    //   民族
    http.parameters[@"nation"] = right3Label5.text;
    //   政治面貌
    http.parameters[@"political"] = [_baseModel setParentKey:@"politics" setDvalue:right3Label6.text];
    //   学历
    http.parameters[@"education"] = [_baseModel setParentKey:@"education" setDvalue:right3Label7.text];
    //   职业
    http.parameters[@"workProfession"] = right3Label8.text;
    //   职称
    http.parameters[@"postTitle"] = right3Label9.text;
    //   有无驾照
    if ([right3Label10.text isEqualToString:@"有"]) {
        http.parameters[@"isDriceLicense"] = @"1";
    }else if ([right3Label10.text isEqualToString:@"无"])
    {
        http.parameters[@"isDriceLicense"] = @"0";
    }else
    {
        http.parameters[@"isDriceLicense"] = @"";
    }
    //   现有车辆
    http.parameters[@"carTypeNow"] = right3Label11;
    //   主要收入来源
    http.parameters[@"mainIncome"] = right3Label12;
    //   家庭紧急联系人信息1 姓名
    http.parameters[@"emergencyName1"] = right3Label13.text;
    //   家庭紧急联系人信息1 与申请人关系
    http.parameters[@"emergencyRelation1"] = [_baseModel setParentKey:@"credit_user_relation" setDvalue:right3Label4.text];
    //   家庭紧急联系人信息1 手机号码
    http.parameters[@"emergencyMobile1"] = right3Label15.text;
    //   家庭紧急联系人信息2 姓名
    http.parameters[@"emergencyName2"] = right3Label16.text;
    //   家庭紧急联系人信息2 与申请人关系
    http.parameters[@"emergencyRelation2"] = [_baseModel setParentKey:@"credit_user_relation" setDvalue:right3Label7.text];
    //   家庭紧急联系人信息2 手机号码
    http.parameters[@"emergencyMobile2"] = right3Label18.text;
    
//    ===================  家庭情况  ===================
    // 婚姻状况
    http.parameters[@"marryState"] = [_baseModel setParentKey:@"marry_state" setDvalue:right4Label0.text];
    // 家庭人口
    http.parameters[@"familyNumber"] = right4Label1.text;
    // 家庭电话
    http.parameters[@"familyPhone"] = right4Label2.text;
    // 家庭主要财产
    http.parameters[@"familyMainAsset"] = right4Label3.text;
    // 主要财产包括说明
    http.parameters[@"mainAssetInclude"] = right4Label4.text;
    // 户口所在地
    http.parameters[@"residenceAddress"] = right4Label5.text;
    // 户口所在地邮编2
    http.parameters[@"postCode2"] = right4Label6.text;
    // 现居住地址
    http.parameters[@"nowAddress"] = right4Label7.text;
    // 现居住地址邮编1
    http.parameters[@"postCode"] = right4Label8.text;
    
//    ===================  家庭情况  ===================
    // 是否自己单位
    http.parameters[@"isSelfCompany"] = [_baseModel setParentKey:@"can_or_no" setDvalue:right5Label0.text];
    // 所属行业
    http.parameters[@"workBelongIndustry"] = right5Label1.text;
    // 单位性质
    http.parameters[@"workCompanyProperty"] = [_baseModel setParentKey:@"work_company_property" setDvalue:right5Label2.text];
    // 工作单位名称
    http.parameters[@"workCompanyName"] = right5Label3.text;
    // 工作单位地址
    http.parameters[@"workCompanyAddress"] = right5Label4.text;
    // 工作单位电话
    http.parameters[@"workPhone"] = right5Label5.text;
    // 何时进入现单位工作
    http.parameters[@"workDatetime"] = right5Label6.text;
    // 职位
    http.parameters[@"position"] = right5Label7.text;
    // 月收入
    http.parameters[@"workDatetime"] = right5Label8.text;
    // 职位
    http.parameters[@"otherWorkNote"] = right5Label9.text;
    
//    ===================  共还人信息  ===================
    // 配偶学历
    http.parameters[@"mateEducation"] = right6Label4.text;
    // 省市区
    http.parameters[@"mateBirthAddressProvince"] = self.province1;
    http.parameters[@"mateBirthAddressCity"] = self.city1;
    http.parameters[@"mateBirthAddressArea"] = self.area1;
    // 户籍地地址
    http.parameters[@"mateBirthAddress"] = right6Label6.text;
    // 户籍地邮编
    http.parameters[@"matePostCode"] = right6Label7.text;
    // 工作单位名称
    http.parameters[@"mateCompanyName"] = right6Label8.text;
    // 工作单位地址
    http.parameters[@"mateCompanyAddress"] = right6Label9.text;
    // 工作单位电话
    http.parameters[@"mateCompanyContactNo"] = right5Label10.text;

    
//    ===================  担保人信息  ===================
    // 配偶学历
    http.parameters[@"guaEducation"] = right6Label4.text;
    // 省市区
    http.parameters[@"guaBirthAddressProvince"] = self.province1;
    http.parameters[@"guaBirthAddressCity"] = self.city1;
    http.parameters[@"guaBirthAddressArea"] = self.area1;
    // 户籍地地址
    http.parameters[@"guaBirthAddress"] = right6Label6.text;
    // 户籍地邮编
    http.parameters[@"guaPostCode"] = right6Label7.text;
    // 工作单位名称
    http.parameters[@"guaCompanyName"] = right6Label8.text;
    // 工作单位地址
    http.parameters[@"guaCompanyAddress"] = right6Label9.text;
    // 工作单位电话
    http.parameters[@"guaCompanyContactNo"] = right5Label10.text;
    [http postWithSuccess:^(id responseObject) {
        if (dealType == 0) {
            [TLAlert alertWithSucces:@"保存成功"];
        }else
        {
            [TLAlert alertWithSucces:@"申请成功"];
        }
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"新增"]) {
        NewWaterVC *vc = [NewWaterVC new];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (refreshTableview.tag == 100) {
        UITableView *tableView = [self.view viewWithTag:indexPath.row + 101];
        [self.view bringSubviewToFront:tableView];
    }
//    贷款信息
    if (refreshTableview.tag == 101) {
        _SelectTag = indexPath.row + 10000;
//        贷款期限
        if (indexPath.row == 1) {
            
            [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"12",@"18",@"24",@"36"]] setState:@"100"];
        }
//        贷款产品
        if (indexPath.row == 4) {
            [self LoanProducts];
        }
        if (indexPath.row == 14 || indexPath.row == 15  || indexPath.row == 16  || indexPath.row == 17 || indexPath.row == 18) {
            [_baseModel ReturnsParentKeyAnArray:@"can_or_no"];
        }
    }
    
//    车辆信息
    if (refreshTableview.tag == 102) {
        _SelectTag = indexPath.row + 20000;
//        汽车经销售
        if (indexPath.row == 1) {
            [self AutomobileSales];
        }
        if (indexPath.row == 4) {
            [_baseModel ReturnsParentKeyAnArray:@"car_type"];
        }
    }
    
//    客户信息
    if (refreshTableview.tag == 103) {
        
        if (indexPath.section == 0) {
            _SelectTag = indexPath.row + 30000;
            if (indexPath.row == 3) {
                [_baseModel ReturnsParentKeyAnArray:@"gender"];
            }
            if (indexPath.row == 6) {
                [_baseModel ReturnsParentKeyAnArray:@"politics"];
            }
            if (indexPath.row == 7) {
                [_baseModel ReturnsParentKeyAnArray:@"education"];
            }
            if (indexPath.row == 10) {
                [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"有",@"无"]] setState:@"100"];
            }
            
        }
        if (indexPath.section == 1) {
            _SelectTag = indexPath.row + 30013;
            [_baseModel ReturnsParentKeyAnArray:@"credit_user_relation"];
        }
        if (indexPath.section == 2) {
            _SelectTag = indexPath.row + 30016;
            [_baseModel ReturnsParentKeyAnArray:@"credit_user_relation"];
        }
    }
//    家庭情况
    if (refreshTableview.tag == 104) {
        _SelectTag = indexPath.row + 40000;
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                [_baseModel ReturnsParentKeyAnArray:@"marry_state"];
            }
            
        }
    }
    
//    工作情况
    if (refreshTableview.tag == 105) {
        _SelectTag = indexPath.row + 50000;
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                [_baseModel ReturnsParentKeyAnArray:@"can_or_no"];
            }
            if (indexPath.row == 2) {
                [_baseModel ReturnsParentKeyAnArray:@"work_company_property"];
            }
            if (indexPath.row == 6) {
                //开始时间
                WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
                    
                    NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                    UILabel *right1Label1 = [self.view viewWithTag:_SelectTag];
                    right1Label1.text = date;
                    
                }];
                
                datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
                datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
                datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
                [datepicker show];
            }
        }
    }
    
//    共还人信息
    if (refreshTableview.tag == 106) {
        _SelectTag = indexPath.row + 60000;
        if (indexPath.row == 5) {
            [self.pickView showInView:self.view];
        }
       
    }
    
//    担保人信息
    if (refreshTableview.tag == 107) {
        _SelectTag = indexPath.row + 70000;
        if (indexPath.row == 5) {
            [self.pickView showInView:self.view];
        }
    }
    
//    流水信息
    if (refreshTableview.tag == 108) {
        _SelectTag = indexPath.row + 80000;
    }
}

//弹框代理方法
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
//
    if (_SelectTag == 10001) {
        right1Label2.text = [NSString stringWithFormat:@"%.2f",[LoanBankDic[[NSString stringWithFormat:@"rate%@",Str]] floatValue]/1000];
    }
    if (_SelectTag == 10004) {
        LoanProductsDic = LoanProductsArray[sid];
        
        right1Label5.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"yearRate"] floatValue]];
        right1Label6.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"gpsFee"] floatValue]/1000];
        right1Label7.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"authRate"] floatValue]/1000];
        right1Label8.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"backRate"] floatValue]/1000];
        right1Label9.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"preRate"] floatValue]/1000];
//        right1Label10.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"gpsFee"] floatValue]/1000];
    }
    UILabel *right1Label1 = [self.view viewWithTag:_SelectTag];
    right1Label1.text = Str;
}

-(void)LoanBank
{
    TLNetworking *http = [TLNetworking new];
    
    http.isShowMsg = NO;
    http.code = @"632036";
    http.parameters[@"code"] = self.model.loanBank;
    [http postWithSuccess:^(id responseObject) {
        LoanBankDic = responseObject[@"data"];
        
    } failure:^(NSError *error) {
        
    }];
}

//贷款产品
-(void)LoanProducts
{
    TLNetworking *http = [TLNetworking new];
    
    http.isShowMsg = NO;
    http.code = @"632177";
    http.parameters[@"status"] = @"3";

    [http postWithSuccess:^(id responseObject) {
        LoanProductsArray = responseObject[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        
        for (int i = 0; i < LoanProductsArray.count; i ++) {
            [array addObject:LoanProductsArray[i][@"name"]];
        }
        [_baseModel CustomBouncedView:array setState:@"100"];
 
    } failure:^(NSError *error) {
        
    }];
}

//        汽车经销售
-(void)AutomobileSales
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"632067";
    http.parameters[@"curNodeCode"] = @"006_03";
    [http postWithSuccess:^(id responseObject) {
        NSArray *dataArray = responseObject[@"data"];
        
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < dataArray.count; i ++) {
            [array addObject:dataArray[i][@"fullName"]];
        }
        [_baseModel CustomBouncedView:array setState:@"100"];
    } failure:^(NSError *error) {
        
    }];
}

// 列表查征信流水
-(void)CreditFlowingWater
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = YES;
    http.code = @"632497";
    http.parameters[@"bizCode"] = self.model.code;
    http.parameters[@"creditUserCode"] = self.model.creditUser[@"code"];
    [http postWithSuccess:^(id responseObject) {
        
        self.rightTableView8.WaterArray = responseObject[@"data"];
        [self.rightTableView8 reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}




-(void)initTableView
{
    self.leftTableView = [[ToApplyForVCTableView alloc] initWithFrame:CGRectMake(0, 0, 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.leftTableView.tag = 100;
    self.leftTableView.refreshDelegate = self;
    self.leftTableView.backgroundColor = kBackgroundColor;
    self.leftTableView.model = self.model;
    [self.view addSubview:self.leftTableView];
    
    self.rightTableView1 = [[ToApplyForRightTableView1 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.rightTableView1.refreshDelegate = self;
    self.rightTableView1.backgroundColor = kWhiteColor;
    self.rightTableView1.tag = 101;
    
    
    
    self.rightTableView2 = [[ToApplyForRightTableView2 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.rightTableView2.refreshDelegate = self;
    self.rightTableView2.backgroundColor = kWhiteColor;
    self.rightTableView2.tag = 102;
    
    
    self.rightTableView3 = [[ToApplyForRightTableView3 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.rightTableView3.refreshDelegate = self;
    self.rightTableView3.backgroundColor = kWhiteColor;
    self.rightTableView3.tag = 103;
    
    
    self.rightTableView4 = [[ToApplyForRightTableView4 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.rightTableView4.refreshDelegate = self;
    self.rightTableView4.backgroundColor = kWhiteColor;
    self.rightTableView4.tag = 104;
   
    
    self.rightTableView5 = [[ToApplyForRightTableView5 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.rightTableView5.refreshDelegate = self;
    self.rightTableView5.backgroundColor = kWhiteColor;
    self.rightTableView5.tag = 105;
    
    
    self.rightTableView6 = [[ToApplyForRightTableView6 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.rightTableView6.refreshDelegate = self;
    self.rightTableView6.backgroundColor = kWhiteColor;
    self.rightTableView6.tag = 106;
    
    
    self.rightTableView7 = [[ToApplyForRightTableView7 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.rightTableView7.refreshDelegate = self;
    self.rightTableView7.backgroundColor = kWhiteColor;
    self.rightTableView7.tag = 107;
    
    
    
    self.rightTableView8 = [[ToApplyForRightTableView8 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.rightTableView8.refreshDelegate = self;
    self.rightTableView8.backgroundColor = kWhiteColor;
    self.rightTableView8.tag = 108;
    
    
    self.rightTableView1.model = self.model;
    self.rightTableView2.model = self.model;
    self.rightTableView3.model = self.model;
    self.rightTableView4.model = self.model;
    self.rightTableView5.model = self.model;
    self.rightTableView6.model = self.model;
    self.rightTableView7.model = self.model;
    self.rightTableView8.model = self.model;
    
    [self.view addSubview:self.rightTableView1];
    [self.view addSubview:self.rightTableView2];
    [self.view addSubview:self.rightTableView3];
    [self.view addSubview:self.rightTableView4];
    [self.view addSubview:self.rightTableView5];
    [self.view addSubview:self.rightTableView6];
    [self.view addSubview:self.rightTableView7];
    [self.view addSubview:self.rightTableView8];
    
    self.rightTableView2.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        
    };
    self.rightTableView4.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        
    };
    self.rightTableView5.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        
    };
    self.rightTableView6.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        
    };
    
    [self.view bringSubviewToFront:self.rightTableView1];

    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self TheAssignment];
        [SVProgressHUD dismiss];
    });
    
}

-(void)TheAssignment
{
    right1Label0 = [self.view viewWithTag:10000];    right1Label1 = [self.view viewWithTag:10001];    right1Label2 = [self.view viewWithTag:10002];    right1Label3 = [self.view viewWithTag:10003];    right1Label4 = [self.view viewWithTag:10004];    right1Label5 = [self.view viewWithTag:10005];
    right1Label6 = [self.view viewWithTag:10006];    right1Label7 = [self.view viewWithTag:10007];    right1Label8 = [self.view viewWithTag:10008];    right1Label9 = [self.view viewWithTag:10009];    right1Label10 = [self.view viewWithTag:10010];    right1Label11 = [self.view viewWithTag:10011];    right1Label12 = [self.view viewWithTag:10012];    right1Label13 = [self.view viewWithTag:10013];    right1Label14 = [self.view viewWithTag:10014];    right1Label15 = [self.view viewWithTag:10015];    right1Label16 = [self.view viewWithTag:10016];    right1Label17 = [self.view viewWithTag:10017];
    right1Label18 = [self.view viewWithTag:10018];    right1Label19 = [self.view viewWithTag:10019];    right1Label20 = [self.view viewWithTag:10020];    right1Label21 = [self.view viewWithTag:10021];
    
    right2Label0 = [self.view viewWithTag:20000];    right2Label1 = [self.view viewWithTag:20001];    right2Label2 = [self.view viewWithTag:20002];    right2Label3 = [self.view viewWithTag:20003];    right2Label4 = [self.view viewWithTag:20004];    right2Label5 = [self.view viewWithTag:20005];    right2Label6 = [self.view viewWithTag:20006];    right2Label7 = [self.view viewWithTag:20007];    right2Label8 = [self.view viewWithTag:20008];    right2Label9 = [self.view viewWithTag:20009];    right2Label10 = [self.view viewWithTag:20010];    right2Label11 = [self.view viewWithTag:20011];    right2Label12 = [self.view viewWithTag:20012];    right2Label13 = [self.view viewWithTag:20013];    right2Label14 = [self.view viewWithTag:20014];    right2Label15 = [self.view viewWithTag:20015];    right2Label16 = [self.view viewWithTag:20016];    right2Label17 = [self.view viewWithTag:20017];    right2Label18 = [self.view viewWithTag:20018];
    right2Label19 = [self.view viewWithTag:20019];
    
    right3Label0 = [self.view viewWithTag:30000];    right3Label1 = [self.view viewWithTag:30001];    right3Label2 = [self.view viewWithTag:30002];    right3Label3 = [self.view viewWithTag:30003];    right3Label4 = [self.view viewWithTag:30004];    right3Label5 = [self.view viewWithTag:30005];    right3Label6 = [self.view viewWithTag:30006];    right3Label7 = [self.view viewWithTag:30007];    right3Label8 = [self.view viewWithTag:30008];    right3Label9 = [self.view viewWithTag:30009];    right3Label10 = [self.view viewWithTag:30010];    right3Label11 = [self.view viewWithTag:30011];    right3Label12 = [self.view viewWithTag:30012];    right3Label13 = [self.view viewWithTag:30013];    right3Label14 = [self.view viewWithTag:30014];    right3Label15 = [self.view viewWithTag:30015];    right3Label16 = [self.view viewWithTag:30016];    right3Label17 = [self.view viewWithTag:30017];    right3Label18 = [self.view viewWithTag:30018];
    
    right4Label0 = [self.view viewWithTag:40000];    right4Label1 = [self.view viewWithTag:40001];    right4Label2 = [self.view viewWithTag:40002];    right4Label3 = [self.view viewWithTag:40003];    right4Label4 = [self.view viewWithTag:40004];    right4Label5 = [self.view viewWithTag:40005];    right4Label6 = [self.view viewWithTag:40006];    right4Label7 = [self.view viewWithTag:40007];    right4Label8 = [self.view viewWithTag:40008];
    
    right5Label0 = [self.view viewWithTag:50000];    right5Label1 = [self.view viewWithTag:50001];    right5Label2 = [self.view viewWithTag:50002];    right5Label3 = [self.view viewWithTag:50003];    right5Label4 = [self.view viewWithTag:50004];    right5Label5 = [self.view viewWithTag:50005];
    right5Label6 = [self.view viewWithTag:50006];    right5Label7 = [self.view viewWithTag:50007];    right5Label8 = [self.view viewWithTag:50008];    right5Label8 = [self.view viewWithTag:50009];
    
    right6Label0 = [self.view viewWithTag:60000];    right6Label1 = [self.view viewWithTag:60001];    right6Label2 = [self.view viewWithTag:60002];    right6Label3 = [self.view viewWithTag:60003];    right6Label4 = [self.view viewWithTag:60004];    right6Label5 = [self.view viewWithTag:60005];    right6Label6 = [self.view viewWithTag:60006];    right6Label7 = [self.view viewWithTag:60007];    right6Label8 = [self.view viewWithTag:60008];    right6Label9 = [self.view viewWithTag:60009];
    
    right7Label0 = [self.view viewWithTag:70000];    right7Label1 = [self.view viewWithTag:70001];    right7Label2 = [self.view viewWithTag:70002];    right7Label3 = [self.view viewWithTag:70003];    right7Label4 = [self.view viewWithTag:70004];    right7Label5 = [self.view viewWithTag:70005];    right7Label6 = [self.view viewWithTag:70006];    right7Label7 = [self.view viewWithTag:70007];    right7Label8 = [self.view viewWithTag:70008];    right7Label9 = [self.view viewWithTag:70009];
    
    right1Label0.text = self.model.loanBankName;
    right1Label3.text = self.model.loanAmount;
    
    
    self.addressLabel1 = right6Label5;
    self.addressLabel2 = right7Label5;
    
    right3Label0.text = self.model.creditUser[@"userName"];
    right3Label1.text = self.model.creditUser[@"mobile"];
    right3Label2.text = self.model.creditUser[@"idNo"];
    
    
    for (int i = 0; i < self.model.creditUserList.count; i ++) {
        NSDictionary *creditUserDic = self.model.creditUserList[i];
        if ([creditUserDic[@"loanRole"] isEqualToString:@"2"]) {
            right6Label0.text = creditUserDic[@"userName"];
            right6Label1.text = [_baseModel setParentKey:@"credit_user_relation" setDkey:creditUserDic[@"relation"]];
            right6Label2.text = creditUserDic[@"mobile"];
            right6Label3.text = creditUserDic[@"idNo"];
        }
        if ([creditUserDic[@"loanRole"] isEqualToString:@"3"]) {
            right7Label0.text = creditUserDic[@"userName"];
            right7Label1.text = [_baseModel setParentKey:@"credit_user_relation" setDkey:creditUserDic[@"relation"]];
            right7Label2.text = creditUserDic[@"mobile"];
            right7Label3.text = creditUserDic[@"idNo"];
        }
    }
    
    

}

@end
