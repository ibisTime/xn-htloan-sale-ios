//
//  SignVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "SignVC.h"
#import "SignTableView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
#import "SignVideoTableView.h"
#import "SignVideoVC.h"
#import <Masonry.h>
#import <AVKit/AVKit.h>
@interface SignVC ()<RefreshDelegate>
@property (nonatomic,strong) SignTableView * tableView;
@property (nonatomic,strong) NSMutableArray <SurveyModel *> * model;
@end

@implementation SignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    [self loaddata];
    // Do any additional setup after loading the view.
}
- (void)initTableView {
    self.tableView = [[SignTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}


-(void)loaddata{
    
    CarLoansWeakSelf;
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
//    helper.code = @"632965";
    helper.code = @"632515";
    helper.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    helper.parameters[@"roleCode"] = [USERDEFAULTS objectForKey:ROLECODE];
    helper.parameters[@"intevCurNodeCodeList"] = @[@"b03"];
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[SurveyModel class]];
    
    [self.tableView addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            //去除没有的币种
            NSLog(@" ==== %@",objs);
            
            NSMutableArray <SurveyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                SurveyModel *model = (SurveyModel *)obj;
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
            NSMutableArray <SurveyModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                SurveyModel *model = (SurveyModel *)obj;
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
    
    [self findUrlByModel:self.model[index]];
    
    
//    // 3、配置媒体播放控制器
//    AVPlayerViewController *_playerViewController = [[AVPlayerViewController alloc]  init];
//    // 设置媒体源数据
//    NSString*  urlStr = [NSString stringWithFormat:@"%@",self.model[index].videoUrl];
//    NSURL *url;
//    url = [NSURL URLWithString:urlStr];
//
//    _playerViewController.player = [AVPlayer playerWithURL:url];
//    // 设置拉伸模式
//    _playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
//    // 设置是否显示媒体播放组件
//    _playerViewController.showsPlaybackControls = YES;
//    // 播放视频
//    [_playerViewController.player play];
//    // 设置媒体播放器视图大小
//    _playerViewController.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    [self presentViewController:_playerViewController animated:YES completion:nil];
    
}
-(void)findUrlByModel:(SurveyModel *)model{
    SignVideoVC * vc = [SignVideoVC new];
    NSMutableArray * arr = [NSMutableArray array];
    NSArray * array = @[@"bank_video",@"company_video",@"id_no_front_apply",@"id_no_reverse_apply"];
    for (int i = 0; i < model.attachments.count; i ++) {
        for (int j = 0; j < array.count; j ++) {
            if ([model.attachments[i][@"kname"] isEqualToString:array[j]]) {
                [arr addObject:model.attachments[i]];
                switch (j) {
                    case 0:{
                        if ([[NSString stringWithFormat:@"%@", model.attachments[i][@"url"]] containsString :@"http"]) {
                            vc.BankVideoArray = [model.attachments[i][@"url"] componentsSeparatedByString:@"||"];
                        }else{
                            vc.BankVideoArray = [[NSString stringWithFormat:@"http://img.fhcdzx.com/%@",model.attachments[i][@"url"]] componentsSeparatedByString:@"||"];
                        }
                        
                    }
                        break;
                    case 1:{
                        if ([[NSString stringWithFormat:@"%@", model.attachments[i][@"url"]] containsString :@"http"]) {
                            vc.CompanyVideoArray = [model.attachments[i][@"url"] componentsSeparatedByString:@"||"];
                        }else{
                            vc.CompanyVideoArray = [[NSString stringWithFormat:@"http://img.fhcdzx.com/%@",model.attachments[i][@"url"]] componentsSeparatedByString:@"||"];
                        }
                    }
                        break;
                    case 2:
                        vc.idfront = [model.attachments[i][@"url"] componentsSeparatedByString:@"||"];
                        break;
                    case 3:
                        vc.idreverse = [model.attachments[i][@"url"] componentsSeparatedByString:@"||"];
                        
                    default:
                        break;
                }
            }
            
        }
    }
    
    
    vc.Array = arr;
    [self.navigationController pushViewController:vc animated:YES];
    
    
//    return dic;
}
@end
