//
//  HomeVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HomeVC.h"
#import "HomeTbView.h"
//资信调查
#import "SurveyTGVC.h"
//车辆落户
#import "InsideSureHomeVC.h"
#import "CarSettledInVC.h"
//车辆抵押
#import "CarMortgageVC.h"
//#import "CarMortgageVC2.h"
#import "HomeCarVC.h"
//面签
#import "FaceSignVC.h"
#import "FaceSignHomeVC.h"

#import "AccessApplyVC.h"

//GPS安装
#import "GPSInstallationVC.h"
#import "GPSHomeVC.h"
//客户作废
#import "CustomerInvalidVC.h"
//GPS申领
#import "GPSClaimsVC.h"
//历史客户
#import "HistoryUserVC.h"
//资料传递
#import "DataTransferVC.h"
//银行放款
#import "BankLendingVC.h"
//结清审核
#import "SettlementAuditVC.h"
//发保合
#import "ProtectUsVC.h"
#import "HomeCollectionViewCell.h"
//附件池
#import "AttachmentPoolVC.h"

//财务垫资
#import "FinancialVC.h"
#import "MakeCardVC.h"
//档案入档
#import "InputfilesVC.h"
@interface HomeVC ()<RefreshDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSDictionary *dataDic;
}
@property (nonatomic , strong)UICollectionView *collectionView;
@end

@implementation HomeVC

-(UICollectionView *)collectionView{
    if (_collectionView==nil) {
        UICollectionViewFlowLayout *flowayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight) collectionViewLayout:flowayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = kWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1"];
    }
    return _collectionView;
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //测试账号判断
     return 4;
}

#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 11;
    }
    if (section == 1) {
        return 5;
    }
    if (section == 2) {
        return 1;
    }
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        NSArray *array = @[@"征信发起",@"征信派单",@"征信录入",@"征信审核",@"面签录入",@"面签审核",@"准入申请",@"审核岗",@"制卡",@"车辆抵押",@"档案入档"];
        cell.iconImg.image= kImage(array[indexPath.row]);
        cell.nameLbl.text = array[indexPath.row];
    }
    if (indexPath.section == 1) {
        NSArray *array = @[@"资料传递",@"财务垫资",@"发保合",@"GPS安装",@"银行放款",@"车辆抵押"];
        cell.iconImg.image= kImage(array[indexPath.row]);
        cell.nameLbl.text = array[indexPath.row];
    }
    if (indexPath.section == 2) {
        NSArray *array = @[@"结算审核"];
        cell.iconImg.image= kImage(array[indexPath.row]);
        cell.nameLbl.text = array[indexPath.row];
    }
    if (indexPath.section == 3) {
        NSArray *array = @[@"业务附件池",@"业务作废",@"GPS申领",@"面签管理"];
        cell.iconImg.image= kImage(array[indexPath.row]);
        cell.nameLbl.text = array[indexPath.row];
    }
    kViewBorderRadius(cell, 0, 1, kBackgroundColor);
    return cell;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0.001;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0.001;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((SCREEN_WIDTH - 0.05)/3, (SCREEN_WIDTH - 0.05)/3);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(SCREEN_WIDTH, 55);
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1" forIndexPath:indexPath];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    topView.backgroundColor = kBackgroundColor;
    [headerView addSubview:topView];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 45)];
    backView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:backView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 14.5, 4, 16)];
    lineView.backgroundColor = MainColor;
    kViewRadius(lineView, 2);
    [backView addSubview:lineView];
    
    UILabel *headLabel = [UILabel labelWithFrame:CGRectMake(lineView.xx +  6.5, 0, SCREEN_WIDTH - 45, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(15) textColor:[UIColor blackColor]];
    [backView addSubview:headLabel];
    //    headView.
    NSArray *nameArray = @[@"贷前准入",@"贷中执行",@"贷后跟踪",@"车贷工具"];
    headLabel.text = nameArray[indexPath.section];
    
    
    return headerView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
                SurveyTGVC *vc = [SurveyTGVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.curNodeCodeList = @[@"a1",@"ax1"];
                vc.title = @"征信发起";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                SurveyTGVC *vc = [SurveyTGVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.curNodeCodeList = @[@"a2"];
                vc.title = @"征信派单";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                SurveyTGVC *vc = [SurveyTGVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.curNodeCodeList = @[@"a2"];
                vc.title = @"录入征信结果";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                SurveyTGVC *vc = [SurveyTGVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.curNodeCodeList = @[@"a3"];
                vc.title = @"征信审核";
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                FaceSignVC *vc = [FaceSignVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = @"面签系统";
                vc.intevCurNodeCodeList = @[@"b01",@"b01x"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 5:
            {
                FaceSignVC *vc = [FaceSignVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = @"面签审核";
                vc.intevCurNodeCodeList = @[@"b02"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 6:
            {
                AccessApplyVC *vc = [AccessApplyVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = @"准入申请";
                vc.curNodeCodeList = @[@"b1",@"b1x"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 7:
            {
                AccessApplyVC *vc = [AccessApplyVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = @"准入审核";
                vc.curNodeCodeList = @[@"b2",@"b3",@"b4",@"b5",@"b6",@"b7"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 8:
            {
                MakeCardVC *vc = [MakeCardVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = @"制卡";
                vc.makeCardNodeList = @[@"h1",@"h2",@"h3"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 9:
            {
                CarMortgageVC *vc = [CarMortgageVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = @"车辆抵押";
                vc.curNodeCodeList = @[@"e6",@"f1",@"f2",@"f2x",@"f3",@"f4",@"f5",@"f5x",@"f6",@"f7",@"f8",@"f9",@"f10",@"f11",@"f12"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 10:
            {
                InputfilesVC *vc = [InputfilesVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.title = @"档案入档";
                vc.curNodeCodeList = @[@"h1",@"h2",@"h3"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        
        switch (indexPath.row) {
            case 0:
            {
                DataTransferVC *vc = [DataTransferVC new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                FinancialVC * vc = [FinancialVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.curNodeCodeList = @[@"g1",@"g2",@"g3",@"g4",@"g5"];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 2:
            {
                ProtectUsVC *vc = [ProtectUsVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.curNodeCodeList = @[@"c1",@"c2",@"c1x"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                GPSInstallationVC *vc = [GPSInstallationVC new];
                vc.hidesBottomBarWhenPushed = YES;
                vc.curNodeCodeList = @[@"d1",@"d2",@"d3",@"d4"];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                BankLendingVC *vc = [BankLendingVC new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 5:
            {
                CarMortgageVC *vc = [CarMortgageVC new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
                
            default:
                break;
        }
        
    }
    
    
    if (indexPath.section == 2) {
        SettlementAuditVC *vc = [SettlementAuditVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
            {
                AttachmentPoolVC *vc = [AttachmentPoolVC  new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                CustomerInvalidVC *vc = [CustomerInvalidVC  new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                GPSClaimsVC *vc = [GPSClaimsVC  new];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                
            }
                break;
                
            default:
                break;
        }
    }
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

    return UIEdgeInsetsMake(0, 0, 0, 0);
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self navigativeView];
    [self.view addSubview:self.collectionView];
    [self loadData];
}

- (void)initTableView {
//    self.tableView = [[HomeTbView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
//    self.tableView.refreshDelegate = self;
//    self.tableView.backgroundColor = kBackgroundColor;
//    [self.view addSubview:self.tableView];
    

}

//-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index{
//    if ([dataDic[@"roleCode"] isEqualToString:@"SR20180000000000000ZHRY"]) {
//        switch (index) {
//            case 100:
//            {
//                SurveyVC *vc = [SurveyVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 101:
//            {
//                FaceSignVC *vc = [FaceSignVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 102:
//            {
//                BankLendingVC *vc = [BankLendingVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 103:
//            {
//                CarMortgageVC *vc = [CarMortgageVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 104:
//            {
//                SettlementAuditVC *vc = [[SettlementAuditVC alloc]init];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 1000:
//            {
//                DataTransferVC *vc = [DataTransferVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            default:
//                break;
//        }
//    }else
//    {
//        switch (index) {
//            case 100:
//            {
//                SurveyVC *vc = [SurveyVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 101:
//            {
//                FaceSignVC *vc = [FaceSignVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 102:
//            {
////                if ([[USERDEFAULTS objectForKey:USERDATA][@"loginName"] isEqualToString:@"ios"]) {
////                    CarSettledInVC *vc = [CarSettledInVC new];
////                    [self.navigationController pushViewController:vc animated:YES];
////                }else
////                {
//                    GPSHomeVC *vc = [GPSHomeVC new];
//                    [self.navigationController pushViewController:vc animated:YES];
////                }
//
//            }
//                break;
//            case 103:
//            {
//                CarSettledInVC *vc = [CarSettledInVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 104:
//            {
//                CarMortgageVC *vc = [CarMortgageVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 1000:
//            {
//                CustomerInvalidVC *vc = [CustomerInvalidVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 1001:
//            {
////                if ([[USERDEFAULTS objectForKey:USERDATA][@"loginName"] isEqualToString:@"ios"]) {
////                    HistoryUserVC *vc = [HistoryUserVC new];
////                    [self.navigationController pushViewController:vc animated:YES];
////                }else
////                {
//                    GPSClaimsVC *vc = [GPSClaimsVC new];
//                    [self.navigationController pushViewController:vc animated:YES];
////                }
//
//            }
//                break;
//            case 1002:
//            {
//                HistoryUserVC *vc = [HistoryUserVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//                break;
//            case 10000:
//            {
//                DataTransferVC *vc = [DataTransferVC new];
//                [self.navigationController pushViewController:vc animated:YES];
//            }
//
//
//            default:
//                break;
//        }
//    }
//}

-(void)navigativeView
{
    self.title = @"首页";
    
}

//-(void)rightButtonClick
//{
//    [TLAlert alertWithTitle:@"提示" msg:@"是否退出登录" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {
//        LoginVC *vc = [[LoginVC alloc]init];
//        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//        [USERDEFAULTS removeObjectForKey:USER_ID];
//        [USERDEFAULTS removeObjectForKey:TOKEN_ID];
//        window.rootViewController = vc;
//    } confirm:^(UIAlertAction *action) {
//
//    }];
//}

-(void)viewWillAppear:(BOOL)animated
{

    [self updateUserInfoWithNotification];
}



- (void)updateUserInfoWithNotification
{
    TLNetworking *http = [TLNetworking new];

    http.isShowMsg = NO;
    http.code = USER_INFO;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {

        dataDic =  responseObject[@"data"];
//        self.tableView.dic = dataDic;
        [self setUserInfoWithDict:responseObject[@"data"]];
        [self RedDotPromptDic:responseObject[@"data"]];
    } failure:^(NSError *error) {
        
    }];
}

-(void)RedDotPromptDic:(NSDictionary *)dict
{

}

- (void)setUserInfoWithDict:(NSDictionary *)dict
{
    [USERDEFAULTS setObject:dict forKey:USERDATA];
    [USERDEFAULTS setObject:dict[@"roleCode"] forKey:ROLECODE];
    [USERDEFAULTS setObject:dict[@"postCode"] forKey:ROSTCODE];
    [USERDEFAULTS setObject:dict[@"teamCode"] forKey:TEAMCODE];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadData
{
    TLNetworking *http = [TLNetworking new];
    http.isShowMsg = NO;
    http.code = @"630147";
    [http postWithSuccess:^(id responseObject) {
        [USERDEFAULTS setObject:responseObject[@"data"] forKey:NODE];
    } failure:^(NSError *error) {

    }];

    TLNetworking *http1 = [TLNetworking new];
    http1.isShowMsg = NO;
    http1.code = @"630036";
    [http1 postWithSuccess:^(id responseObject) {
        [USERDEFAULTS setObject:responseObject[@"data"] forKey:BOUNCEDDATA];
    } failure:^(NSError *error) {

    }];
}


@end
