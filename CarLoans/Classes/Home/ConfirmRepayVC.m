//
//  ConfirmRepayVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ConfirmRepayVC.h"
#import "ConfirmRepayTableView.h"
#import "BottomView.h"
#import "AdmissionDetailsVC.h"
@interface ConfirmRepayVC ()<RefreshDelegate>
@property (nonatomic,strong) ConfirmRepayTableView * tableView;
@property (nonatomic , strong)NSMutableArray <RepayModel *>*model;

@property (nonatomic ,strong) NSMutableArray *dataArray;//数据源
@property (nonatomic ,strong) NSMutableArray *deleteArray;//删除的数据
@property (nonatomic ,strong) UIButton *btn;//编辑按钮
@property (nonatomic ,assign) BOOL isInsertEdit;//tableview编辑方式的判断
@property (nonatomic ,strong) BottomView *bottom_view;//底部视图
@end

@implementation ConfirmRepayVC
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
        for (int i = 0; i < self.model.count; i ++) {
            [self.dataArray addObject:self.model[i].code];
        }
    }
    return _dataArray;
}

- (NSMutableArray *)deleteArray{
    if (!_deleteArray) {
        self.deleteArray = [NSMutableArray array];
    }
    return _deleteArray;
}

- (BottomView *)bottom_view{
    if (!_bottom_view) {
        self.bottom_view = [[BottomView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, SCREEN_WIDTH, 50)];
        _bottom_view.backgroundColor = [UIColor whiteColor];
        [_bottom_view.deleteBtn addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
        [_bottom_view.allBtn addTarget:self action:@selector(tapAllBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottom_view;
}
- (UIButton *)btn{
    if (!_btn) {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(0, 0, 50, 44);
        [_btn setTitle:@"编辑" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self LoadData];
    _isInsertEdit = NO;
    self.tableView.isInsertEdit = _isInsertEdit;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.btn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(InfoNotificationAction:) name:LOADDATAPAGE object:nil];
}
- (void)initTableView {
    self.tableView = [[ConfirmRepayTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
#pragma mark -- 接收到通知
- (void)InfoNotificationAction:(NSNotification *)notification{
    [self LoadData];
}
#pragma mark -- 删除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LOADDATAPAGE object:nil];
}


-(void)LoadData
{
    
    CarLoansWeakSelf;
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"630543";
    helper.parameters[@"curNodeCodeList"] = @[@"003_01"];
    helper.parameters[@"refType"] = @"0";
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[RepayModel class]];
    
    [self.tableView addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            //去除没有的币种
            NSLog(@" ==== %@",objs);
            
            NSMutableArray <RepayModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RepayModel *model = (RepayModel *)obj;
                [shouldDisplayCoins addObject:model];
                
            }];
            
            //
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
            
        }];
        
        
    }];
    
    [self.tableView addLoadMoreAction:^{
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            //去除没有的币种
            NSMutableArray <RepayModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                RepayModel *model = (RepayModel *)obj;
                //                if ([[CoinUtil shouldDisplayCoinArray] indexOfObject:currencyModel.currency ] != NSNotFound ) {
                
                [shouldDisplayCoins addObject:model];
                //                }
                
            }];
            
            //
            weakSelf.model = shouldDisplayCoins;
            weakSelf.tableView.model = shouldDisplayCoins;
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
    if ([state isEqualToString:@"select1"]) {
        //消息推送
        [TLAlert alertWithTitle:@"提示" msg:@"确定发送?" confirmMsg:@"是" cancleMsg:@"否" cancle:^(UIAlertAction *action) {
            
        } confirm:^(UIAlertAction *action) {
            TLNetworking * http = [[TLNetworking alloc]init];
            http.code = @"630531";
            http.parameters[@"code"] = self.model[index].code;
            http.parameters[@"way"] = @"1";
            [http postWithSuccess:^(id responseObject) {
                
            } failure:^(NSError *error) {
                
            }];
        }];
        NSLog(@"%@",state);
    }else if ([state isEqualToString:@"select2"]){
        //短信催收
        [TLAlert alertWithTitle:@"提示" msg:@"确定发送?" confirmMsg:@"是" cancleMsg:@"否" cancle:^(UIAlertAction *action) {
        } confirm:^(UIAlertAction *action) {
            TLNetworking * http = [[TLNetworking alloc]init];
            http.code = @"630531";
            http.parameters[@"code"] = self.model[index].code;
            http.parameters[@"way"] = @"0";
            [http postWithSuccess:^(id responseObject) {
                
            } failure:^(NSError *error) {
                
            }];
        }];
    }
}
-(void)tapBtn:(UIButton *)sender{
        sender.selected = !sender.selected;
        if (sender.selected) {
            //点击编辑的时候清空删除数组
            [self.deleteArray removeAllObjects];
            [_btn setTitle:@"完成" forState:UIControlStateNormal];
            _isInsertEdit = YES;
            self.tableView.isInsertEdit = _isInsertEdit;
            [_tableView setEditing:YES animated:YES];
            //如果在全选状态下，点击完成，再次进来的时候需要改变按钮的文字和点击状态
            if (_bottom_view.allBtn.selected) {
                _bottom_view.allBtn.selected = !_bottom_view.allBtn.selected;
                [_bottom_view.allBtn setTitle:@"全选" forState:UIControlStateNormal];
            }
            //添加底部视图
            CGRect frame = self.bottom_view.frame;
            frame.origin.y -= 50;
            [UIView animateWithDuration:0.5 animations:^{
                self.bottom_view.frame = frame;
                [self.view addSubview:self.bottom_view];
            }];
        }else{
            [_btn setTitle:@"编辑" forState:UIControlStateNormal];
            _isInsertEdit = NO;
            self.tableView.isInsertEdit = _isInsertEdit;
            [_tableView setEditing:NO animated:YES];

            [UIView animateWithDuration:0.5 animations:^{
                CGPoint point = self.bottom_view.center;
                point.y      += 50;
                self.bottom_view.center   = point;

            } completion:^(BOOL finished) {
                [self.bottom_view removeFromSuperview];
            }];
        }

}


- (void)tapAllBtn:(UIButton *)btn{

    btn.selected = !btn.selected;

    if (btn.selected) {

        for (int i = 0; i< self.dataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            //全选实现方法
            [_tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
        }

        //点击全选的时候需要清除deleteArray里面的数据，防止deleteArray里面的数据和列表数据不一致
        if (self.deleteArray.count >0) {
            [self.deleteArray removeAllObjects];
        }
        [self.deleteArray addObjectsFromArray:self.dataArray];

        [btn setTitle:@"取消" forState:UIControlStateNormal];
    }else{

        //取消选中
        for (int i = 0; i< self.dataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
            [_tableView deselectRowAtIndexPath:indexPath animated:NO];

        }

        [btn setTitle:@"全选" forState:UIControlStateNormal];
        [self.deleteArray removeAllObjects];
    }

}
- (void)deleteData{
    if (self.deleteArray.count >0) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630530";
        http.parameters[@"codeList"] = self.deleteArray;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            [self LoadData];
        } failure:^(NSError *error) {
            
        }];
    }else{
        [TLAlert alertWithMsg:@"至少选中一条数据"];
        return;
    }

}
-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.btn.selected) {
        NSLog(@"选中");
        [self.deleteArray addObject:[self.dataArray objectAtIndex:indexPath.row]];
    }else{
        AdmissionDetailsVC * vc = [AdmissionDetailsVC new];
        vc.code = self.model[indexPath.row].repayBiz[@"bizCode"];
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"跳转下一页");
    }
}
-(void)refreshTableView:(TLTableView *)refreshTableview didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.btn.selected) {
        NSLog(@"撤销");
        [self.deleteArray removeObject:[self.dataArray objectAtIndex:indexPath.row]];

    }else{
        NSLog(@"取消跳转");
    }
}
//-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}
@end
