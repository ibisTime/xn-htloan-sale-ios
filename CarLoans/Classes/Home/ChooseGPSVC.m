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
@property (nonatomic,strong) NSMutableArray * gpsarray;
@property (nonatomic,strong) NSMutableArray * gpschoosearray;
@property (nonatomic,strong) NSString * code;
@end

@implementation ChooseGPSVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.gpsarray = [NSMutableArray array];
    self.gpschoosearray = [NSMutableArray array];
    self.baseModel = [BaseModel new];
    self.baseModel.ModelDelegate = self;
    
    
    self.title= @"添加GPS";
    UIButton * button = [UIButton buttonWithTitle:@"确定" titleColor:kWhiteColor backgroundColor:MainColor titleFont:14 cornerRadius:3];
    button.frame = CGRectMake(15, SCREEN_HEIGHT - kNavigationBarHeight - 60, SCREEN_WIDTH - 30, 50);
    [button addTarget:self action:@selector(confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
}
- (void)initTableView {
    self.tableView = [[ChooseGPSTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 60) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        selectrow = 100;
        self.gpschoosearray = [NSMutableArray array];
        UILabel * label = [self.view viewWithTag:1001];
        label.text = @"";
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"632707";
        http.showView = self.view;
        http.parameters[@"applyStatus"] = @"0";
        http.parameters[@"useStatus"] = @"0";
        [http postWithSuccess:^(id responseObject) {
            _gpsarray = responseObject[@"data"];
            [self.baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"有线",@"无线"]] setState:@"100"];
        } failure:^(NSError *error) {
            
        }];
        
    }
    if (indexPath.row == 1) {
        selectrow = 101;
        [self.baseModel CustomBouncedView:self.gpschoosearray setState:@"666"];
        
    }
}
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid{
    if (selectrow == 100) {
        UILabel * label = [self.view viewWithTag:1000];
        label.text = Str;
        if ([Str isEqualToString:@"有线"]) {
            for (int i = 0; i < self.gpsarray.count; i ++) {
                if ([self.gpsarray[i][@"gpsType"] isEqualToString:@"1"]) {
                    [self.gpschoosearray addObject:self.gpsarray[i]];
                }
            }
        }else{
            for (int i = 0; i < self.gpsarray.count; i ++) {
                if ([self.gpsarray[i][@"gpsType"] isEqualToString:@"0"]) {
                    [self.gpschoosearray addObject:self.gpsarray[i]];
                }
            }
        }
    }
    if (selectrow == 101) {
        UILabel * label = [self.view viewWithTag:1001];
        label.text = Str;
        self.code = dic[@"code"];
    }
}

-(void)confirm:(UIButton *)sender{
    UILabel  * cell2 = [self.view viewWithTag:1000];
    UILabel  * cell3 = [self.view viewWithTag:1001];
    if (cell2.text.length == 0) {
        [TLAlert alertWithMsg:@"请选择GPS类型"];
        return;
    }
    if (cell3.text.length == 0) {
        [TLAlert alertWithMsg:@"请选择GPS设备号"];
        return;
    }
    NSDictionary *dataDic  = @{@"gpsType":cell2.text,@"gpsDevNo":cell3.text,@"code":self.code};
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
