//
//  CheckFinancialVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CheckFinancialVC.h"
#import "CheckFinancialTableview.h"
@interface CheckFinancialVC ()<RefreshDelegate,BaseModelDelegate>{
    NSInteger selectCell;
    NSIndexPath *ReloadIndexPath;
    NSString * financial;
}
@property (nonatomic,strong) CheckFinancialTableview * tableView;
@property (nonatomic,strong) UIButton * passBtn;
@end

@implementation CheckFinancialVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    
    self.passBtn = [UIButton buttonWithTitle:@"确认" titleColor:kWhiteColor backgroundColor:kNavBarBackgroundColor titleFont:14 cornerRadius:3];
    self.passBtn.tag = 1000;
    self.passBtn.frame = CGRectMake(10, SCREEN_HEIGHT - kNavigationBarHeight - 60, (SCREEN_WIDTH - 20), 50);
    [self.passBtn addTarget:self action:@selector(confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.passBtn];
    
    // Do any additional setup after loading the view.
}

-(void)initTableView{
    self.tableView = [[CheckFinancialTableview alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 70)style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model= self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReloadIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    BaseModel *model = [BaseModel new];
    model.ModelDelegate = self;
    if (indexPath.row == 8) {
        selectCell = 8;
        [self chooseWhetherOrNot:model];
    }
}
-(void)chooseWhetherOrNot:(BaseModel *)model
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:@[@"是",@"否"]];
    [model CustomBouncedView:array setState:@"100"];
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    switch (selectCell) {
        case 8:{
            [self.model setValue:[self WhetherOrNot:Str] forKey:@"isAdvanceFund"];
            self.tableView.model = self.model;
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:ReloadIndexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        }
            break;
        default:
            break;
    }
}
-(NSString *)WhetherOrNot:(NSString *)str
{
    if ([str isEqualToString:@"是"]) {
        return @"1";
    }else if ([str isEqualToString:@"否"])
    {
        return @"0";
    }else
    {
        return @"";
    }
}
-(void)confirm:(UIButton *)sender{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = self.code;
    http.parameters[@"code"] = self.model.code;
    NSString * str =  self.model.isAdvanceFund;
    http.parameters[@"isAdvanceFund"] = str;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
//-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
//    NSLog(@"%ld",sender.tag);
//    NSLog(@"%@",self.model[index].fbhgpsNode);
//    NSString * fbhgpsNode = self.model[index].fbhgpsNode;
//    if ([fbhgpsNode isEqualToString:@"g1"]) {
//        CheckFinancialVC * vc = [CheckFinancialVC new];
//        vc.title = @"确认用款单";
//        vc.code = @"632460";
//        vc.model = self.model[index];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    
//}
@end
