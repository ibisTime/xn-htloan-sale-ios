//
//  ReceivesAuditVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/8.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ReceivesAuditVC.h"
#import "ReceivesAuditTableView.h"
#import "CadListModel.h"
@interface ReceivesAuditVC ()<RefreshDelegate>

@property (nonatomic , strong)ReceivesAuditTableView *tableView;

@property (nonatomic , strong) UIView *mengView;
@property (nonatomic , strong) NSMutableArray *cadList;

@property (nonatomic , strong) UIImageView *rightImg;

@property (nonatomic , strong) UIImageView *bottomImg;

@property (nonatomic , strong) UILabel *secondLab;

@property (nonatomic , strong) UILabel *threeLab;

@property (nonatomic , strong) UIView *centerView;
@end

@implementation ReceivesAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收件";
    [self initTableView];
    
    [self loadCadList];
}

- (void)loadCadList
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"632217";
    http.showView = self.view;
    
    [http postWithSuccess:^(id responseObject) {
        self.models = [CadListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.tableView.models = self.models;
        [self.tableView reloadData];
        WGLog(@"%@",responseObject);
    } failure:^(NSError *error) {
        
    }];
}

- (void)initTableView {
    self.tableView = [[ReceivesAuditTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.isGps = self.isGps;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
}


-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        {
            
            UIView *mengView = [UIView new];
            self.mengView = mengView;
            mengView.backgroundColor = [UIColor blackColor];
            mengView.alpha = 0.6;
            mengView.frame = self.view.bounds;
            [self.view addSubview:mengView];
            
            UIView *view = [UIView new];
            self.centerView = view;
            view.frame = CGRectMake(120, 100, SCREEN_WIDTH-200, 200);
            view.backgroundColor = kWhiteColor;
            view.layer.borderWidth = 1.0;
            view.layer.borderColor = kLineColor.CGColor;
            [mengView addSubview:view];
            view.layer.cornerRadius = 5;
            view.clipsToBounds = YES;
            UIImageView *rightImg = [[UIImageView alloc] init];
            self.rightImg = rightImg;
            //                rightImg.contentMode = UIViewContentModeScaleToFill;
            rightImg.frame = CGRectMake(120, 0, 14, 12);
            rightImg.image = kImage(@"打勾");
            rightImg.hidden = YES;
            UIImageView *bottomImg = [[UIImageView alloc] init];
            //                bottomImg.contentMode = UIViewContentModeScaleToFill;
            self.bottomImg = bottomImg;
            bottomImg.frame = CGRectMake(120,0, 14, 12);
            bottomImg.image = kImage(@"打勾");
            bottomImg.hidden = YES;
            UILabel* firstLabl = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:16];
            UILabel* secondLabl = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:16];
            secondLabl.userInteractionEnabled = YES;
            self.secondLab = secondLabl;
            UILabel* threeLabl = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:16];
            threeLabl.userInteractionEnabled = YES;
            self.threeLab = threeLabl;
            UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseCad)];
            [secondLabl addGestureRecognizer:t];
            
            UITapGestureRecognizer *t2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseCadThree)];
            [threeLabl addGestureRecognizer:t2];
            firstLabl.frame = CGRectMake(50, 20, 100, 40);
            secondLabl.frame = CGRectMake(50, 80, 100, 30);
            threeLabl.frame = CGRectMake(50, 140, 100, 30);
            
            firstLabl.text = @"选择";
            secondLabl.text =self.models[0].name;
            threeLabl.text = self.models[1].name;
            [secondLabl addSubview:rightImg];
            [threeLabl addSubview:bottomImg];
            
            [view addSubview:firstLabl];
            [view addSubview:secondLabl];
            [view addSubview:threeLabl];
            
            
        }
    }
    
}


- (void)chooseCad
{
    
    NSLog(@"second");
    if (self.cadList.count >=2) {
        self.tableView.model.refFileList = @"";
        [self.cadList removeAllObjects];
    }
    self.rightImg.hidden = !self.rightImg.hidden;
    if (self.rightImg.hidden == YES) {
        return;
    }
    if (self.tableView.model.refFileList == nil) {
         self.tableView.model.refFileList = @"";
    }
    [self.cadList addObject:self.models[0]];
     self.tableView.model.refFileList = [NSString stringWithFormat:@"%@ %@",self.tableView.model.refFileList,self.models[0].name];
    [self.tableView reloadData];
    
}

- (void)chooseCadThree
{
    if (self.cadList.count >=2) {
         self.tableView.model.refFileList = @"";
        [self.cadList removeAllObjects];
        
    }
    if (self.tableView.model.refFileList == nil) {
        self.tableView.model.refFileList = @"";
    }
    self.bottomImg.hidden = !self.bottomImg.hidden;
    
    [self.cadList addObject:self.models[1]];
    if (self.bottomImg.hidden == YES) {
        return;
    }
    
     self.tableView.model.refFileList = [NSString stringWithFormat:@"%@ %@",self.tableView.model.refFileList,self.models[1].name];
    //    self.mengView.hidden = YES;
    [self.tableView reloadData];
    
    //    [self.tableView reloadData];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    point = [self.centerView.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.centerView.layer containsPoint:point] || [self.centerView.layer containsPoint:point] ) {
        return;
    }
    self.mengView.hidden = YES;
    
    for (int i = 0; i < self.cadList.count; i++) {
        
    }
    
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textField = [self.view viewWithTag:100];

    TLNetworking *http = [TLNetworking new];
    if (index == 0) {
        http.code = @"632151";
    }else
    {
        http.code = @"632152";
    }
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"receiver"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"remark"] = textField.text;
    http.parameters[@"approveResult"] = [NSString stringWithFormat:@"%ld",index];
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"收件成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
