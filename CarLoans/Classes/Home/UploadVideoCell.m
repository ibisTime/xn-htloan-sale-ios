//
//  UploadVideoCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "UploadVideoCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
#import <Masonry.h>
#import <AVKit/AVKit.h>
@interface UploadVideoCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UIButton *photoBtn;
    NSArray *array;
}

@property (nonatomic, strong) SelVideoPlayer *player;

@end

@implementation UploadVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 20)/4 ,(SCREEN_WIDTH - 20)/4);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        float numberToRound;
        int result;

        numberToRound = (array.count + 1.0)/4.0;
        result = (int)ceilf(numberToRound);
        NSLog(@"roundf(%.2f) = %d", numberToRound, result);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, result * ((SCREEN_WIDTH - 20)/4 + 10)) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];

        //注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.contentView addSubview:self.collectionView];
        NSLog(@"%@",self.collectDataArray);
    }
    return self;
}



-(void)setCollectDataArray:(NSArray *)collectDataArray
{
    array = collectDataArray;
    float numberToRound;
    int result;
    numberToRound = (array.count + 1.0)/4.0;
    result = (int)ceilf(numberToRound);
    _collectionView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, result * ((SCREEN_WIDTH - 20)/4 + 10));
    [self.collectionView reloadData];
}

#pragma mark -- Collection delegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return array.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor clearColor];
//    cell.backgroundColor = [UIColor redColor];
    if (indexPath.row == 0) {
        photoBtn = [UIButton buttonWithTitle:@"" titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
        photoBtn.frame = CGRectMake(2.5, 2.5, (SCREEN_WIDTH - 20)/4 - 5 , (SCREEN_WIDTH - 20)/4 - 5);
        kViewBorderRadius(photoBtn, 5, 1, HGColor(230, 230, 230));

        [photoBtn setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        [cell addSubview:photoBtn];

        UIView *backView = [[UIView alloc]initWithFrame: CGRectMake(2.5, 2.5, (SCREEN_WIDTH - 20)/4 - 5 , (SCREEN_WIDTH - 20)/4 - 5)];
        [cell addSubview:backView];
    }else
    {
        UIImageView *image = [[UIImageView alloc]initWithFrame: CGRectMake(2.5, 2.5, (SCREEN_WIDTH - 20)/4 - 5 , (SCREEN_WIDTH - 20)/4 - 5)];
        kViewBorderRadius(image, 5, 1, HGColor(230, 230, 230));
        image.image = [self firstFrameWithVideoURL:array[indexPath.row - 1] size:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        [cell addSubview:image];

        UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        selectButton.frame = CGRectMake((SCREEN_WIDTH - 20)/4 - 32.5, 2.5, 30, 30);
        [selectButton setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
        [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        selectButton.tag = indexPath.row - 1 + 1000;
        [cell addSubview:selectButton];
    }
    return cell;
}


#pragma mark ---- 获取图片第一帧
- (UIImage *)firstFrameWithVideoURL:(NSString *)urlStr size:(CGSize)size
{
    //#define QINIUURL @"http://p9sctbdpk.bkt.clouddn.com/"
//#define QINIUURL @"http://img.fhcdzx.com/"
// http://1257046543.vod2.myqcloud.com/c78eb187vodcq1257046543/ec8e93cb5285890782858050060/f0.mp4
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
    
//    urlStr = [NSString stringWithFormat:@"%@%@",NSTemporaryDirectory(),urlStr];
    
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    generator.appliesPreferredTrackTransform = YES;
    generator.maximumSize = CGSizeMake(size.width, size.height);
    NSError *error = nil;
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10) actualTime:NULL error:&error];
    {
        return [UIImage imageWithCGImage:img];
    }
    return nil;
}

-(void)setSelectStr:(NSString *)selectStr
{
    _selectStr = selectStr;
}

#pragma mark -- Collection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了 %ld ", indexPath.row);
    if (indexPath.row == 0) {
        if([self.delegate respondsToSelector:@selector(CustomCollection:didSelectRowAtIndexPath:str:)]){
            [self.delegate CustomCollection:collectionView didSelectRowAtIndexPath:indexPath str:_selectStr];
        }
    }else
    {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        // 3、配置媒体播放控制器
        AVPlayerViewController *_playerViewController = [[AVPlayerViewController alloc]  init];
        // 设置媒体源数据
       NSString*  urlStr = [NSString stringWithFormat:@"%@",array[indexPath.row-1]];
        NSString* Str = [NSString stringWithFormat:@"%@%@",NSTemporaryDirectory(),urlStr];
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
}

-(void)selectButtonClick:(UIButton *)sender
{
    [_delegate UploadImagesBtn:sender str:_selectStr];
}

@end
