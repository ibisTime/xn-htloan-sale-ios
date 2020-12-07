//
//  ChooseGPSVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ChooseGPSVC.h"
#import "ChooseGPSTableView.h"
@interface ChooseGPSVC ()<RefreshDelegate,BaseModelDelegate>{
    NSInteger selectrow;
}
@property (nonatomic,strong) ChooseGPSTableView * tableView;
@property (nonatomic,strong) BaseModel * baseModel;
@property (nonatomic,strong) NSMutableArray <SurveyModel *>* model;
@property (nonatomic,strong) NSMutableArray * chooseArray;
@property (nonatomic,strong) NSString * code;
@property (nonatomic,strong) NSString * gpsType;
@property (nonatomic,strong) NSString * updater;

//@property (nonatomic , strong)NSArray *gpsArray;

@end

@implementation ChooseGPSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 40)];
    
    headView.backgroundColor = kHexColor(@"#F0F0F0");
    kViewRadius(headView, 2);
    [self.view addSubview:headView];
    
    
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(14 + 15, 0 + 15, SCREEN_WIDTH - 30 - 28, 40)];
    textField.placeholder = @"请输入GPS号";
    textField.font = Font(14);
    //    textField.keyboardType = UIKeyboardTypeEmailAddress;
    kViewRadius(textField, 2);
    [self.view addSubview:textField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(leftNumberTfDidChangeOneCI:) name:UITextFieldTextDidChangeNotification
                                              object:textField];

    
    [self initTableView];
    self.chooseArray = [NSMutableArray array];
    [self.chooseArray addObjectsFromArray:self.gpsArray];
//    self.gpschoosearray = [NSMutableArray array];
    self.baseModel = [BaseModel new];
    self.baseModel.ModelDelegate = self;
    
    
    self.title= @"添加GPS";
    UIButton * button = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:MainColor titleFont:14 cornerRadius:3];
    button.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 30, 50);
    [button addTarget:self action:@selector(confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    
    [self getBrand:@""];
}


-(void)leftNumberTfDidChangeOneCI:(NSNotification *)notification
{
    UITextField *textfield=[notification object];
    [self getBrand:textfield.text];
}

//-(void)LoadData
//{
//    TLNetworking * http = [[TLNetworking alloc]init];
//    http.code = @"632708";
//    http.showView = self.view;
//    http.parameters[@"useStatus"] = @"0";
//    [http postWithSuccess:^(id responseObject) {
//        _gpsArray = responseObject[@"data"];
//        _tableView.gpsArray = _gpsArray;
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//
//    }];
//}

- (void)initTableView {
    self.tableView = [[ChooseGPSTableView alloc] initWithFrame:CGRectMake(0, 70, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 130) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}


-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    for (int i = 0; i < self.chooseArray.count; i ++) {
//        if ([self.chooseArray[i] isEqualToString:self.model[indexPath.row].gpsDevNo]) {
//
//        }
//    }
    self.model[indexPath.row].isChoose =  !self.model[indexPath.row].isChoose;
    self.tableView.model = self.model;
    [self.tableView reloadData];
    
    if (self.model[indexPath.row].isChoose == YES) {
        [_chooseArray addObject:self.model[indexPath.row].gpsDevNo];
    }else
    {
        for (int i = 0; i < _chooseArray.count; i ++) {
            if ([_chooseArray[i] isEqualToString:self.model[indexPath.row].gpsDevNo]) {
                [_chooseArray removeObjectAtIndex:i];
            }
        }
    }
    
    
}


-(void)getBrand:(NSString *)name{
    CarLoansWeakSelf;
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"632705";
    help.parameters[@"gpsDevNo"] = name;
//    help.parameters[@"applyUser"] = self.saleUserId;
    help.parameters[@"useStatus"] = @"0";
    [help modelClass:[SurveyModel class]];
    help.tableView = self.tableView;
    help.isCurrency = YES;
    
    [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
        weakSelf.model = objs;
        
        for (int i = 0; i < _chooseArray.count; i ++) {
            for (int j = 0; j < weakSelf.model.count; j ++) {
                if ([weakSelf.chooseArray[i] isEqualToString:weakSelf.model[j].gpsDevNo]) {
                    weakSelf.model[j].isChoose = YES;
                }
            }
        }
        
        weakSelf.tableView.model = objs;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView endRefreshHeader];
    } failure:^(NSError *error) {
        [weakSelf.tableView endRefreshHeader];
    }];
    
    [self.tableView addLoadMoreAction:^{
        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.model = objs;
            for (int i = 0; i < _chooseArray.count; i ++) {
                for (int j = 0; j < weakSelf.model.count; j ++) {
                    if ([weakSelf.chooseArray[i] isEqualToString:weakSelf.model[j].gpsDevNo]) {
                        weakSelf.model[j].isChoose = YES;
                    }
                }
            }
            weakSelf.tableView.model = objs;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshFooter];
        }];
    }];
    
}



-(void)confirm:(UIButton *)sender{
//    UILabel  * cell2 = [self.view viewWithTag:1000];
//    UILabel  * cell3 = [self.view viewWithTag:1001];
//    if (cell2.text.length == 0) {
//        [TLAlert alertWithMsg:@"请选择GPS类型"];
//        return;
//    }
//    if (cell3.text.length == 0) {
//        [TLAlert alertWithMsg:@"请选择GPS设备号"];
//        return;
//    }
    
    if (self.chooseArray.count == 0) {
        [TLAlert alertWithInfo:@"请选择GPS"];
        return;
    }
    NSDictionary *dataDic  = @{@"ary":self.chooseArray};
        NSNotification *notification =[NSNotification notificationWithName:ADDADPEOPLENOTICE object:nil userInfo:dataDic];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
//    }

    
}
//-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
//    if ([state isEqualToString:@"delete"]) {
//        [_gpsarray removeObjectAtIndex:index];
//        self.tableView. = TaskArray;
//        [self.tableView reloadData];
//    }
//}
@end
