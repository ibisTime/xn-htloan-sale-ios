//
//  InsuranceFormulaVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2020/3/10.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "InsuranceFormulaVC.h"

@interface InsuranceFormulaVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) NSMutableArray<SurveyModel *> * model;
@property (nonatomic,strong) TLTableView * tableview;
@end

@implementation InsuranceFormulaVC



-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 57, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHeight - 57)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.refreshDelegate = self;
        _tableview.defaultNoDataText = @"暂无数据";
        _tableview.defaultNoDataImage = kImage(@"暂无订单");
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.title = @"搜索";
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57)];
    backView.backgroundColor = kAppCustomMainColor;
    [self.view addSubview:backView];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 15 - 15, 37)];
    titleView.backgroundColor = kHexColor(@"#ffffff");
    kViewRadius(titleView, 37/2);
    [self.view addSubview:titleView];
    
    UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 11, 15, 15)];
    iconImg.image = kImage(@"sousuo-4");
    [titleView addSubview:iconImg];
    
    UITextField *titleTF= [[UITextField alloc]initWithFrame:CGRectMake(34 + 4, 0, titleView.width - 38 - 15, 37)];
    titleTF.font = Font(13);
    titleTF.placeholder = @"请输入保险公司";
    [titleView addSubview:titleTF];
    

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(leftNumberTfDidChangeOneCI:) name:UITextFieldTextDidChangeNotification
                                              object:titleTF];
    [self.view addSubview:self.tableview];
    
    CarLoansWeakSelf;
    [self.tableview addRefreshAction:^{
        [weakSelf getBrand:@""];
    }];
    [self.tableview beginRefreshing];
    
}

-(void)leftNumberTfDidChangeOneCI:(NSNotification *)notification
{
    UITextField *textfield=[notification object];
    [self getBrand:textfield.text];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.returnAryBlock(self.model[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 43, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [cell addSubview:v1];
    }
    
    cell.textLabel.text = self.model[indexPath.row].name;
    cell.textLabel.font = Font(14);
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(void)getBrand:(NSString *)name{
    CarLoansWeakSelf;
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"632045";
    help.parameters[@"keyword"] = name;
//    help.parameters[@"agreementStatus"] = @"1";
    [help modelClass:[SurveyModel class]];
    help.tableView = self.tableview;
    help.isCurrency = YES;
    
    [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
        weakSelf.model = objs;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview endRefreshHeader];
    } failure:^(NSError *error) {
        [weakSelf.tableview endRefreshHeader];
    }];
    
    [self.tableview addLoadMoreAction:^{
        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.model = objs;
            [weakSelf.tableview reloadData];
            [weakSelf.tableview endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshFooter];
        }];
    }];
    
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
