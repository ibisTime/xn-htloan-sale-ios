//
//  GPSSearchVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/16.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "GPSSearchVC.h"

@interface GPSSearchVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) NSMutableArray<SurveyModel *> * model;
@property (nonatomic,strong) TLTableView * tableview;
@end

@implementation GPSSearchVC


-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHeight - 70)];
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
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 40)];

    headView.backgroundColor = kHexColor(@"#F0F0F0");
    kViewRadius(headView, 2);
    [self.view addSubview:headView];
    
    
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(14 + 15, 0 + 15, SCREEN_WIDTH - 30 - 28, 40)];
    textField.placeholder = @"请输入GPS号";
    [textField setValue:Font(14) forKeyPath:@"_placeholderLabel.font"];
    textField.font = Font(14);
    //    textField.keyboardType = UIKeyboardTypeEmailAddress;
    kViewRadius(textField, 2);
    [self.view addSubview:textField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(leftNumberTfDidChangeOneCI:) name:UITextFieldTextDidChangeNotification
                                              object:textField];
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
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 54, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [cell addSubview:v1];
    }
    
    cell.textLabel.text = self.model[indexPath.row].gpsDevNo;
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(void)getBrand:(NSString *)name{
    CarLoansWeakSelf;
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"632705";
    help.parameters[@"gpsDevNo"] = name;
    help.parameters[@"applyUser"] = self.saleUserId;
    help.parameters[@"useStatus"] = @"1";
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
