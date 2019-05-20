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
#import <Masonry.h>
#import <AVKit/AVKit.h>
@interface SignVC ()<RefreshDelegate>
@property (nonatomic,strong) SignTableView * tableView;
@property (nonatomic,strong) NSMutableArray <SignModel *> * model;
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
    helper.code = @"632965";
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableView;
    [helper modelClass:[SignModel class]];
    
    [self.tableView addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            //去除没有的币种
            NSLog(@" ==== %@",objs);
            
            NSMutableArray <SignModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                SignModel *model = (SignModel *)obj;
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
            NSMutableArray <SignModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                SignModel *model = (SignModel *)obj;
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
//    NSString *videoURL = @"http://www.51ios.net/archives/784";
    
//    MPMoviePlayerController * Movie = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:videoURL]];
//    Movie.shouldAutoplay = NO;
//    [self.navigationController pushViewController:Movie animated:YES];
    
    
    
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    // 3、配置媒体播放控制器
    AVPlayerViewController *_playerViewController = [[AVPlayerViewController alloc]  init];
    // 设置媒体源数据
    NSString*  urlStr = [NSString stringWithFormat:@"%@",self.model[index].videoUrl];
//    NSString* Str = [NSString stringWithFormat:@"%@%@",NSTemporaryDirectory(),urlStr];
    NSURL *url;
    url = [NSURL URLWithString:urlStr];
//    if ([urlStr containsString:@"myqcloud.com"]) {
//
//
//    }else{
//
//        NSString* Str = [NSString stringWithFormat:@"%@%@",NSTemporaryDirectory(),urlStr];
//
//
//        if ([[NSFileManager defaultManager] fileExistsAtPath:Str]) {
//            urlStr = Str;
//            url = [NSURL fileURLWithPath:urlStr];
//        }else{
//
//            urlStr = [urlStr convertImageUrl];
//            url = [NSURL URLWithString:urlStr];
//        }
//    }
    _playerViewController.player = [AVPlayer playerWithURL:url];
    // 设置拉伸模式
    _playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
    // 设置是否显示媒体播放组件
    _playerViewController.showsPlaybackControls = YES;
    // 播放视频
    [_playerViewController.player play];
    // 设置媒体播放器视图大小
    _playerViewController.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self presentViewController:_playerViewController animated:YES completion:nil];
    
    
}
@end
