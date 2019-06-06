//
//  CheckProtextUs.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/5.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckProtextUs.h"
#import "CheckProtectTableView.h"
#import "InputBoxCell.h"
@interface CheckProtextUs ()<RefreshDelegate>
@property (nonatomic,strong) UIButton * passBtn;
@property (nonatomic,strong) UIButton * UnpassBtn;
@property (nonatomic,strong) CheckProtectTableView * tableView;
@property (nonatomic,strong) NSMutableArray * carSyx;//商业险
@property (nonatomic,strong) NSMutableArray * carJqx;//交强险
@property (nonatomic,strong) NSMutableArray * carInvoice;//发票
@property (nonatomic,strong) NSMutableArray * carHgzPic;//合格证
@end

@implementation CheckProtextUs

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"审核发保合";
    self.view.backgroundColor = kWhiteColor;
//    [self initTable];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTable];
    } failure:^(NSError *error) {
        
    }];
    
    self.passBtn = [UIButton buttonWithTitle:@"通过" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.passBtn.tag = 1001;
    self.passBtn.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH  / 2 - 20, 50);
    [self.passBtn addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.passBtn];
    
    self.UnpassBtn = [UIButton buttonWithTitle:@"不通过" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.UnpassBtn.tag = 1000;
    self.UnpassBtn.frame = CGRectMake(SCREEN_WIDTH / 2 + 10, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH / 2 - 20, 50);
    [self.UnpassBtn addTarget:self action:@selector(Confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.UnpassBtn];
    
  
    // Do any additional setup after loading the view.
}
-(void)initTable{
    self.tableView = [[CheckProtectTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
    
    if ([self.model.bizType isEqualToString:@"1"]) {
        NSString * str = [[BaseModel user]FindUrlWithModel:self.model ByKname:@"green_big_smj"];
        if (str.length > 0) {
            self.carHgzPic = [NSMutableArray arrayWithArray: [str componentsSeparatedByString:@"||"]];
            self.tableView.carHgzPic = [str componentsSeparatedByString:@"||"];
            [self.tableView reloadData];
        }
    }
    else if ([self.model.bizType isEqualToString:@"0"]){
        NSString * str = [[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_hgz_pic"];
        if (str.length > 0) {
            self.carHgzPic = [NSMutableArray arrayWithArray: [str componentsSeparatedByString:@"||"]];
            self.tableView.carHgzPic = [str componentsSeparatedByString:@"||"];
            [self.tableView reloadData];
        }
    }
    
    
    
    NSString * str1 = [[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_invoice"];
    if (str1.length > 0) {
        self.carInvoice = [NSMutableArray arrayWithArray:  [str1 componentsSeparatedByString:@"||"]];
        self.tableView.carInvoice = [str1 componentsSeparatedByString:@"||"];
        [self.tableView reloadData];
    }
    
    NSString * str2 = [[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_jqx"];
    if (str2.length > 0) {
        self.carJqx = [NSMutableArray arrayWithArray:[str2 componentsSeparatedByString:@"||"]];
        self.tableView.carJqx = [str2 componentsSeparatedByString:@"||"];
        [self.tableView reloadData];
    }
    
    NSString * str3 = [[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_syx"];
    if (str3.length > 0) {
        self.carSyx =  [NSMutableArray arrayWithArray:  [str3 componentsSeparatedByString:@"||"]];
        self.tableView.carSyx = [str3 componentsSeparatedByString:@"||"];
        [self.tableView reloadData];
    }
}
-(void)Confirm:(UIButton *)sender{
    
    InputBoxCell * cell = [self.view viewWithTag:400];
    NSString * approveNote = cell.nameTextField.text;
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632501";
    if (sender.tag == 1001) {
        http.parameters[@"approveResult"] = @"1";
    }
    else
        http.parameters[@"approveResult"] = @"0";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"approveNote"] = approveNote;
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}

@end
