//
//  CustomerVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CustomerVC.h"
#import "CustomerTableView.h"
#import "CustomerDetailsVC.h"
#import "CheckDetailsVC.h"
#import "AdmissionDetailsVC.h"
@interface CustomerVC ()<RefreshDelegate>
{
    UITextField *titleTF;
}
@property (nonatomic , strong)CustomerTableView *tableView;
@property (nonatomic , strong)NSMutableArray <SurveyModel *>*models;



@end


@implementation CustomerVC

-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}

- (void)viewDidLoad {
    self.title = @"客户";
    
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57)];
    backView.backgroundColor = kAppCustomMainColor;
    [self.view addSubview:backView];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 58 - 15, 37)];
    titleView.backgroundColor = kHexColor(@"#ffffff");
    kViewRadius(titleView, 37/2);
    [self.view addSubview:titleView];
    
    UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 11, 15, 15)];
    iconImg.image = kImage(@"sousuo-4");
    [titleView addSubview:iconImg];
    
    titleTF= [[UITextField alloc]initWithFrame:CGRectMake(34 + 4, 0, titleView.width - 38 - 15, 37)];
    [titleTF setValue:Font(13) forKeyPath:@"_placeholderLabel.font"];
    titleTF.font = Font(13);
    titleTF.placeholder = @"请输入客户姓名，手机号，身份证号";
    [titleView addSubview:titleTF];
    
    UIButton *searchBth = [UIButton buttonWithTitle:@"搜索" titleColor:kWhiteColor backgroundColor:kClearColor titleFont:16];
    searchBth.frame = CGRectMake(SCREEN_WIDTH - 38 - 10, 10, 38, 37);
    [searchBth addTarget:self action:@selector(searchBthClcik) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:searchBth];
    
    [self initTableView];
    [self initNavigationController];
    
    MJWeakSelf;
    [self.tableView addRefreshAction:^{
    
        [weakSelf loadData];
        
    }];
    [self.tableView beginRefreshing];
}

-(void)searchBthClcik
{
    [self.view endEditing:YES];
    [self loadData];
}

-(void)cdbiz_statusLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630036";
    http.parameters[@"parentKey"] = @"cdbiz_status";
    
    [http postWithSuccess:^(id responseObject) {
        self.tableView.dataArray = responseObject[@"data"];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)initTableView
{
    self.tableView = [[CustomerTableView alloc] initWithFrame:CGRectMake(0, 57, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight - 57) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckDetailsVC *vc = [CheckDetailsVC new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = self.models[indexPath.row];

    [self.navigationController pushViewController:vc animated:YES];
}

-(void)loadData{
    CarLoansWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"632515";
//    helper.parameters[@"teamCode"] = [USERDEFAULTS objectForKey:TEAMCODE];
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.parameters[@"isMy"] = @"1";
    helper.parameters[@"keyword"] = titleTF.text;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[SurveyModel class]];
    
        [weakSelf cdbiz_statusLoadData];
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSMutableArray <SurveyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SurveyModel *model = (SurveyModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.models = shouldDisplayCoins;
            weakSelf.tableView.models = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
            
        }];
    
    [self.tableView addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <SurveyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                SurveyModel *model = (SurveyModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
            weakSelf.models = shouldDisplayCoins;
            weakSelf.tableView.models = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
        }];
        
    }];
}

@end
