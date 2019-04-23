//
//  VideoCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "VideoCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
#import <Masonry.h>
#import <AVKit/AVKit.h>
@implementation VideoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *topLbl = [UILabel labelWithFrame:CGRectMake(15, 23, SCREEN_WIDTH - 107 - 30, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(11) textColor:kHexColor(@"#999999")];
        self.topLbl = topLbl;
        [self addSubview:topLbl];
        
        
    }
    return self;
}

-(void)setVideoAry:(NSArray *)videoAry
{
    _videoAry = videoAry;
    for (int i = 0; i < videoAry.count; i ++) {
        UIButton *videoBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        videoBtn.frame = CGRectMake(15, 39 + i % videoAry.count * 20, SCREEN_WIDTH - 107 - 30, 15);
        [videoBtn setTitle:videoAry[i] forState:(UIControlStateNormal)];
        [videoBtn addTarget:self action:@selector(videoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        videoBtn.tag = i;
        videoBtn.titleLabel.font = Font(14);
        [self addSubview:videoBtn];
    }
}

-(void)videoBtnClick:(UIButton *)sender
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    // 3、配置媒体播放控制器
    AVPlayerViewController *_playerViewController = [[AVPlayerViewController alloc]  init];
    // 设置媒体源数据
    NSString*  urlStr = [NSString stringWithFormat:@"%@",_videoAry[sender.tag]];
    NSURL *url;
    if ([urlStr containsString:@"myqcloud.com"]) {
        url = [NSURL URLWithString:urlStr];
    }else{
        NSString* Str = [NSString stringWithFormat:@"%@%@",NSTemporaryDirectory(),urlStr];
        if ([[NSFileManager defaultManager] fileExistsAtPath:Str]) {
            urlStr = Str;
            url = [NSURL fileURLWithPath:urlStr];
        }else{
            
            urlStr = [urlStr convertImageUrl];
            url = [NSURL URLWithString:urlStr];
        }
    }
    _playerViewController.player = [AVPlayer playerWithURL:url];
    // 设置拉伸模式
    _playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
    // 设置是否显示媒体播放组件
    _playerViewController.showsPlaybackControls = YES;
    // 播放视频
    [_playerViewController.player play];
    // 设置媒体播放器视图大小
    _playerViewController.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [window.rootViewController presentViewController:_playerViewController animated:YES completion:nil];
}


@end
