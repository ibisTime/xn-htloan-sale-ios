//
//  MakeCardApplyVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/2.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MakeCardApplyVC.h"
#import "MakeCardApplyTableView.h"
#import "JHAddressPickView.h"
@interface MakeCardApplyVC ()<RefreshDelegate,BaseModelDelegate>

@property (nonatomic , strong)MakeCardApplyTableView *tableView;
@property (nonatomic ,strong) JHAddressPickView * pickView;
@property (nonatomic , copy)NSString *province;
@property (nonatomic , copy)NSString *city;
@property (nonatomic , copy)NSString *area;
@property (nonatomic , strong)UILabel *addressLabel;
@end

@implementation MakeCardApplyVC

- (JHAddressPickView *)pickView{
    if (!_pickView) {
        _pickView = [[JHAddressPickView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 350 , SCREEN_WIDTH, 350)];
        _pickView.columns = 3;
        // 关闭默认支持打开上次的结果
        MJWeakSelf;
        _pickView.pickBlock = ^(NSDictionary *dic) {
            weakSelf.province = dic[@"province"];
            weakSelf.city = dic[@"city"];
            weakSelf.area = dic[@"town"];
            weakSelf.addressLabel = [weakSelf.view viewWithTag:10000];
            weakSelf.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.province,weakSelf.city,weakSelf.area];
//            weakSelf.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.province1,weakSelf.city1,weakSelf.area1];
        };
        //        _pickerView.isAutoOpenLast = NO;
    }
    return _pickView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];

}



- (void)initTableView {
    self.tableView = [[MakeCardApplyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"查看详情" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)rightButtonClick
{
    AdmissionDetailsVC *vc = [AdmissionDetailsVC new];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        [self.pickView showInView:self.view];
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    
    UITextField *textField = [self.view viewWithTag:10001];
    
    if ([self.addressLabel.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择地址"];
        return;
    }
    if ([textField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入详细地址"];
        return;
    }
    
    
    TLNetworking *http = [TLNetworking new];
    
    http.isShowMsg = NO;
    http.showView = self.view;
    http.code = @"632510";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"cardPostAddress"] = [NSString stringWithFormat:@"%@ %@",self.addressLabel.text,textField.text];
    [http postWithSuccess:^(id responseObject) {
        
    [TLAlert alertWithSucces:@"申请成功"];
    
     
     NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
     [[NSNotificationCenter defaultCenter] postNotification:notification];
     [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSError *error) {
        
    }];
}


@end
