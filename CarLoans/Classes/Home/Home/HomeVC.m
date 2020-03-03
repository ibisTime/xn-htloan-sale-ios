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

//还款业务管理
#import "CheckRepayVC.h"
//确认还款管理
#import "ConfirmRepayVC.h"
//解除抵押
#import "CancelMortgageVC.h"
//财务垫资
#import "FinancialVC.h"
#import "MakeCardVC.h"
//档案入档
#import "InputfilesVC.h"

//面签视频
#import "SignVC.h"
//
#import "BeyondListVC.h"
//
#import "GreenListVC.h"
//
#import "YellowListVC.h"
//红名单
#import "RedListVC.h"
//
#import "ForwardCheckVC.h"
//
#import "TrailerVC.h"
//
#import "RedeemVC.h"
//
#import "LawSuitVC.h"
//
#import "BlackListVC.h"
//
#import "HistoryVC.h"
#import "HomeListVC.h"
#import "CheckDetailsVC.h"

#import "ClaimsVC.h"
@interface HomeVC ()<RefreshDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSDictionary *dataDic;
    NSArray *nameAry;
    NSArray *dataAry;
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

-(void)isGpsShow
{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630025";
    http.parameters[@"start"] = @"1";
    http.parameters[@"limit"] = @"1000";
    http.parameters[@"parentCode"] = @"SM201904231247451139996";
    http.parameters[@"type"] = @"2";
    http.parameters[@"roleCode"] = http.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    [http postWithSuccess:^(id responseObject) {
        
        dataAry = responseObject[@"data"];
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //测试账号判断
     return 1;
}

#pragma mark------CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    for (int i = 0; i < dataAry.count; i ++) {
        if ([dataAry[i][@"code"] isEqualToString:@"SM201904231326152699024"]) {
            return [MenuModel new].homeArray.count;
        }
    }
    return [MenuModel new].homeArray.count - 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    nameAry = [MenuModel new].homeArray;
    cell.iconImg.image= kImage(nameAry[indexPath.row]);
    cell.nameLbl.text = nameAry[indexPath.row];
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
    
    return CGSizeMake((SCREEN_WIDTH - 0.05)/3, 110);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(SCREEN_WIDTH, 0.001);
}

- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView1" forIndexPath:indexPath];
    return headerView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (indexPath.row >= 0 && indexPath.row <= 16) {
        HomeListVC *vc = [HomeListVC new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = nameAry[indexPath.row];
        vc.selectRow = indexPath.row;
        
        
        
        switch (indexPath.row) {
            case 0:
            {
                vc.curNodeCodeList = @[@"a1",@"a1x"];
            }
                break;
            case 1:
            {
                vc.curNodeCodeList = @[@"a2"];
            }
                break;
            case 2:
            {
                vc.curNodeCodeList = @[@"h1"];
            }
                break;
            case 3:
            {
                vc.curNodeCodeList = @[@"h2"];
            }
                break;
            case 4:
            {
                vc.curNodeCodeList = @[@"b1"];
            }
                break;
            case 5:
            {
                vc.curNodeCodeList = @[@"b3"];
            }
                break;
            case 6:
            {
                vc.curNodeCodeList = @[@"b4"];
            }
                break;
            case 7:
            {
                vc.curNodeCodeList = @[@"b5"];
            }
                break;
            case 8:
            {
                vc.curNodeCodeList = @[@"c1"];
            }
                break;
            case 9:
            {
                vc.curNodeCodeList = @[@"c2"];
            }
                break;
            case 10:
            {
                vc.curNodeCodeList = @[@"d1"];
            }
                break;
            case 11:
            {
                vc.curNodeCodeList = @[@"d2"];
            }
                break;
            case 12:
            {
                vc.curNodeCodeList = @[@"d3"];
            }
                break;
            case 13:
            {
                vc.curNodeCodeList = @[@"d4"];
            }
                break;
            case 14:
            {
                vc.curNodeCodeList = @[@"e1"];
            }
                break;
            case 15:
            {
                vc.curNodeCodeList = @[@"e2"];
            }
                break;
            case 16:
            {
                vc.curNodeCodeList = @[@"f1"];
            }
                break;
                
            default:
                break;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 17) {
        ClaimsVC *vc = [ClaimsVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (indexPath.row == 18) {
        GPSClaimsVC *vc = [GPSClaimsVC new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
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
    self.title = @"首页";
    [self.view addSubview:self.collectionView];
    [self loadData];
    
//    CheckDetailsVC *vc = [CheckDetailsVC new];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];

}


-(void)viewWillAppear:(BOOL)animated
{
    [self isGpsShow];
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
    [USERDEFAULTS setObject:dict[@"departmentCode"] forKey:DEPARTMENTCODE];
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
    
    
    
    TLNetworking * http2 = [TLNetworking new];
    http2.isShowMsg = NO;
    http2.code = @"632067";
    [http2 postWithSuccess:^(id responseObject) {
        [USERDEFAULTS setObject:responseObject[@"data"] forKey:COMPANYNODE];
    } failure:^(NSError *error) {
        
    }];
    
    TLNetworking * http3 = [TLNetworking new];
    http3.isShowMsg = NO;
    http3.code = @"632827";
    [http3 postWithSuccess:^(id responseObject) {
        [USERDEFAULTS setObject:responseObject[@"data"] forKey:ENTERLOCATION];
    } failure:^(NSError *error) {
        
    }];
    
    
    TLNetworking * http4 = [TLNetworking new];
    http4.code = @"632007";
    http4.isShowMsg = NO;
    [http4 postWithSuccess:^(id responseObject) {
        [USERDEFAULTS setObject:responseObject[@"data"] forKey:ADVANCECARD];
    } failure:^(NSError *error) {
        
    }];
    
    TLNetworking *http5 = [TLNetworking new];
    http5.isShowMsg = NO;
    http5.code = @"630477";
    http5.parameters[@"status"] = @"1";
    [http5 postWithSuccess:^(id responseObject) {
        [USERDEFAULTS setObject:responseObject[@"data"] forKey:REGION];
        
    } failure:^(NSError *error) {
        
    }];
    
}


@end
