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
#import "ToApplyForRightTableView9.h"
#import "JHAddressPickView.h"
#import "TopModel.h"
#import "NewWaterVC.h"
#import "SelectedListView.h"
#import "MultiBaseView.h"

@interface ToApplyForVC ()<RefreshDelegate,BaseModelDelegate>
{
    UILabel *right1Label0;
    UILabel *right1Label1;
    UILabel *right1Label2;
    UILabel *right1Label3;
    UILabel *right1Label4;
    UILabel *right1Label5;
    UILabel *right1Label6;    UILabel *right1Label7;    UILabel *right1Label8;    UILabel *right1Label9;    UILabel *right1Label10;    UILabel *right1Label11;    UILabel *right1Label12;    UILabel *right1Label13;    UILabel *right1Label14;    UILabel *right1Label15;    UILabel *right1Label16;    UILabel *right1Label17;    UILabel *right1Label18;    UILabel *right1Label19;    UILabel *right1Label20;
    
    UILabel *right2Label0;
    UILabel *right2Label1;
    UILabel *right2Label2;
    UILabel *right2Label3;
    UILabel *right2Label4;
    UILabel *right2Label5;
    UILabel *right2Label6;
    UILabel *right2Label7;
    UILabel *right2Label8;
    UILabel *right2Label9;
    UILabel *right2Label10;
    UILabel *right2Label11;
    UILabel *right2Label12;
    UILabel *right2Label13;
    UILabel *right2Label14;
    UILabel *right2Label15;
    UILabel *right2Label16;
    UILabel *right2Label17;
    
    UILabel *right3Label0;
    UILabel *right3Label1;
    UILabel *right3Label2;
    UILabel *right3Label3;
    UILabel *right3Label4;
    UILabel *right3Label5;
    UILabel *right3Label6;
    UILabel *right3Label7;
    UILabel *right3Label8;
    UILabel *right3Label9;
    UILabel *right3Label10;
    UILabel *right3Label11;
    UILabel *right3Label12;
    UILabel *right3Label13;
    UILabel *right3Label14;
    UILabel *right3Label15;
    UILabel *right3Label16;
    UILabel *right3Label17;
    UILabel *right3Label18;
    UILabel *right3Label19;
    UILabel *right3Label20;
    UILabel *right3Label21;
    UILabel *right3Label22;
    UILabel *right3Label23;
    UILabel *right3Label24;
    UILabel *right3Label25;
    
    UILabel *right4Label0;
    UILabel *right4Label1;
    UILabel *right4Label2;
    UILabel *right4Label3;
    UILabel *right4Label4;
    UILabel *right4Label5;
    UILabel *right4Label6;
    UILabel *right4Label7;
    UILabel *right4Label8;
    UILabel *right4Label9;
    UILabel *right4Label10;
    UILabel *right4Label11;
    UILabel *right4Label12;
    
    UILabel *right5Label0;    UILabel *right5Label1;    UILabel *right5Label2;    UILabel *right5Label3;    UILabel *right5Label4;    UILabel *right5Label5;    UILabel *right5Label6;    UILabel *right5Label7;    UILabel *right5Label8;    UILabel *right5Label9;    UILabel *right5Label10;     UILabel *right5Label11;
    
    UILabel *right6Label0;    UILabel *right6Label1;    UILabel *right6Label2;    UILabel *right6Label3;    UILabel *right6Label4;    UILabel *right6Label5;    UILabel *right6Label6;    UILabel *right6Label7;    UILabel *right6Label8;    UILabel *right6Label9;    UILabel *right6Label10;
    
    UILabel *right7Label0;
    UILabel *right7Label1;
    UILabel *right7Label2;
    UILabel *right7Label3;
    UILabel *right7Label4;
    UILabel *right7Label5;
    UILabel *right7Label6;
    UILabel *right7Label7;
    UILabel *right7Label8;
    UILabel *right7Label9;
    UILabel *right7Label10;
    
    UILabel *right7Label11;
    UILabel *right7Label12;
    UILabel *right7Label13;
    UILabel *right7Label14;
    UILabel *right7Label15;
    UILabel *right7Label16;
    UILabel *right7Label17;
    UILabel *right7Label18;
    UILabel *right7Label19;
    UILabel *right7Label20;
    UILabel *right7Label21;
    
    UILabel * right9Label0;
    UILabel * right9Label1;
    UILabel * right9Label2;
    
//    银行字典
    NSDictionary *LoanBankDic;
//    选中贷款产品字典
    NSArray *LoanProductsArray;
    NSDictionary *LoanProductsDic;
    
    
    NSString * periods;
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
@property (nonatomic,strong) ToApplyForRightTableView9 * rightTableView9;

@property (nonatomic , strong)BaseModel *baseModel;

@property (nonatomic , strong)UILabel *addressLabel1;
@property (nonatomic , strong)UILabel *addressLabel2;
@property (nonatomic , strong)UILabel *addressLabel3;
@property (nonatomic , strong)UILabel *addressLabel4;
@property (nonatomic , strong)UILabel *addressLabel6;

@property (nonatomic , copy)NSString *province1;
@property (nonatomic , copy)NSString *city1;
@property (nonatomic , copy)NSString *area1;
@property (nonatomic , copy)NSString *province2;
@property (nonatomic , copy)NSString *city2;
@property (nonatomic , copy)NSString *area2;
@property (nonatomic , copy)NSString *province3;
@property (nonatomic , copy)NSString *city3;
@property (nonatomic , copy)NSString *area3;
@property (nonatomic , copy)NSString *province4;
@property (nonatomic , copy)NSString *city4;
@property (nonatomic , copy)NSString *area4;
@property (nonatomic , copy)NSString *province5;
@property (nonatomic , copy)NSString *city5;
@property (nonatomic , copy)NSString *area5;
@property (nonatomic , copy)NSString *province6;
@property (nonatomic , copy)NSString *city6;
@property (nonatomic , copy)NSString *area6;
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
//担保人其他资料
@property (nonatomic , strong)NSArray *guaAssetPdf;
@property (nonatomic , strong)NSArray *guaAssetPdf1;
//代理人身份证正面
@property (nonatomic , strong)NSArray * AgentFontPic;
//代理人身份证反面
@property (nonatomic , strong)NSArray * AgentReversePic;

@property (nonatomic,strong) NSMutableArray * MainIncomeArray;
//选中单元格tag
@property (nonatomic , assign)NSInteger SelectTag;

@property (nonatomic , assign)NSInteger SelectLeftRow;

@property (nonatomic ,strong) JHAddressPickView * pickView;

@property (nonatomic ,strong) UIButton *saveBtn;

@property (nonatomic , strong)NSArray *brandAry;
@property (nonatomic , strong)NSArray *carsAry;
@property (nonatomic , strong)NSArray *modelsAry;
@property (nonatomic , strong)NSDictionary *brandDic;
@property (nonatomic , strong)NSDictionary *carsDic;
@property (nonatomic , strong)NSDictionary *modelsDic;
@property (nonatomic,strong) NSString * belongcode;
@property (nonatomic,strong) NSMutableArray * DBRlist;
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
            }else if (weakSelf.SelectTag == 70005) {
                weakSelf.province2 = dic[@"province"];
                weakSelf.city2 = dic[@"city"];
                weakSelf.area2 = dic[@"town"];
                weakSelf.addressLabel2.text = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.province2,weakSelf.city2,weakSelf.area2];
            }
            else if (weakSelf.SelectTag == 71005) {
                weakSelf.province6 = dic[@"province"];
                weakSelf.city6 = dic[@"city"];
                weakSelf.area6 = dic[@"town"];
                weakSelf.addressLabel6.text = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.province6,weakSelf.city6,weakSelf.area6];
            }
            else if (weakSelf.SelectTag == 40005) {
                weakSelf.province3 = dic[@"province"];
                weakSelf.city3= dic[@"city"];
                weakSelf.area3 = dic[@"town"];
                weakSelf.addressLabel3.text = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.province3,weakSelf.city3,weakSelf.area3];
            }else if (weakSelf.SelectTag == 40008) {
                weakSelf.province4 = dic[@"province"];
                weakSelf.city4 = dic[@"city"];
                weakSelf.area4 = dic[@"town"];
                weakSelf.addressLabel4.text = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.province4,weakSelf.city4,weakSelf.area4];
            }
            else if (weakSelf.SelectTag == 50003){
                weakSelf.province5 = dic[@"province"];
                weakSelf.city5 = dic[@"city"];
                weakSelf.area5 = dic[@"town"];
                UILabel *right1Label1 = [weakSelf.view viewWithTag:weakSelf.SelectTag];
                right1Label1.text = [NSString stringWithFormat:@"%@ %@ %@",dic[@"province"],dic[@"city"],dic[@"town"]];
            }
            else
            {
                UILabel *right1Label1 = [weakSelf.view viewWithTag:weakSelf.SelectTag];
                right1Label1.text = [NSString stringWithFormat:@"%@ %@ %@",dic[@"province"],dic[@"city"],dic[@"town"]];
            }
        };
    }
    return _pickView;
}

-(void)viewWillAppear:(BOOL)animated
{
     [self CreditFlowingWater];
}

-(void)GetTheTag
{
   
    right1Label0 = [self.view viewWithTag:10000]; //贷款银行
    right1Label1 = [self.view viewWithTag:10001];  //贷款期限
    right1Label2 = [self.view viewWithTag:10002]; //银行利率
    right1Label3 = [self.view viewWithTag:10003]; //贷款金额
    right1Label4 = [self.view viewWithTag:10004]; //贷款产品
    right1Label5 = [self.view viewWithTag:10005]; //GPS费用
    right1Label6 = [self.view viewWithTag:10006]; //公正费用
    right1Label7 = [self.view viewWithTag:10007]; //开票价
    right1Label8 = [self.view viewWithTag:10008]; //首付金额
    right1Label9 = [self.view viewWithTag:10009]; //首付比例
    right1Label10 = [self.view viewWithTag:10010]; //是否融资
    right1Label11 = [self.view viewWithTag:10011];//是否垫资
    right1Label12 = [self.view viewWithTag:10012]; //是否安装GPS
    right1Label13 = [self.view viewWithTag:10013]; //是否我司续保
    right1Label14 = [self.view viewWithTag:10014]; //月供保证金
    right1Label15 = [self.view viewWithTag:10015]; //服务费
    right1Label16 = [self.view viewWithTag:10016]; //其它费用
    right1Label17 = [self.view viewWithTag:10017];
    right1Label18 = [self.view viewWithTag:10018];
    right1Label19 = [self.view viewWithTag:10019];
    right1Label20 = [self.view viewWithTag:10020];
    
    right2Label0 = [self.view viewWithTag:20000];
    right2Label1 = [self.view viewWithTag:20001];
    right2Label2 = [self.view viewWithTag:20002];
    right2Label3 = [self.view viewWithTag:20003];
    right2Label4 = [self.view viewWithTag:20004];
    right2Label5 = [self.view viewWithTag:20005];
    right2Label6 = [self.view viewWithTag:20006];
    right2Label7 = [self.view viewWithTag:20007];
    right2Label8 = [self.view viewWithTag:20008];
    right2Label9 = [self.view viewWithTag:20009];
    right2Label10 = [self.view viewWithTag:20010];
    right2Label11 = [self.view viewWithTag:20011];
    right2Label12 = [self.view viewWithTag:20012];
    right2Label13 = [self.view viewWithTag:20013];
    right2Label14 = [self.view viewWithTag:20014];
    right2Label15 = [self.view viewWithTag:20015];
    right2Label16 = [self.view viewWithTag:20016];
    right2Label17 = [self.view viewWithTag:20017];
    
    right3Label0 = [self.view viewWithTag:30000];
    right3Label1 = [self.view viewWithTag:30001];
    right3Label2 = [self.view viewWithTag:30002];
    right3Label3 = [self.view viewWithTag:30003];
    right3Label4 = [self.view viewWithTag:30004];
    right3Label5 = [self.view viewWithTag:30005];
    right3Label6 = [self.view viewWithTag:30006];
    right3Label7 = [self.view viewWithTag:30007];
    right3Label8 = [self.view viewWithTag:30008];
    right3Label9 = [self.view viewWithTag:30009];
    right3Label10 = [self.view viewWithTag:30010];
    right3Label11 = [self.view viewWithTag:30011];
    right3Label12 = [self.view viewWithTag:30012];
    right3Label13 = [self.view viewWithTag:30013];
    right3Label14 = [self.view viewWithTag:30014];
    right3Label15 = [self.view viewWithTag:30015];
    right3Label16 = [self.view viewWithTag:30016];
    right3Label17 = [self.view viewWithTag:30017];
    right3Label18 = [self.view viewWithTag:30018];
    right3Label19 = [self.view viewWithTag:30019];
    right3Label20 = [self.view viewWithTag:30020];
    right3Label21 = [self.view viewWithTag:30021];
    right3Label22 = [self.view viewWithTag:30022];
    right3Label23 = [self.view viewWithTag:30023];
    right3Label24 = [self.view viewWithTag:30024];
    right3Label25 = [self.view viewWithTag:30025];
    
    
    right4Label0 = [self.view viewWithTag:40000];
    right4Label1 = [self.view viewWithTag:40001];
    right4Label2 = [self.view viewWithTag:40002];
    right4Label3 = [self.view viewWithTag:40003];
    right4Label4 = [self.view viewWithTag:40004];
    right4Label5 = [self.view viewWithTag:40005];
    right4Label6 = [self.view viewWithTag:40006];
    right4Label7 = [self.view viewWithTag:40007];
    right4Label8 = [self.view viewWithTag:40008];
    right4Label9 = [self.view viewWithTag:40009];
    right4Label10 = [self.view viewWithTag:40010];
    right4Label11 = [self.view viewWithTag:40011];
    right4Label12 = [self.view viewWithTag:40012];
    
    right5Label0 = [self.view viewWithTag:50000];
    right5Label1 = [self.view viewWithTag:50001];
    right5Label2 = [self.view viewWithTag:50002];
    right5Label3 = [self.view viewWithTag:50003];
    right5Label4 = [self.view viewWithTag:50004];
    right5Label5 = [self.view viewWithTag:50005];
    right5Label6 = [self.view viewWithTag:50006];
    right5Label7 = [self.view viewWithTag:50007];
    right5Label8 = [self.view viewWithTag:50008];
    right5Label9 = [self.view viewWithTag:50009];
    right5Label10 = [self.view viewWithTag:50010];
    right5Label11 = [self.view viewWithTag:50011];
    
    right6Label0 = [self.view viewWithTag:60000];
    right6Label1 = [self.view viewWithTag:60001];
    right6Label2 = [self.view viewWithTag:60002];
    right6Label3 = [self.view viewWithTag:60003];
    right6Label4 = [self.view viewWithTag:60004];
    right6Label5 = [self.view viewWithTag:60005];
    right6Label6 = [self.view viewWithTag:60006];
    right6Label7 = [self.view viewWithTag:60007];
    right6Label8 = [self.view viewWithTag:60008];
    right6Label9 = [self.view viewWithTag:60009];
    right6Label10 = [self.view viewWithTag:60010];
    
    right7Label0 = [self.view viewWithTag:70000];
    right7Label1 = [self.view viewWithTag:70001];
    right7Label2 = [self.view viewWithTag:70002];
    right7Label3 = [self.view viewWithTag:70003];
    right7Label4 = [self.view viewWithTag:70004];
    right7Label5 = [self.view viewWithTag:70005];
    right7Label6 = [self.view viewWithTag:70006];
    right7Label7 = [self.view viewWithTag:70007];
    right7Label8 = [self.view viewWithTag:70008];
    right7Label9 = [self.view viewWithTag:70009];
    right7Label10 = [self.view viewWithTag:70010];
    
    right7Label11 = [self.view viewWithTag:71000];
    right7Label12 = [self.view viewWithTag:71001];
    right7Label13 = [self.view viewWithTag:71002];
    right7Label14 = [self.view viewWithTag:71003];
    right7Label15 = [self.view viewWithTag:71004];
    right7Label16 = [self.view viewWithTag:71005];
    right7Label17 = [self.view viewWithTag:71006];
    right7Label18 = [self.view viewWithTag:71007];
    right7Label19 = [self.view viewWithTag:71008];
    right7Label20 = [self.view viewWithTag:71009];
    right7Label21 = [self.view viewWithTag:71010];
    
    right9Label0 = [self.view viewWithTag:90000];
    right9Label1 = [self.view viewWithTag:90001];
    right9Label2 = [self.view viewWithTag:90002];
    
    
    
    right3Label3.text = [NSString stringWithFormat:@"%@", self.model.creditUser[@"gender"]];
    right3Label4.text = [NSString stringWithFormat:@"%@",self.model.creditUser[@"age"]];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"准入申请";
    [self initTableView];
    _DBRlist = [NSMutableArray array];
    _baseModel = [BaseModel new];
    _baseModel.ModelDelegate = self;
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    UIButton *saveBtn = [UIButton buttonWithTitle:@"保存" titleColor:kWhiteColor backgroundColor:kClearColor titleFont:14];
    [rightView addSubview:saveBtn];
    self.saveBtn = saveBtn;
    saveBtn.frame = CGRectMake(50, 0, 50, 44);
    saveBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [saveBtn addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:rightView]];
    
    [self LoanBank];
   
}

-(void)applyBtnClick
{

    [TLAlert alertWithTitle:@"提示" msg:@"请确保每个页面都已保存" confirmMsg:@"确认" cancleMsg:@"取消" maker:self cancle:^(UIAlertAction *action) {
        
    } confirm:^(UIAlertAction *action) {
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = NO;
        http.code = @"632538";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"申请成功"];
            NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
        }];
    }];
}

//申请
-(void)rightButtonClick
{
    
    [self GetTheTag];
    NSString *name;
    if (self.SelectLeftRow == 0) {
        for (int i = 0; i < [TopModel user].ary1.count; i ++) {
            name = [self WarningContent:[TopModel user].ary1[i] CurrentTag:10000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = NO;
        http.code = @"632530";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"dealType"] = @(1);
        //    ===================  贷款信息  ===================
        //   贷款期限
        if ([NSString isPureNumWithString:right1Label1.text]) {
            
        }else{
            http.parameters[@"periods"] = [right1Label1.text substringWithRange:NSMakeRange(0, right1Label1.text.length - 1)];
        }
        
        http.parameters[@"periods"] = [[BaseModel user]setParentKey:@"loan_period" setDvalue:right1Label1.text];
        //   银行利率
        http.parameters[@"bankRate"] = right1Label2.text;
        //   贷款金额
        http.parameters[@"loanAmount"] =[NSString stringWithFormat:@"%.f",[right1Label3.text floatValue]*1000];
        //   贷款产品
        NSString * str = LoanProductsDic[@"code"];
        if (str.length > 0) {
            http.parameters[@"loanProductCode"] = LoanProductsDic[@"code"];
        }else{
            http.parameters[@"loanProductCode"] = self.model.loanInfo[@"loanProductCode"];
        }
        
        //   年化费率
//        http.parameters[@"yearRate"] = right1Label5.text;
        //   GPS费用.f
        http.parameters[@"gpsFee"] = [NSString stringWithFormat:@"%.f",[right1Label5.text floatValue]*1000];
        //   公证费用
        http.parameters[@"authFee"] = [NSString stringWithFormat:@"%.f",[right1Label6.text floatValue]*1000];
        //   返点利率
//        http.parameters[@"backRate"] = right1Label8.text;
        //   前置利率
//        http.parameters[@"preRate"] = right1Label9.text;
        //   开票价格
        http.parameters[@"invoicePrice"] = [NSString stringWithFormat:@"%.f",[right1Label7.text  floatValue]*1000];
        //   首付金额
        http.parameters[@"sfAmount"] = [NSString stringWithFormat:@"%.f",[right1Label8.text floatValue]*1000];
        //   首付比例.f
//        http.parameters[@"sfRate"] = [NSString stringWithFormat:@"%ld",[right1Label9.text integerValue]];
        http.parameters[@"sfRate"] = right1Label9.text;
        //   是否融资
        http.parameters[@"isFinacing"] = [self CanOrNo:right1Label10.text];
        //   是否垫资
        http.parameters[@"isAdvanceFund"] = [self CanOrNo:right1Label11.text];
        //   是否安装gps
        http.parameters[@"isAzGps"] = [self CanOrNo:right1Label12.text];
        //   是否我司续保
        http.parameters[@"isPlatInsure"] = [self CanOrNo:right1Label13.text];
        //   月供保证金
        http.parameters[@"monthDeposit"] = [NSString stringWithFormat:@"%.f",[right1Label14.text floatValue]*1000];

        //   团队服务费
        http.parameters[@"teamFee"] = [NSString stringWithFormat:@"%.f",[right1Label15.text  floatValue]*1000];
        //   其他费用
        http.parameters[@"otherFee"] = [NSString stringWithFormat:@"%.f" ,[right1Label16.text  floatValue]*1000];
        
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
            
        } failure:^(NSError *error) {
            
        }];
    }
    if (self.SelectLeftRow == 1) {
        for (int i = 0; i < [TopModel user].ary2.count; i ++) {
            name = [self WarningContent:[TopModel user].ary2[i] CurrentTag:20000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = NO;
        http.code = @"632531";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"dealType"] = @(1);
        //   机动车销售公司
        http.parameters[@"vehicleCompanyName"] =[[BaseModel user]setCompanyFullName: right2Label1.text];
        //   开票单位
        http.parameters[@"invoiceCompany"] = right2Label2.text;
        //   开票价
//        http.parameters[@"invoicePrice"] = @([right2Label3.text floatValue]*1000);
        //   车辆类型
        http.parameters[@"carType"] =[[BaseModel user]setParentKey:@"car_type" setDvalue:right2Label3.text];
        //   品牌
        http.parameters[@"carBrand"] = right2Label4.text;
        //   车系
        http.parameters[@"carSeries"] = right2Label5.text;
        //   车型
        http.parameters[@"carModel"] = right2Label6.text;
        //   颜色
        http.parameters[@"carColor"] = right2Label7.text;
        //   车架号
        http.parameters[@"carFrameNo"] = right2Label8.text;
        //   发动机号
        http.parameters[@"carEngineNo"] = right2Label9.text;
        //   市场指导价
        http.parameters[@"originalPrice"] = [NSString stringWithFormat:@"%.f",[right2Label10.text floatValue]*1000];
        //   所属区域
        http.parameters[@"region"] = [_baseModel setParentKey:@"region_belong" setDvalue:right2Label11.text];
        //   厂家贴息
        http.parameters[@"carDealerSubsidy"] = [NSString stringWithFormat:@"%.f",[right2Label12.text floatValue]*1000];
        //   油补公里数
        http.parameters[@"oilSubsidyKil"] = right2Label13.text;
        //   油补
        http.parameters[@"oilSubsidy"] = [NSString stringWithFormat:@"%.f",[right2Label14.text floatValue]*1000];
        //   落户地点
        http.parameters[@"settleAddress"] = right2Label15.text;
        //   合格证
        http.parameters[@"carHgzPic"] = [_carHgzPic componentsJoinedByString:@"||"];
        //   车辆照片
        http.parameters[@"carPic"] = [_carPic componentsJoinedByString:@"||"];
        
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
            
        } failure:^(NSError *error) {
            
        }];
    }
    if (self.SelectLeftRow == 2) {
        for (int i = 0; i < [TopModel user].ary3.count; i ++) {
            name = [self WarningContent:[TopModel user].ary3[i] CurrentTag:30000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = NO;
        http.code = @"632532";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"dealType"] = @(1);
        //   性别
        http.parameters[@"gender"] = right3Label3.text;
        //   年龄
        http.parameters[@"age"] = right3Label4.text;
        //英文名
        http.parameters[@"englishName"] = right3Label5.text;
        //发证机关
        http.parameters[@"authref"] = right3Label6.text;
        //证件有效期
        http.parameters[@"statdate"] = right3Label7.text;
        //   民族
        http.parameters[@"nation"] = right3Label8.text;
        //   政治面貌
        http.parameters[@"political"] = [_baseModel setParentKey:@"politics" setDvalue:right3Label9.text];
        //   学历
        http.parameters[@"education"] = [_baseModel setParentKey:@"education" setDvalue:right3Label10.text];
        //   职业
        http.parameters[@"workProfession"] = [_baseModel setParentKey:@"work_profession" setDvalue:right3Label11.text];
        //   职称
        http.parameters[@"postTitle"] = right3Label12.text;
        //   有无驾照
        http.parameters[@"isDriceLicense"] = [right3Label13.text isEqualToString:@"有"]?@"1":@"0";
        //   现有车辆
        http.parameters[@"carType"] = right3Label14.text;
        //   主要收入来源
        http.parameters[@"mainIncome"] = [self.MainIncomeArray componentsJoinedByString:@","];
        
        //其它收入说明
        http.parameters[@"otherIncomeNote"] = right3Label16.text;
        //有无房产
         http.parameters[@"isHouseProperty"] = [right3Label17.text isEqualToString:@"有"]?@"1":@"0";
        
        
        //   家庭紧急联系人信息1 姓名
        http.parameters[@"emergencyName1"] = right3Label18.text;
        //   家庭紧急联系人信息1 性别
        http.parameters[@"emergencySex1"] =[_baseModel setParentKey:@"gender" setDvalue: right3Label19.text];
        //   家庭紧急联系人信息1 与申请人关系
        http.parameters[@"emergencyRelation1"] = [_baseModel setParentKey:@"credit_contacts_relation" setDvalue:right3Label20.text];
        //   家庭紧急联系人信息1 手机号码
        if (right3Label21.text.length != 11) {
            [TLAlert alertWithInfo:@"家庭紧急联系人信息1手机号不正确"];
            return;
        }
        http.parameters[@"emergencyMobile1"] = right3Label21.text;
        
        
        //   家庭紧急联系人信息2 姓名
        http.parameters[@"emergencyName2"] = right3Label22.text;
        //   家庭紧急联系人信息2 性别
        http.parameters[@"emergencySex2"] = [_baseModel setParentKey:@"gender" setDvalue:right3Label23.text];
        //   家庭紧急联系人信息2 与申请人关系
        http.parameters[@"emergencyRelation2"] = [_baseModel setParentKey:@"credit_contacts_relation" setDvalue:right3Label24.text];
        //   家庭紧急联系人信息2 手机号码
        if (right3Label25.text.length != 11) {
            [TLAlert alertWithInfo:@"家庭紧急联系人信息2手机号不正确"];
            return;
        }
        http.parameters[@"emergencyMobile2"] = right3Label25.text;
        
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
            
        } failure:^(NSError *error) {
            
        }];
    }
    if (self.SelectLeftRow == 3) {
        for (int i = 0; i < [TopModel user].ary4.count; i ++) {
            name = [self WarningContent:[TopModel user].ary4[i] CurrentTag:40000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = NO;
        http.code = @"632533";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"dealType"] = @"1";
        // 婚姻状况
        http.parameters[@"marryState"] = [_baseModel setParentKey:@"marry_state" setDvalue:right4Label0.text];
        // 家庭人口
        http.parameters[@"familyNumber"] = right4Label1.text;
        // 家庭电话
        http.parameters[@"familyPhone"] = right4Label2.text;
        // 家庭主要财产
        http.parameters[@"familyMainAsset"] = [NSString stringWithFormat:@"%.f",[right4Label3.text floatValue]*1000];
        // 主要财产包括说明
        http.parameters[@"mainAssetInclude"] = right4Label4.text;
        //  户籍地（省市区）
        http.parameters[@"birthAddressProvince"] = self.province3;
        http.parameters[@"birthAddressCity"] = self.city3;
        http.parameters[@"birthAddressArea"] = self.area3;
        http.parameters[@"birthAddress"] = right4Label6.text;
        // 户籍地邮编
        if (right4Label7.text.length != 6) {
            [TLAlert alertWithInfo:@"户籍地邮编格式不正确"];
            return;
        }
        http.parameters[@"birthPostCode"] = right4Label7.text;
        // 现住地（省市区）
        http.parameters[@"nowAddressProvince"] = self.province4;
        http.parameters[@"nowAddressCity"] = self.city4;
        http.parameters[@"nowAddressArea"] = self.area4;
        http.parameters[@"nowAddress"] = right4Label9.text;
        // 现居住邮编
        if (right4Label10.text.length != 6) {
            [TLAlert alertWithInfo:@"现居地邮编格式不正确"];
            return;
        }
        http.parameters[@"nowPostCode"] = right4Label10.text;
        //何时入住现址
        http.parameters[@"nowAddressDate"] = right4Label11.text;
        // 现住房屋类型
        if ([right4Label12.text isEqualToString:@"自有"]) {
            http.parameters[@"nowHouseType"] = @"0";
        }else if ([right4Label12.text isEqualToString:@"租用"])
        {
            http.parameters[@"nowHouseType"] = @"1";
        }
        // 户口本资料
        http.parameters[@"hkBookPdf"] = [_hkBookPdf componentsJoinedByString:@"||"];
        // 结婚证资料
        http.parameters[@"marryPdf"] = [_marryPdf componentsJoinedByString:@"||"];
        // 购房合同
        http.parameters[@"houseContract"] = [_houseContract componentsJoinedByString:@"||"];
        // 购房发票
        http.parameters[@"houseInvoice"] = [_houseInvoice componentsJoinedByString:@"||"];
        // 居住证明
        http.parameters[@"liveProvePdf"] = [_liveProvePdf componentsJoinedByString:@"||"];
        // 自建房证明
        http.parameters[@"buildProvePdf"] = [_buildProvePdf componentsJoinedByString:@"||"];
        // 家访照片
        http.parameters[@"housePictureApply"] = [_housePictureApply componentsJoinedByString:@"||"];
        
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
            
        } failure:^(NSError *error) {
            
        }];
    }
    if (self.SelectLeftRow == 4) {
        for (int i = 0; i < [TopModel user].ary5.count; i ++) {
            name = [self WarningContent:[TopModel user].ary5[i] CurrentTag:50000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = NO;
        http.code = @"632534";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"dealType"] = @(1);

        // 所属行业
        http.parameters[@"workBelongIndustry"] = [_baseModel setParentKey:@"work_belong_industry" setDvalue:right5Label0.text];
        // 单位性质
        http.parameters[@"workCompanyProperty"] = [_baseModel setParentKey:@"work_company_property" setDvalue:right5Label1.text];
        // 工作单位名称
        http.parameters[@"companyName"] = right5Label2.text;
        //工作单位所在地
        http.parameters[@"companyProvince"] = self.province5;
        http.parameters[@"companyCity"] = self.city5;
        http.parameters[@"companyArea"] = self.area5;
        
        // 工作单位地址
        http.parameters[@"companyAddress"] = right5Label4.text;
        // 工作单位电话
        http.parameters[@"companyContactNo"] = right5Label5.text;
        // 何时进入现单位工作
        http.parameters[@"workDatetime"] = right5Label6.text;
        // 职位
        http.parameters[@"position"] = right5Label7.text;
        // 月收入
        http.parameters[@"monthIncome"] =  [NSString stringWithFormat:@"%.f",[right5Label8.text floatValue]*1000];
        // 工作描述
        http.parameters[@"otherWorkNote"] = right5Label9.text;
        
        // 员工数量
        http.parameters[@"employeeQuantity"] = right5Label10.text;
        // 企业月产值
        http.parameters[@"enterpriseMonthOutput"] = right5Label11.text;
        
        // 收入证明
        http.parameters[@"improvePdf"] = [_improvePdf componentsJoinedByString:@"||"];
        // 单位前台照片
        http.parameters[@"frontTablePic"] = [_frontTablePic componentsJoinedByString:@"||"];
        // 单位场地照片
        http.parameters[@"workPlacePic"] = [_workPlacePic componentsJoinedByString:@"||"];
        // 业务员与客户合影
        http.parameters[@"salerAndcustomer"] = [_salerAndcustomer componentsJoinedByString:@"||"];
        
        
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
            
        } failure:^(NSError *error) {
            
        }];
    }
    if (self.SelectLeftRow == 5) {
        for (int i = 0; i < [TopModel user].ary6.count; i ++) {
            name = [self WarningContent:[TopModel user].ary6[i] CurrentTag:60000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = NO;
        http.code = @"632535";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"dealType"] = @(1);
        // 配偶学历
        http.parameters[@"education"] = [_baseModel setParentKey:@"education" setDvalue:right6Label4.text];
        // 省市区
        http.parameters[@"birthAddressProvince"] = self.province1;
        http.parameters[@"birthAddressCity"] = self.city1;
        http.parameters[@"birthAddressArea"] = self.area1;
        // 户籍地地址
        http.parameters[@"birthAddress"] = right6Label6.text;
        // 户籍地邮编
        http.parameters[@"birthPostCode"] = right6Label7.text;
        // 工作单位名称
        http.parameters[@"companyName"] = right6Label8.text;
        // 工作单位地址
        http.parameters[@"companyAddress"] = right6Label9.text;
        // 工作单位电话
        http.parameters[@"companyContactNo"] = right6Label10.text;
        http.parameters[@"mateAssetPdf"] =[_mateAssetPdf componentsJoinedByString:@"||"];
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
        } failure:^(NSError *error) {
            
        }];
    }
    if (self.SelectLeftRow == 6) {
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < self.model.creditUserList.count; i++) {
            if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"3"]) {
                [array addObject:self.model.creditUserList[i]];
            }
        }
        for (int i = 0; i < [TopModel user].ary7.count; i ++) {
            name = [self WarningContent:[TopModel user].ary7[i] CurrentTag:70000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        for (int i = 0; i < [TopModel user].ary7.count; i ++) {
            name = [self WarningContent:[TopModel user].ary7[i] CurrentTag:71000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = NO;
        http.code = @"632536";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"dealType"] = @(1);
        
       
        NSDictionary * dic = [NSDictionary dictionary];
        NSDictionary * dic1 = [NSDictionary dictionary];
        for (int j = 0; j < array.count; j ++) {
            if (j == 0) {
                if (_guaAssetPdf.count > 0) {
                dic = @{@"code":array[0][@"code"],
                                       @"education":[_baseModel setParentKey:@"education" setDvalue:right7Label4.text],
                                       @"birthAddressProvince":self.province2,
                                       @"birthAddressCity":self.city2,
                                       @"birthAddressArea":self.area2,
                                       @"birthAddress":right7Label6.text,
                                       @"birthPostCode":right7Label7.text,
                                       @"companyName":right7Label8.text,
                                       @"companyAddress":right7Label9.text,
                                       @"companyContactNo":right7Label10.text,
                                       @"guaAssetPdf":[_guaAssetPdf componentsJoinedByString:@"||"]
                                       };
                }
                else{
                    dic = @{@"code":array[0][@"code"],
                            @"education":[_baseModel setParentKey:@"education" setDvalue:right7Label4.text],
                            @"birthAddressProvince":self.province2,
                            @"birthAddressCity":self.city2,
                            @"birthAddressArea":self.area2,
                            @"birthAddress":right7Label6.text,
                            @"birthPostCode":right7Label7.text,
                            @"companyName":right7Label8.text,
                            @"companyAddress":right7Label9.text,
                            @"companyContactNo":right7Label10.text
                            };
                }
            }
            if (j == 1) {
                if (_guaAssetPdf1.count > 0) {
                    dic1 = @{@"code":array[1][@"code"],
                             @"education":[_baseModel setParentKey:@"education" setDvalue:right7Label15.text],
                             @"birthAddressProvince":self.province6,
                             @"birthAddressCity":self.city6,
                             @"birthAddressArea":self.area6,
                             @"birthAddress":right7Label17.text,
                             @"birthPostCode":right7Label8.text,
                             @"companyName":right7Label19.text,
                             @"companyAddress":right7Label20.text,
                             @"companyContactNo":right7Label21.text,
                             @"guaAssetPdf":[_guaAssetPdf1 componentsJoinedByString:@"||"]
                             };
                }
                else{
                    dic1 = @{@"code":array[1][@"code"],
                             @"education":[_baseModel setParentKey:@"education" setDvalue:right7Label15.text],
                             @"birthAddressProvince":self.province6,
                             @"birthAddressCity":self.city6,
                             @"birthAddressArea":self.area6,
                             @"birthAddress":right7Label17.text,
                             @"birthPostCode":right7Label8.text,
                             @"companyName":right7Label19.text,
                             @"companyAddress":right7Label20.text,
                             @"companyContactNo":right7Label21.text
                             };
                }
                
            }
        }
        NSArray * guarantorList = [NSArray array];
        if (array.count == 1) {
            guarantorList = @[dic];
        }if (array.count == 2) {
            guarantorList = @[dic,dic1];
        }
        
        http.parameters[@"guarantorList"] = guarantorList;
//
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"保存成功"];
            
        } failure:^(NSError *error) {
            
        }];
    }
    if (self.SelectLeftRow == 7) {
        [TLAlert alertWithInfo:@"保存成功"];
    }
    if (self.SelectLeftRow == 8) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"632539";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"pledgeUser"] = [ BaseModel convertNull: right9Label0.text];
        http.parameters[@"pledgeUserIdCard"] =[BaseModel convertNull:right9Label1.text];
        http.parameters[@"pledgeUserIdCardFront"] = [self.AgentFontPic componentsJoinedByString:@"||"];
        http.parameters[@"pledgeUserIdCardReverse"] = [self.AgentReversePic componentsJoinedByString:@"||"];

        http.parameters[@"pledgeAddress"] =[BaseModel convertNull: right9Label2.text];
        [http postWithSuccess:^(id responseObject) {
            [self applyBtnClick];
        } failure:^(NSError *error) {
            
        }];
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


-(NSString *)CanOrNo:(NSString *)canorno
{
    if ([canorno isEqualToString:@"是"]) {
        return @"1";
    }else if ([canorno isEqualToString:@"否"])
    {
        return @"0";
    }else
    {
        return @"";
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"新增"]) {
        NewWaterVC *vc = [NewWaterVC new];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([state isEqualToString:@"delect"]) {
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.showView = self.view;
        http.code = @"632491";
        http.parameters[@"code"] = self.rightTableView8.WaterArray[index][@"code"];
        [http postWithSuccess:^(id responseObject) {
            
            [self CreditFlowingWater];
            
        } failure:^(NSError *error) {
            
        }];
    }
}


-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (refreshTableview.tag == 100) {
        if (indexPath.row == 8) {
            [_saveBtn setTitle:@"申请" forState:(UIControlStateNormal)];

        }else
        {
            [_saveBtn setTitle:@"保存" forState:(UIControlStateNormal)];
        }
        
        self.SelectLeftRow = indexPath.row;
        UITableView *tableView = [self.view viewWithTag:indexPath.row + 101];
        [self.view bringSubviewToFront:tableView];
    }
    
    
    
    
    
//    贷款信息
    if (refreshTableview.tag == 101) {
        _SelectTag = indexPath.row + 10000;
//        贷款期限
        if (indexPath.row == 1) {
            [_baseModel ReturnsParentKeyAnArray:@"loan_period"];
        }
//        贷款产品
        if (indexPath.row == 4) {
            [self LoanProducts];
        }
        
        if (indexPath.row == 13 || indexPath.row == 10  || indexPath.row == 11 || indexPath.row == 12) {
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
        if (indexPath.row == 3) {
            [_baseModel ReturnsParentKeyAnArray:@"car_type"];
        }
        
        if (indexPath.row == 4) {
            [self chooseCar];
        }

        if (indexPath.row == 11) {
            [_baseModel ReturnsParentKeyAnArray:@"belong"];
//            [self.pickView showInView:self.view];
        }
    }
    
//    客户信息
    if (refreshTableview.tag == 103) {
        
        if (indexPath.section == 0) {
            _SelectTag = indexPath.row + 30000;
//            if (indexPath.row == 3) {
//                [_baseModel ReturnsParentKeyAnArray:@"gender"];
//            }
            if (indexPath.row == 7) {
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
            if (indexPath.row == 9) {
                [_baseModel ReturnsParentKeyAnArray:@"politics"];
            }
            if (indexPath.row == 10) {
                [_baseModel ReturnsParentKeyAnArray:@"education"];
            }
            if (indexPath.row == 11) {
                 [_baseModel ReturnsParentKeyAnArray:@"work_profession"];
            }
            if (indexPath.row == 13) {
               [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"有",@"无"]] setState:@"100"];
            }
            if (indexPath.row == 15) {
                 [self chooseMainIncome];
            }
            if (indexPath.row == 17) {
               [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"有",@"无"]] setState:@"100"];
            }
            
            
        }
        if (indexPath.section == 1) {
            _SelectTag = indexPath.row + 30018;
            if (indexPath.row == 1) {
                [_baseModel ReturnsParentKeyAnArray:@"gender"];
            }
            if (indexPath.row == 2) {
                [_baseModel ReturnsParentKeyAnArray:@"credit_contacts_relation"];
            }
            
        }
        if (indexPath.section == 2) {
            _SelectTag = indexPath.row + 30022;
            if (indexPath.row == 1) {
                [_baseModel ReturnsParentKeyAnArray:@"gender"];
            }
            if (indexPath.row == 2) {
                [_baseModel ReturnsParentKeyAnArray:@"credit_contacts_relation"];
            }
            
        }
        
    }
//    家庭情况
    if (refreshTableview.tag == 104) {
        _SelectTag = indexPath.row + 40000;
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                [_baseModel ReturnsParentKeyAnArray:@"marry_state"];
            }
            if (indexPath.row == 5) {
                [self.pickView showInView:self.view];
            }
            if (indexPath.row == 8) {
                [self.pickView showInView:self.view];
            }
            if (indexPath.row == 11) {
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
            if (indexPath.row == 12) {
                [_baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"自有",@"租用"]] setState:@"100"];
            }
        }
    }
    
//    工作情况
    if (refreshTableview.tag == 105) {
        _SelectTag = indexPath.row + 50000;
        if (indexPath.section == 0) {
            
            if (indexPath.row == 0) {
                [_baseModel ReturnsParentKeyAnArray:@"work_belong_industry"];
            }
            
            if (indexPath.row == 1) {
                [_baseModel ReturnsParentKeyAnArray:@"work_company_property"];
            }
            if (indexPath.row == 3) {
                [self.pickView showInView:self.view];
            }
            if (indexPath.row == 6) {
                //开始时间
                WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonth CompleteBlock:^(NSDate *selectDate) {
                    
                    NSString *date = [selectDate stringWithFormat:@"yyyy-MM"];
                    UILabel *right1Label1 = [self.view viewWithTag:_SelectTag];
                    right1Label1.text = date;

                }];
                
                datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
                datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
                datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
                [datepicker show];
            }
            if (indexPath.row == 7) {
                [_baseModel ReturnsParentKeyAnArray:@"position"];
            }
        }
    }
    
//    共还人信息
    if (refreshTableview.tag == 106) {
        _SelectTag = indexPath.row + 60000;
        if (indexPath.row == 4) {
            [_baseModel ReturnsParentKeyAnArray:@"education"];
        }
        if (indexPath.row == 5) {
            [self.pickView showInView:self.view];
        }
    }
//    担保人信息
    if (refreshTableview.tag == 107) {
        if (indexPath.section == 0) {
            _SelectTag = indexPath.row + 70000;
            if (indexPath.row == 4) {
                [_baseModel ReturnsParentKeyAnArray:@"education"];
            }
            if (indexPath.row == 5) {
                [self.pickView showInView:self.view];
            }
        }
        if (indexPath.section == 2) {
            _SelectTag = indexPath.row + 71000;
            if (indexPath.row == 4) {
                [_baseModel ReturnsParentKeyAnArray:@"education"];
            }
            if (indexPath.row == 5) {
                [self.pickView showInView:self.view];
            }
        }
       
    }
    
//    流水信息
    if (refreshTableview.tag == 108) {
        _SelectTag = indexPath.row + 80000;
        NewWaterVC *vc = [NewWaterVC new];
        vc.model = self.model;
        vc.waterDic = self.rightTableView8.WaterArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)chooseMainIncome{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *array = [USERDEFAULTS objectForKey:BOUNCEDDATA];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"parentKey"] isEqualToString:@"main_income"]) {
            [dataArray addObject:array[i]];
        }
    }
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i = 0; i < dataArray.count; i ++) {
        [array1 addObject:dataArray[i]];
    }
    
    NSMutableArray *dvalueArray = [NSMutableArray array];
    for (int i = 0; i < array1.count ; i ++) {
        [dvalueArray addObject:array1[i][@"dvalue"]];
    }
    
    self.MainIncomeArray = [NSMutableArray array];
    [MultiBaseView showMultiSheetAlertWithTitle:@"选择" conditions:dvalueArray resultBlock:^(NSArray *selectArr) {
        for (NSString *str in selectArr) {
            for (int i = 0; i < dataArray.count; i ++) {
                if ([str isEqualToString:dataArray[i][@"dvalue"] ]) {
                    [self.MainIncomeArray addObject:dataArray[i][@"dkey"]];
                }
            }
        }
        right3Label15.text =  [selectArr componentsJoinedByString:@","];
    } cancleBlock:^{
        NSLog(@"取消");
    }];
}
-(void)chooseCar
{
    TLNetworking *http = [TLNetworking new];
    
    http.isShowMsg = NO;
    http.code = @"630406";
    http.parameters[@"status"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        
        
        _brandAry = responseObject[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0 ; i < _brandAry.count; i ++) {
            [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",_brandAry[i][@"name"]]]];
        }

        SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
        view.isSingle = YES;
        view.array = array;
        view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
            [LEEAlert closeWithCompletionBlock:^{
                NSLog(@"选中的%@" , array);
                
                SelectedListModel *model = array[0];
                right2Label4.text = model.title;
                _brandDic = _brandAry[model.sid];
                
                
                TLNetworking *http = [TLNetworking new];
                http.isShowMsg = NO;
                http.code = @"630416";
                http.parameters[@"brandCode"] = _brandDic[@"code"];
                http.parameters[@"status"] = @"1";
                [http postWithSuccess:^(id responseObject) {
                    _carsAry = responseObject[@"data"];
                    
                    NSMutableArray *array = [NSMutableArray array];
                    for (int i = 0 ; i < _carsAry.count; i ++) {
                        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",_carsAry[i][@"name"]]]];
                    }
                    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
                    view.isSingle = YES;
                    view.array = array;
                    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
                        [LEEAlert closeWithCompletionBlock:^{
                            NSLog(@"选中的%@" , array);
                            SelectedListModel *model = array[0];
                            right2Label5.text = model.title;
                            _carsDic = _carsAry[model.sid];
                            
                            _modelsAry = _carsDic[@"cars"];
                            
                            NSMutableArray *array = [NSMutableArray array];
                            for (int i = 0 ; i < _modelsAry.count; i ++) {
                                [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",_modelsAry[i][@"name"]]]];
                            }
                            
                            
                            
                            SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
                            view.isSingle = YES;
                            view.array = array;
                            view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
                                [LEEAlert closeWithCompletionBlock:^{
                                    NSLog(@"选中的%@" , array);
                                    SelectedListModel *model = array[0];
                                    right2Label6.text = model.title;
                                    //                                                [self.ModelDelegate TheReturnValueStr:model.title selectDic:nameArray[model.sid] selectSid:model.sid];
                                }];
                            };
                            [LEEAlert alert].config
                            .LeeTitle(@"选择")
                            .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
                            .LeeCustomView(view)
                            .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
                            .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
                            .LeeClickBackgroundClose(YES)
                            .LeeShow();
                            
                        }];
                    };
                    [LEEAlert alert].config
                    .LeeTitle(@"选择")
                    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
                    .LeeCustomView(view)
                    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
                    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
                    .LeeClickBackgroundClose(YES)
                    .LeeShow();
                    
                } failure:^(NSError *error) {
                    
                }];
                
            }];
        };
        [LEEAlert alert].config
        .LeeTitle(@"选择")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();
    } failure:^(NSError *error) {
        
    }];
}

//弹框代理方法
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
//
    if (_SelectTag == 10001) {
        periods = [[BaseModel user]setParentKey:@"loan_period" setDvalue:Str];
        right1Label2.text = [NSString stringWithFormat:@"%.4f",[LoanBankDic[[NSString stringWithFormat:@"rate%@",dic[@"dkey"]]] floatValue]];
    }
    if (_SelectTag == 10004) {
        
        LoanProductsDic = LoanProductsArray[sid];
        right1Label5.text = [NSString stringWithFormat:@"%.2f",[LoanProductsDic[@"gpsFee"] floatValue] / 1000];
        right1Label6.text = [NSString stringWithFormat:@"%.2f", ([self.model.loanAmount  floatValue]/1000) *([LoanProductsDic[@"authRate"] floatValue])];
        right1Label14.text = [NSString stringWithFormat:@"%.2f",(([self.model.loanAmount  floatValue]/1000)*([LoanProductsDic[@"wanFactor"] floatValue] / 1000))/10000];
        
    }
    if (_SelectTag == 20011) {
        [self alertarea:dic[@"dkey"]];
        self.belongcode = dic[@"dkey"];
    }
    if (_SelectTag == 40000) {
        right4Label0.text = Str;
    }

    UILabel *right1Label1 = [self.view viewWithTag:_SelectTag];
    right1Label1.text = Str;
}

-(void)initTableView
{
    self.leftTableView = [[ToApplyForVCTableView alloc] initWithFrame:CGRectMake(0, 0, 107, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.leftTableView.tag = 100;
    self.leftTableView.refreshDelegate = self;
    self.leftTableView.backgroundColor = kBackgroundColor;
    self.leftTableView.model = self.model;
    [self.view addSubview:self.leftTableView];
    
    self.rightTableView1 = [[ToApplyForRightTableView1 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, 100000) style:(UITableViewStyleGrouped)];
    self.rightTableView1.refreshDelegate = self;
    self.rightTableView1.backgroundColor = kWhiteColor;
    self.rightTableView1.tag = 101;
    
    
    
    self.rightTableView2 = [[ToApplyForRightTableView2 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, 100000) style:(UITableViewStyleGrouped)];
    self.rightTableView2.refreshDelegate = self;
    self.rightTableView2.backgroundColor = kWhiteColor;
    self.rightTableView2.tag = 102;
    
    
    self.rightTableView3 = [[ToApplyForRightTableView3 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, 100000) style:(UITableViewStyleGrouped)];
    self.rightTableView3.refreshDelegate = self;
    self.rightTableView3.backgroundColor = kWhiteColor;
    self.rightTableView3.tag = 103;
    
    
    self.rightTableView4 = [[ToApplyForRightTableView4 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, 100000) style:(UITableViewStyleGrouped)];
    self.rightTableView4.refreshDelegate = self;
    self.rightTableView4.backgroundColor = kWhiteColor;
    self.rightTableView4.tag = 104;
   
    
    self.rightTableView5 = [[ToApplyForRightTableView5 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, 100000) style:(UITableViewStyleGrouped)];
    self.rightTableView5.refreshDelegate = self;
    self.rightTableView5.backgroundColor = kWhiteColor;
    self.rightTableView5.tag = 105;
    
    
    self.rightTableView6 = [[ToApplyForRightTableView6 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, 100000) style:(UITableViewStyleGrouped)];
    self.rightTableView6.refreshDelegate = self;
    self.rightTableView6.backgroundColor = kWhiteColor;
    self.rightTableView6.tag = 106;
    
    
    self.rightTableView7 = [[ToApplyForRightTableView7 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, 100000) style:(UITableViewStyleGrouped)];
    self.rightTableView7.refreshDelegate = self;
    self.rightTableView7.backgroundColor = kWhiteColor;
    self.rightTableView7.tag = 107;
    
    
    
    self.rightTableView8 = [[ToApplyForRightTableView8 alloc] initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, 100000) style:(UITableViewStyleGrouped)];
    self.rightTableView8.refreshDelegate = self;
    self.rightTableView8.backgroundColor = kWhiteColor;
    self.rightTableView8.tag = 108;
    
    self.rightTableView9 = [[ToApplyForRightTableView9 alloc]initWithFrame:CGRectMake(107, 0, SCREEN_WIDTH - 107, 100000) style:(UITableViewStyleGrouped)];
    self.rightTableView9.refreshDelegate = self;
    self.rightTableView9.backgroundColor = kWhiteColor;
    self.rightTableView9.tag = 109;
    
    self.rightTableView1.model = self.model;
    self.rightTableView2.model = self.model;
    self.rightTableView3.model = self.model;
    self.rightTableView4.model = self.model;
    self.rightTableView5.model = self.model;
    self.rightTableView6.model = self.model;
    self.rightTableView7.model = self.model;
    self.rightTableView8.model = self.model;
    self.rightTableView9.model = self.model;
    
    [self.view addSubview:self.rightTableView1];
    [self.view addSubview:self.rightTableView2];
    [self.view addSubview:self.rightTableView3];
    [self.view addSubview:self.rightTableView4];
    [self.view addSubview:self.rightTableView5];
    [self.view addSubview:self.rightTableView6];
    [self.view addSubview:self.rightTableView7];
    [self.view addSubview:self.rightTableView8];
    [self.view addSubview:self.rightTableView9];
    
    MJWeakSelf;
    self.rightTableView2.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        if ([name isEqualToString:@"合格证"]) {
            weakSelf.carHgzPic = imgAry;
        }
        if ([name isEqualToString:@"车辆照片"]) {
            weakSelf.carPic = imgAry;
        }
    };
    self.rightTableView4.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        if ([name isEqualToString:@"户口本"]) {
            weakSelf.hkBookPdf = imgAry;
        }
        if ([name isEqualToString:@"结婚证/离婚证"]) {
            weakSelf.marryPdf = imgAry;
        }
        if ([name isEqualToString:@"购房合同/房产本"]) {
            weakSelf.houseContract = imgAry;
        }
        if ([name isEqualToString:@"购房发票"]) {
            weakSelf.houseInvoice = imgAry;
        }
        if ([name isEqualToString:@"居住证明"]) {
            weakSelf.liveProvePdf = imgAry;
        }
        if ([name isEqualToString:@"自建房证明"]) {
            weakSelf.buildProvePdf = imgAry;
        }
        if ([name isEqualToString:@"家访照片"]) {
            weakSelf.housePictureApply = imgAry;
        }
        
    };
    self.rightTableView5.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        if ([name isEqualToString:@"收入证明"]) {
            weakSelf.improvePdf = imgAry;
        }
        if ([name isEqualToString:@"单位前台照片"]) {
            weakSelf.frontTablePic = imgAry;
        }
        if ([name isEqualToString:@"办公场地照片"]) {
            weakSelf.workPlacePic = imgAry;
        }
        if ([name isEqualToString:@"签约员与客户合影"]) {
            weakSelf.salerAndcustomer = imgAry;
        }
    };
    
    self.rightTableView6.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        weakSelf.mateAssetPdf = imgAry;
    };
    
    self.rightTableView7.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        if ([name isEqualToString:@"担保人1资产资料"]) {
             weakSelf.guaAssetPdf = imgAry;
        }
        if ([name isEqualToString:@"担保人2资产资料"]) {
             weakSelf.guaAssetPdf1 = imgAry;
        }
    };
    
    self.rightTableView9.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name) {
        if ([name isEqualToString:@"代理人身份证正面"]) {
            weakSelf.AgentFontPic = imgAry;
        }
        else{
            weakSelf.AgentReversePic = imgAry;
        }
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
    [self GetTheTag];
    
    self.rightTableView1.frame = CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight);
    self.rightTableView2.frame = CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight);
    self.rightTableView3.frame = CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight);
    self.rightTableView4.frame = CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight);
    self.rightTableView5.frame = CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight);
    self.rightTableView6.frame = CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight);
    self.rightTableView7.frame = CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight);
    self.rightTableView8.frame = CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight);
    self.rightTableView9.frame = CGRectMake(107, 0, SCREEN_WIDTH - 107, SCREEN_HEIGHT - kNavigationBarHeight);
    
    right1Label0.text = [NSString stringWithFormat:@"%@",self.model.loanBankName];
    right1Label3.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanAmount floatValue]/1000]];
    
    if ([BaseModel isBlankString:self.model.loanInfo[@"periods"]] == NO) {
        
        right1Label1.text = [[BaseModel user]setParentKey:@"loan_period" setDkey:[NSString stringWithFormat:@"%@",self.model.loanInfo[@"periods"]]];
        right1Label2.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.4f",[self.model.loanInfo[@"bankRate"] floatValue]]];
        right1Label4.text = [BaseModel convertNull:self.model.loanInfo[@"loanProductName"]];
        right1Label5.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"gpsFee"] floatValue]/1000]];
        right1Label6.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"authFee"] floatValue]/1000]];
        right1Label7.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"invoicePrice"] floatValue]/1000]];
        right1Label8.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"sfAmount"] floatValue]/1000]];
        right1Label9.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"sfRate"] floatValue]]];
        right1Label10.text = [_baseModel setParentKey:@"can_or_no" setDkey:self.model.isFinacing];
        right1Label11.text = [_baseModel setParentKey:@"can_or_no" setDkey:self.model.isAdvanceFund];
        right1Label12.text = [_baseModel setParentKey:@"can_or_no" setDkey:self.model.isGpsAz];
        right1Label13.text = [_baseModel setParentKey:@"can_or_no" setDkey:self.model.isPlatInsure];
        right1Label14.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"monthDeposit"] floatValue]/1000]];
        right1Label15.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"teamFee"] floatValue]/1000]];
        right1Label16.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.loanInfo[@"otherFee"] floatValue]/1000]];
        
        [self.rightTableView1 reloadData];
    }
    
    if ([BaseModel isBlankString:self.model.carInfoRes[@"vehicleCompanyName"]]==NO) {

        
        
        right2Label1.text = [NSString stringWithFormat:@"%@",[[BaseModel user]setCompanyCode:self.model.carInfoRes[@"vehicleCompanyName"]]];
        right2Label2.text = self.model.carInfoRes[@"invoiceCompany"];
//        right2Label3.text = [NSString stringWithFormat:@"%.2f",[self.model.carInfoRes[@"invoicePrice"] floatValue]/1000];
        right2Label3.text = [NSString stringWithFormat:@"%@", [[BaseModel user]setParentKey:@"car_type" setDkey:self.model.carInfoRes[@"carType"]]];
        right2Label4.text = [NSString stringWithFormat:@"%@",self.model.carInfoRes[@"carBrand"]];
        right2Label5.text = [NSString stringWithFormat:@"%@",self.model.carInfoRes[@"carSeries"]];
        right2Label6.text = [NSString stringWithFormat:@"%@",self.model.carInfoRes[@"carModel"]];
        right2Label7.text = [NSString stringWithFormat:@"%@",self.model.carInfoRes[@"carColor"]];
        right2Label8.text = [NSString stringWithFormat:@"%@",self.model.carInfoRes[@"carFrameNo"]];
        right2Label9.text = [NSString stringWithFormat:@"%@",self.model.carInfoRes[@"carEngineNo"]];
        right2Label10.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.carInfoRes[@"originalPrice"] floatValue]/1000]];
//        [_baseModel setParentKey:@"region_belong" setDvalue:right2Label11.text];
//        //   厂家贴息
        right2Label11.text = [_baseModel setParentKey:@"region_belong" setDkey:self.model.carInfoRes[@"region"]];
        right2Label12.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.carInfoRes[@"carDealerSubsidy"] floatValue]/1000]];
        right2Label13.text = [NSString stringWithFormat:@"%@",self.model.carInfoRes[@"oilSubsidyKil"]];
        right2Label14.text = [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[self.model.carInfoRes[@"oilSubsidy"] floatValue]/1000]];
        right2Label15.text = [NSString stringWithFormat:@"%@",self.model.carInfoRes[@"settleAddress"]];
        
    }

    
    self.addressLabel1 = right6Label5;
    self.addressLabel2 = right7Label5;
    self.addressLabel3 = right4Label5;
    self.addressLabel4 = right4Label8;
    self.addressLabel6 = right7Label16;
    
    
    for (int i = 0; i < self.model.creditUserList.count; i ++) {
        NSDictionary *creditUser = self.model.creditUserList[i];
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"1"]) {
            
            right3Label0.text = creditUser[@"userName"];
            right3Label1.text = creditUser[@"mobile"];
            right3Label2.text = creditUser[@"idNo"];
            
//            if ([creditUser[@"gender"] integerValue] != 0) {
                right3Label3.text = [BaseModel convertNull:[NSString stringWithFormat:@"%@",creditUser[@"gender"]]];
                right3Label4.text = [BaseModel convertNull:[NSString stringWithFormat:@"%ld",[creditUser[@"age"] integerValue]]];
                right3Label5.text = [BaseModel convertNull:[NSString stringWithFormat:@"%@",creditUser[@"englishName"]]];
                right3Label6.text = [BaseModel convertNull:[NSString stringWithFormat:@"%@",creditUser[@"authref"]]];
                right3Label7.text = [BaseModel convertNull:[NSString stringWithFormat:@"%@",creditUser[@"statdate"]]];
                right3Label8.text = [BaseModel convertNull:creditUser[@"nation"]];
                right3Label9.text = [BaseModel convertNull:[_baseModel setParentKey:@"politics" setDkey:creditUser[@"political"]]];
                right3Label10.text = [BaseModel convertNull:[_baseModel setParentKey:@"education" setDkey:creditUser[@"education"]]];
                right3Label11.text = [BaseModel convertNull:[_baseModel setParentKey:@"work_profession" setDkey:creditUser[@"workProfession"]]];
                right3Label12.text = [BaseModel convertNull:creditUser[@"postTitle"]];
                
                if ([creditUser[@"isDriceLicense"] isEqualToString:@"1"]) {
                    right3Label13.text = @"有";
                }else if ([creditUser[@"isDriceLicense"] isEqualToString:@"0"])
                {
                    right3Label13.text = @"无";
                }else
                {
                    right3Label13.text = @"";
                }
                right3Label14.text = creditUser[@"carType"];
                NSMutableArray *dataArray = [NSMutableArray array];
                NSArray *array = [USERDEFAULTS objectForKey:BOUNCEDDATA];
                for (int i = 0; i < array.count; i ++) {
                    if ([array[i][@"parentKey"] isEqualToString:@"main_income"]) {
                        [dataArray addObject:array[i]];
                    }
                }
                NSArray * array1 = [creditUser[@"mainIncome"] componentsSeparatedByString:@","];
                NSMutableArray *dvalueArray = [NSMutableArray array];
                for (int i = 0; i < array1.count; i ++) {
                    for (int j = 0; j < dataArray.count; j ++) {
                        if ([array1[i] isEqualToString:dataArray[j][@"dkey"] ]) {
                            [dvalueArray addObject:dataArray[j][@"dvalue"] ];
                        }
                    }
                }
                right3Label15.text = [dvalueArray componentsJoinedByString:@","];
                right3Label16.text = [BaseModel convertNull:[NSString stringWithFormat:@"%@",creditUser[@"otherIncomeNote"]]];
                right3Label17.text = [creditUser[@"isHouseProperty"] isEqualToString:@"1"]?@"有":@"无";
                right3Label18.text = creditUser[@"emergencyName1"];
                right3Label20.text = [_baseModel setParentKey:@"credit_contacts_relation" setDkey:creditUser[@"emergencyRelation1"]];
                right3Label19.text = [_baseModel setParentKey:@"gender" setDkey:creditUser[@"emergencySex1"]];
                right3Label21.text = creditUser[@"emergencyMobile1"];
                right3Label22.text = creditUser[@"emergencyName2"];
                right3Label24.text = [_baseModel setParentKey:@"credit_contacts_relation" setDkey:creditUser[@"emergencyRelation2"]];
                right3Label23.text = [_baseModel setParentKey:@"gender" setDkey:creditUser[@"emergencySex2"]];
                right3Label25.text = creditUser[@"emergencyMobile2"];
//            }
            
            
            
//            if ([creditUser[@"marryState"] integerValue] != 0) {
                right4Label0.text = [_baseModel setParentKey:@"marry_state" setDkey:creditUser[@"marryState"]];
                right4Label1.text = [BaseModel convertNull:[NSString stringWithFormat:@"%@",creditUser[@"familyNumber"]]];
                right4Label2.text = creditUser[@"familyPhone"];
                right4Label3.text =[BaseModel convertNull: [NSString stringWithFormat:@"%.2f",[creditUser[@"familyMainAsset"] floatValue]/1000]];
                right4Label4.text = creditUser[@"mainAssetInclude"];
                right4Label5.text = [NSString stringWithFormat:@"%@ %@ %@",[BaseModel convertNull: creditUser[@"birthAddressProvince"]],[BaseModel convertNull:creditUser[@"birthAddressCity"]],[BaseModel convertNull:creditUser[@"birthAddressArea"]]];
                self.province3 = creditUser[@"birthAddressProvince"];
                self.city3 = creditUser[@"birthAddressCity"];
                self.area3 = creditUser[@"birthAddressArea"];
                
                right4Label6.text = creditUser[@"birthAddress"];
                right4Label7.text = creditUser[@"birthPostCode"];
                
                right4Label8.text = [NSString stringWithFormat:@"%@ %@ %@",[BaseModel convertNull:creditUser[@"nowAddressProvince"]],[BaseModel convertNull:creditUser[@"nowAddressCity"]],[BaseModel convertNull:creditUser[@"nowAddressArea"]]];
                self.province4 = creditUser[@"nowAddressProvince"];
                self.city4 = creditUser[@"birthAddressCity"];
                self.area4 = creditUser[@"birthAddressArea"];
                right4Label9.text = creditUser[@"nowAddress"];
                right4Label10.text = creditUser[@"nowPostCode"];
                right4Label11.text = [NSString stringWithFormat:@"%@", [BaseModel convertNull:creditUser[@"nowAddressDate"]]];
                
                if ([creditUser[@"nowHouseType"] isEqualToString:@"0"]) {
                    right4Label12.text = @"自有";
                }else if ([creditUser[@"nowHouseType"] isEqualToString:@"1"])
                {
                    right4Label12.text = @"租用";
                }
//            }
            
            
//            if ([BaseModel isBlankString:creditUser[@"workBelongIndustry"]] == NO) {
            right5Label0.text = [_baseModel setParentKey:@"work_belong_industry" setDkey:creditUser[@"workBelongIndustry"]];
            right5Label1.text = [_baseModel setParentKey:@"work_company_property" setDkey:creditUser[@"workCompanyProperty"]];
            right5Label2.text = creditUser[@"companyName"];
            [BaseModel convertNull:
            right5Label3.text = [NSString stringWithFormat:@"%@ %@ %@",[BaseModel convertNull:creditUser[@"companyProvince"]],[BaseModel convertNull:creditUser[@"companyCity"]],[BaseModel convertNull:creditUser[@"companyArea"]]]];
            right5Label4.text =  creditUser[@"companyAddress"];
            right5Label5.text = creditUser[@"companyContactNo"];
            right5Label6.text = creditUser[@"workDatetime"];
            right5Label7.text = creditUser[@"position"];
            right5Label8.text =[BaseModel convertNull: [NSString stringWithFormat:@"%.2f",[creditUser[@"monthIncome"]  floatValue]/1000]];
            
            
            right5Label9.text = creditUser[@"otherWorkNote"];
            right5Label10.text = creditUser[@"employeeQuantity"];
            right5Label11.text =[BaseModel convertNull: [NSString stringWithFormat:@"%.2f",[creditUser[@"enterpriseMonthOutput"] floatValue]]];
            
                
                
//            }
        }
        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"2"]) {
            right6Label0.text = creditUser[@"userName"];
            right6Label1.text = [_baseModel setParentKey:@"credit_user_relation" setDkey:creditUser[@"relation"]];
            right6Label2.text = creditUser[@"mobile"];
            right6Label3.text = creditUser[@"idNo"];
            
            if ([BaseModel isBlankString:creditUser[@"birthAddressProvince"]] == NO) {
                right6Label4.text = [_baseModel setParentKey:@"education" setDkey:creditUser[@"education"]];
                self.province1 = creditUser[@"birthAddressProvince"];
                self.city1 = creditUser[@"birthAddressCity"];
                self.area1 = creditUser[@"birthAddressArea"];
                right6Label5.text = [NSString stringWithFormat:@"%@ %@ %@",self.province1,self.city1,self.area1];
                right6Label6.text = creditUser[@"birthAddress"];
                right6Label7.text = creditUser[@"birthPostCode"];
                right6Label8.text = creditUser[@"companyName"];
                right6Label9.text = creditUser[@"companyAddress"];
                right6Label10.text = creditUser[@"companyContactNo"];
            }
        }

        if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"3"]) {
            [_DBRlist addObject:self.model.creditUserList[i]];
        }
        
        for (int i = 0; i < _DBRlist.count; i ++) {
            if (i == 0) {
                right7Label0.text = _DBRlist[i][@"userName"];
                right7Label1.text = [_baseModel setParentKey:@"credit_user_relation" setDkey:_DBRlist[i][@"relation"]];
                right7Label2.text = _DBRlist[i][@"mobile"];
                right7Label3.text = _DBRlist[i][@"idNo"];
                
                if ([BaseModel isBlankString:_DBRlist[i][@"birthAddressProvince"]] == NO) {
                    right7Label4.text = [_baseModel setParentKey:@"education" setDkey:_DBRlist[i][@"education"]];
                    self.province2 = _DBRlist[i][@"birthAddressProvince"];
                    self.city2 = _DBRlist[i][@"birthAddressCity"];
                    self.area2 = _DBRlist[i][@"birthAddressArea"];
                    right7Label5.text = [NSString stringWithFormat:@"%@ %@ %@",self.province2,self.city2,self.area2];
                    right7Label6.text = _DBRlist[i][@"birthAddress"];
                    right7Label7.text = _DBRlist[i][@"birthPostCode"];
                    right7Label8.text = _DBRlist[i][@"companyName"];
                    right7Label9.text = _DBRlist[i][@"companyAddress"];
                    right7Label10.text = _DBRlist[i][@"companyContactNo"];
                }
            }
            if (i == 1) {
                right7Label11.text = _DBRlist[i][@"userName"];
                right7Label12.text = [_baseModel setParentKey:@"credit_user_relation" setDkey:_DBRlist[i][@"relation"]];
                right7Label13.text = _DBRlist[i][@"mobile"];
                right7Label14.text = _DBRlist[i][@"idNo"];
                
                if ([BaseModel isBlankString:_DBRlist[i][@"birthAddressProvince"]] == NO) {
                    right7Label15.text = [_baseModel setParentKey:@"education" setDkey:_DBRlist[i][@"education"]];
                    self.province6 = _DBRlist[i][@"birthAddressProvince"];
                    self.city6 = _DBRlist[i][@"birthAddressCity"];
                    self.area6 = _DBRlist[i][@"birthAddressArea"];
                    right7Label16.text = [NSString stringWithFormat:@"%@ %@ %@",self.province6,self.city6,self.area6];
                    right7Label17.text = _DBRlist[i][@"birthAddress"];
                    right7Label18.text = _DBRlist[i][@"birthPostCode"];
                    right7Label19.text = _DBRlist[i][@"companyName"];
                    right7Label20.text = _DBRlist[i][@"companyAddress"];
                    right7Label21.text = _DBRlist[i][@"companyContactNo"];
                }
            }
            
        }
        
    }
    
    right9Label0.text =  [BaseModel convertNull:self.model.carPledge[@"pledgeUser"]];
    right9Label1.text = [BaseModel convertNull:self.model.carPledge[@"pledgeUserIdCard"]];
    right9Label2.text = [BaseModel convertNull:self.model.carPledge[@"pledgeAddress"]];
    
    for (int i = 0; i < self.model.attachments.count; i ++) {
        NSDictionary *attachmentsDic = self.model.attachments[i];
        if ([attachmentsDic[@"kname"] isEqualToString:@"car_hgz_pic"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.carHgzPic = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView2.carHgzPic = self.carHgzPic;
                [self.rightTableView2 reloadData];
    
            }
        }
        if ([attachmentsDic[@"kname"] isEqualToString:@"car_pic"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.carPic = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView2.carPic = self.carPic;
            [self.rightTableView2 reloadData];
            }
        }
//        户口本
        if ([attachmentsDic[@"kname"] isEqualToString:@"hkb_apply"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
                self.hkBookPdf = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
                    self.rightTableView4.hkBookPdf = self.hkBookPdf;
                    [self.rightTableView4 reloadData];
                }
        }
//       结婚证
        if ([attachmentsDic[@"kname"] isEqualToString:@"marry_pdf"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.marryPdf = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView4.marryPdf = self.marryPdf;
            [self.rightTableView4 reloadData];
            }
        }
//       购房合同
        if ([attachmentsDic[@"kname"] isEqualToString:@"house_contract"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.houseContract = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView4.houseContract = self.houseContract;
            [self.rightTableView4 reloadData];
            }
        }
//       购房发票
        if ([attachmentsDic[@"kname"] isEqualToString:@"house_invoice"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.houseInvoice = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView4.houseInvoice = self.houseInvoice;
            [self.rightTableView4 reloadData];
            }
        }
        //       居住证明
        if ([attachmentsDic[@"kname"] isEqualToString:@"live_prove_pdf"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.liveProvePdf = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView4.liveProvePdf = self.liveProvePdf;
            [self.rightTableView4 reloadData];
            }
        }
        //       自建房证明
        if ([attachmentsDic[@"kname"] isEqualToString:@"build_prove_pdf"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.buildProvePdf = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView4.buildProvePdf = self.buildProvePdf;
            [self.rightTableView4 reloadData];
            }
        }
        //       自建房证明
        if ([attachmentsDic[@"kname"] isEqualToString:@"house_picture_apply"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.housePictureApply = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView4.housePictureApply = self.housePictureApply;
            [self.rightTableView4 reloadData];
            }
        }
        //       收入证明
        if ([attachmentsDic[@"kname"] isEqualToString:@"improve_pdf"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.improvePdf = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView5.improvePdf = self.improvePdf;
            [self.rightTableView5 reloadData];
            }
        }
        //       单位前台照片
        if ([attachmentsDic[@"kname"] isEqualToString:@"front_table_pic"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.frontTablePic = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView5.frontTablePic = self.frontTablePic;
            [self.rightTableView5 reloadData];
            }
        }
        //       单位场地照片
        if ([attachmentsDic[@"kname"] isEqualToString:@"work_place_pic"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.workPlacePic = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView5.workPlacePic = self.workPlacePic;
            [self.rightTableView5 reloadData];
            }
        }
        //       业务员与客户合影
        if ([attachmentsDic[@"kname"] isEqualToString:@"saler_and_customer"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.salerAndcustomer = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView5.salerAndcustomer = self.salerAndcustomer;
            [self.rightTableView5 reloadData];
            }
        }
        if ([attachmentsDic[@"kname"] isEqualToString:@"asset_pdf_gh"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.mateAssetPdf = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView6.mateAssetPdf = self.mateAssetPdf;
            [self.rightTableView6 reloadData];
            }
        }
        if ([attachmentsDic[@"kname"] isEqualToString:@"asset_pdf_gua0"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.guaAssetPdf = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView7.otherPic = self.guaAssetPdf;
            [self.rightTableView7 reloadData];
            }
        }
        if ([attachmentsDic[@"kname"] isEqualToString:@"asset_pdf_gua1"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
                self.guaAssetPdf1 = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
                self.rightTableView7.otherPic1 = self.guaAssetPdf1;
                [self.rightTableView7 reloadData];
            }
        }
        if ([attachmentsDic[@"kname"] isEqualToString:@"pledge_user_id_card_front"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.AgentFontPic = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView9.AgentFontPic = self.AgentFontPic;
            [self.rightTableView9 reloadData];
            }
        }
        if ([attachmentsDic[@"kname"] isEqualToString:@"pledge_user_id_card_reverse"]) {
            NSString * str =attachmentsDic[@"url"];
            if (str.length > 0) {
            self.AgentReversePic = [attachmentsDic[@"url"] componentsSeparatedByString:@"||"];
            self.rightTableView9.AgentReversePic = self.AgentReversePic;
            [self.rightTableView9 reloadData];
            }
        }

    }
    

}

-(void)alertarea:(NSString *)code{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630038";
    http.showView = self.view;
    http.parameters[@"key"] = code;
    [http postWithSuccess:^(id responseObject) {
        NSArray * dvalueArray = responseObject[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0;  i < dvalueArray.count; i ++) {
            [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",dvalueArray[i][@"dvalue"]]]];
        }
        SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 300, 0) style:UITableViewStylePlain];
        view.isSingle = YES;
        view.array = array;
        view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
            [LEEAlert closeWithCompletionBlock:^{
                NSLog(@"选中的%@" , array);
                //                NSInteger sid = array[0][@"sid"];
                SelectedListModel * model = array[0];
                NSInteger sid = model.sid;
                UILabel *right1Label1 = [self.view viewWithTag:_SelectTag];
                right1Label1.text = dvalueArray[sid][@"dvalue"];
                if (dvalueArray.count > 0) {
                    self.belongcode = dvalueArray[sid][@"dkey"];
                }
            }];
        };
        [LEEAlert alert].config
        .LeeTitle(@"选择")
        .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
        .LeeCustomView(view)
        .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
        .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
        .LeeClickBackgroundClose(YES)
        .LeeShow();
        
    } failure:^(NSError *error) {
        
    }];
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
    http.parameters[@"status"] = @"2";
    http.parameters[@"type"] = self.model.bizType;
    http.parameters[@"loanBank"] = self.model.loanBank;
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
    //    http.parameters[@"creditUserCode"] = self.model.creditUser[@"code"];
    [http postWithSuccess:^(id responseObject) {
        
        self.rightTableView8.WaterArray = responseObject[@"data"];
        [self.rightTableView8 reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}


@end
