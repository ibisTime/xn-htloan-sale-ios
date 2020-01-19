//
//  UploadMultiplePicturesCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "UploadMultiplePicturesCell.h"
#import "AddPhotoCollCell.h"
#import "PhotoCollCell.h"
#import <AVKit/AVKit.h>
@interface UploadMultiplePicturesCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UIButton *photoBtn;
    NSArray *_phostsArr;
}

@property (nonatomic , assign)NSInteger count;
@end

@implementation UploadMultiplePicturesCell


- (TLImagePicker *)imagePicker {
    if (!_imagePicker) {
        ProjectWeakSelf;
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        _imagePicker = [[TLImagePicker alloc] initWithVC:window.rootViewController];
        _imagePicker.allowsEditing = YES;
        _imagePicker.type = @"many";
        if (_isSingle == YES) {
            _imagePicker.count = 1;
        }else
        {
            _imagePicker.count = 9;
        }
        
        _imagePicker.pickFinish = ^(NSDictionary *info){
            
            
            if ([_name containsString:@"视频"] == YES) {
                
                
                
                NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
                if ([mediaType isEqualToString:@"public.movie"])
                {
                    NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
                    AVURLAsset *asset = [AVURLAsset assetWithURL:videoUrl];
                    NSString  *videoPath =  info[UIImagePickerControllerMediaURL];
                    
                    NSLog(@"相册视频路径是：%@",videoPath);
                    //第二种方法，进行视频导出
                    [weakSelf startExportVideoWithVideoAsset:asset completion:^(NSString *outputPath) {
                        
//                        [self getSomeMessageWithFilePath:_filePath];
                        
                    }];;
                    
                    

                }
            }else
            {
                UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
                NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
                TLUploadManager *manager = [TLUploadManager manager];
                manager.imgData = imgData;
                manager.image = image;
                [manager getTokenShowView:weakSelf succes:^(NSString *key) {
                    WGLog(@"%@",key);
                    [weakSelf setImage:image setData:key];
                } failure:^(NSError *error) {
                    [TLAlert alertWithInfo:@"上传失败"];
                }];
            }
        };
        if ([_name containsString:@"视频"] == NO) {
            _imagePicker.ManyPick = ^(NSMutableArray *info) {
                _phostsArr = info;
                weakSelf.count = info.count - 1;
                [weakSelf updataphoto];
            };
        }
    }
    return _imagePicker;
}


- (void)startExportVideoWithVideoAsset:(AVURLAsset *)videoAsset completion:(void (^)(NSString *outputPath))completion
{
    // Find compatible presets by video asset.
    NSArray *presets = [AVAssetExportSession exportPresetsCompatibleWithAsset:videoAsset];
    
    NSString *pre = nil;
    
    if ([presets containsObject:AVAssetExportPreset3840x2160])
    {
        pre = AVAssetExportPreset3840x2160;
    }
    else if([presets containsObject:AVAssetExportPreset1920x1080])
    {
        pre = AVAssetExportPreset1920x1080;
    }
    else if([presets containsObject:AVAssetExportPreset1280x720])
    {
        pre = AVAssetExportPreset1280x720;
    }
    else if([presets containsObject:AVAssetExportPreset960x540])
    {
        pre = AVAssetExportPreset1280x720;
    }
    else
    {
        pre = AVAssetExportPreset640x480;
    }
    
    // Begin to compress video
    // Now we just compress to low resolution if it supports
    // If you need to upload to the server, but server does't support to upload by streaming,
    // You can compress the resolution to lower. Or you can support more higher resolution.
    if ([presets containsObject:AVAssetExportPreset640x480]) {
        //        AVAssetExportSession *session = [[AVAssetExportSession alloc]initWithAsset:videoAsset presetName:AVAssetExportPreset640x480];
        AVAssetExportSession *session = [[AVAssetExportSession alloc]initWithAsset:videoAsset presetName:AVAssetExportPreset640x480];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yy-MM-dd-HH:mm:ss"];
        
        NSString *outputPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", [[formater stringFromDate:[NSDate date]] stringByAppendingString:@".mov"]];
        NSLog(@"video outputPath = %@",outputPath);
        //删除原来的 防止重复选
//        _timeSecond = 0;
//        [[NSFileManager defaultManager] removeItemAtPath:_filePath error:nil];
//        [[NSFileManager defaultManager] removeItemAtPath:_imagePath error:nil];
//
//        _filePath = outputPath;
        session.outputURL = [NSURL fileURLWithPath:outputPath];
        
        // Optimize for network use.
        session.shouldOptimizeForNetworkUse = true;
        
        NSArray *supportedTypeArray = session.supportedFileTypes;
        if ([supportedTypeArray containsObject:AVFileTypeMPEG4]) {
            session.outputFileType = AVFileTypeMPEG4;
        } else if (supportedTypeArray.count == 0) {
            NSLog(@"No supported file types 视频类型暂不支持导出");
            return;
        } else {
            session.outputFileType = [supportedTypeArray objectAtIndex:0];
        }
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents"]]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents"] withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:outputPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:outputPath error:nil];
        }
        
        // Begin to export video to the output path asynchronously.
        [session exportAsynchronouslyWithCompletionHandler:^(void) {
            switch (session.status) {
                case AVAssetExportSessionStatusUnknown:
                    NSLog(@"AVAssetExportSessionStatusUnknown");
                     [TLAlert alertWithInfo:@"视频导出失败"];
                    break;
                case AVAssetExportSessionStatusWaiting:
                    NSLog(@"AVAssetExportSessionStatusWaiting");
                     [TLAlert alertWithInfo:@"视频导出失败"];
                    break;
                case AVAssetExportSessionStatusExporting:
                    NSLog(@"AVAssetExportSessionStatusExporting");
                     [TLAlert alertWithInfo:@"视频导出失败"];
                    break;
                case AVAssetExportSessionStatusCompleted: {
                    NSLog(@"AVAssetExportSessionStatusCompleted");
                    MJWeakSelf;
                    TLUploadManager *manager = [TLUploadManager manager];
                    manager.videoData = outputPath;
                    [manager getTokenShowViewFile:weakSelf succes:^(NSString *key) {
                        WGLog(@"%@",key);
                        [weakSelf setVideoStr:@"" setData:key];
                        
                    } failure:^(NSError *error) {
                        
                    }];

//                    });
                }  break;
                case AVAssetExportSessionStatusFailed:
                     [TLAlert alertWithInfo:@"视频导出失败"];
                    NSLog(@"AVAssetExportSessionStatusFailed");
                    break;
                default: break;
            }
        }];
    }
}





/// 获取优化后的视频转向信息
- (AVMutableVideoComposition *)fixedCompositionWithAsset:(AVAsset *)videoAsset {
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
    // 视频转向
    int degrees = [self degressFromVideoFileWithAsset:videoAsset];
    if (degrees != 0) {
        CGAffineTransform translateToCenter;
        CGAffineTransform mixedTransform;
        videoComposition.frameDuration = CMTimeMake(1, 30);
        
        NSArray *tracks = [videoAsset tracksWithMediaType:AVMediaTypeVideo];
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        
        AVMutableVideoCompositionInstruction *roateInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
        roateInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, [videoAsset duration]);
        AVMutableVideoCompositionLayerInstruction *roateLayerInstruction = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:videoTrack];
        
        if (degrees == 90) {
            // 顺时针旋转90°
            translateToCenter = CGAffineTransformMakeTranslation(videoTrack.naturalSize.height, 0.0);
            mixedTransform = CGAffineTransformRotate(translateToCenter,M_PI_2);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.height,videoTrack.naturalSize.width);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        } else if(degrees == 180){
            // 顺时针旋转180°
            translateToCenter = CGAffineTransformMakeTranslation(videoTrack.naturalSize.width, videoTrack.naturalSize.height);
            mixedTransform = CGAffineTransformRotate(translateToCenter,M_PI);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.width,videoTrack.naturalSize.height);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        } else if(degrees == 270){
            // 顺时针旋转270°
            translateToCenter = CGAffineTransformMakeTranslation(0.0, videoTrack.naturalSize.width);
            mixedTransform = CGAffineTransformRotate(translateToCenter,M_PI_2*3.0);
            videoComposition.renderSize = CGSizeMake(videoTrack.naturalSize.height,videoTrack.naturalSize.width);
            [roateLayerInstruction setTransform:mixedTransform atTime:kCMTimeZero];
        }
        
        roateInstruction.layerInstructions = @[roateLayerInstruction];
        // 加入视频方向信息
        videoComposition.instructions = @[roateInstruction];
    }
    return videoComposition;
}

/// 获取视频角度
- (int)degressFromVideoFileWithAsset:(AVAsset *)asset {
    int degress = 0;
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if([tracks count] > 0) {
        AVAssetTrack *videoTrack = [tracks objectAtIndex:0];
        CGAffineTransform t = videoTrack.preferredTransform;
        if(t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0){
            // Portrait
            degress = 90;
        } else if(t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0){
            // PortraitUpsideDown
            degress = 270;
        } else if(t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0){
            // LandscapeRight
            degress = 0;
        } else if(t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
            // LandscapeLeft
            degress = 180;
        }
    }
    return degress;
}

-(void)updataphoto
{
    CarLoansWeakSelf;
    UIImage *image = _phostsArr[self.count][@"image"];
    NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
    //进行上传
    TLUploadManager *manager = [TLUploadManager manager];
    manager.imgData = imgData;
    manager.image = image;
    manager.isdissmiss = NO;
    
    [manager getTokenShowView:weakSelf succes:^(NSString *key) {
        WGLog(@"%@",key);
        self.count --;
        [weakSelf setImage:image setData:key];
        if (self.count >= 0) {
            [self updataphoto];
        }
    } failure:^(NSError *error) {
        [TLAlert alertWithInfo:@"上传失败"];
    }];
}

-(void)CustomBlock
{
    float numberToRound;
    int result;
    if (_isDetails == YES) {
        numberToRound = (_collectDataArray.count + 0.0)/3.0;
    }else
    {
        numberToRound = (_collectDataArray.count + 1.0)/3.0;
    }
    
    result = (int)ceilf(numberToRound);
    _collectionView.frame = CGRectMake(7.5, 41 - 7.5, SCREEN_WIDTH - 15, result * (82.5 + 7.5) + 15);
    [self.collectionView reloadData];
}

-(void)setVideoStr:(NSString *)video setData:(NSString *)data
{
    
    if ([data containsString:@"tmp/"]) {
        [TLAlert alertWithMsg:@"请重新上传视频"];
        return;
    }else
    {
        NSMutableArray *ary = [NSMutableArray array];
        
        if (_isSingle == YES) {
            self.collectDataArray = @[data];
        }else
        {
            if (_imagePicker.count != 1) {
                [ary addObjectsFromArray:self.collectDataArray];
            }
            [ary addObject:data];
            self.collectDataArray = ary;
        }
        
        
        [self.collectionView reloadData];
        self.returnAryBlock(self.collectDataArray, _name, _selectSection);
        [self CustomBlock];
    }
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    NSMutableArray *ary = [NSMutableArray array];
    if (_isSingle == YES) {
        self.collectDataArray = @[data];
    }else
    {
        if (_imagePicker.count != 1) {
            [ary addObjectsFromArray:self.collectDataArray];
        }
        [ary addObject:data];
        self.collectDataArray = ary;
    }
    
    
    
    [self.collectionView reloadData];
    self.returnAryBlock(self.collectDataArray, _name, _selectSection);
    [self CustomBlock];
}

-(void)setIsSingle:(BOOL)isSingle
{
    _isSingle = isSingle;
    if (isSingle == YES) {
        _imagePicker.count = 1;
    }else
    {
        _imagePicker.count = 9;
    }
    
    CarLoansWeakSelf;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    _imagePicker = [[TLImagePicker alloc] initWithVC:window.rootViewController];
    _imagePicker.allowsEditing = YES;
    _imagePicker.type = @"many";
    if (_isSingle == YES) {
        _imagePicker.count = 1;
    }else
    {
        _imagePicker.count = 9;
    }
    
    _imagePicker.pickFinish = ^(NSDictionary *info){
        
        
        if ([_name containsString:@"视频"] == YES) {
            
            
            
            NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
            if ([mediaType isEqualToString:@"public.movie"])
            {
                NSURL *videoUrl = [info objectForKey:UIImagePickerControllerMediaURL];
                AVURLAsset *asset = [AVURLAsset assetWithURL:videoUrl];
                NSString  *videoPath =  info[UIImagePickerControllerMediaURL];
                
                NSLog(@"相册视频路径是：%@",videoPath);
                //第二种方法，进行视频导出
                [weakSelf startExportVideoWithVideoAsset:asset completion:^(NSString *outputPath) {
                    
                    //                        [self getSomeMessageWithFilePath:_filePath];
                    
                }];;
                
                
                
            }
        }else
        {
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 1.0);
            TLUploadManager *manager = [TLUploadManager manager];
            manager.imgData = imgData;
            manager.image = image;
            [manager getTokenShowView:weakSelf succes:^(NSString *key) {
                WGLog(@"%@",key);
                [weakSelf setImage:image setData:key];
            } failure:^(NSError *error) {
                [TLAlert alertWithInfo:@"上传失败"];
            }];
        }
    };
    
    if ([_name containsString:@"视频"] == NO) {
        _imagePicker.ManyPick = ^(NSMutableArray *info) {
            _phostsArr = info;
            weakSelf.count = info.count - 1;
            [weakSelf updataphoto];
        };
    }
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        layout.minimumInteritemSpacing = 7.5;
        layout.minimumLineSpacing = 7.5;

        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 45)/3  , 82.5);
        layout.sectionInset = UIEdgeInsetsMake(7.5, 7.5, 7.5, 7.5);
        
        float numberToRound;
        int result;
//        self.isEditor = YES;
        numberToRound = (self.collectDataArray.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        NSLog(@"roundf(%.2f) = %d", numberToRound, result);
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 14.5, SCREEN_WIDTH, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        self.nameLbl = nameLbl;
        [self addSubview:nameLbl];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(7.5, 41 - 7.5, SCREEN_WIDTH - 15, result * (82.5 + 7.5) + 15) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        
        //注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[AddPhotoCollCell class] forCellWithReuseIdentifier:@"AddPhotoCollCell"];
        [_collectionView registerClass:[PhotoCollCell class] forCellWithReuseIdentifier:@"PhotoCollCell"];
        [self addSubview:self.collectionView];
//        NSLog(@"%@",self.collectDataArray);
    }
    return self;
}

-(void)setName:(NSString *)name
{
    
    _name = name;
    _nameLbl.text = name;
}

-(void)setCollectDataArray:(NSArray *)collectDataArray
{
    for (int i = 0 ; i < collectDataArray.count ; i ++) {
        if ([collectDataArray[i] isEqualToString:@""]) {
            NSMutableArray *ary = [NSMutableArray array];
            [ary addObjectsFromArray:collectDataArray];
            [ary removeObjectAtIndex:i];
            collectDataArray = ary;

        }
    }
    _collectDataArray = collectDataArray;
    [self CustomBlock];
}

-(void)setSelectSection:(NSInteger)selectSection
{
    _selectSection = selectSection;
}


#pragma mark -- Collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_isDetails == YES) {
        return _collectDataArray.count;
    }
    return _collectDataArray.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_isDetails == YES) {
        PhotoCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"PhotoCollCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        
        if ([_name containsString:@"视频"] == YES) {
            cell.image.image = [self firstFrameWithVideoURL:_collectDataArray[indexPath.row] size:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        }
        else
        {
            [cell.image sd_setImageWithURL:[NSURL URLWithString:[_collectDataArray[indexPath.row] convertImageUrl]]];
        }
        [cell.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.selectButton.tag = indexPath.row + 1000;
        if (_isDetails == YES) {
            cell.selectButton.hidden = YES;
        }else
        {
            cell.selectButton.hidden = NO;
        }
        return cell;
    }
    if (indexPath.row == 0) {
        AddPhotoCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"AddPhotoCollCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
    PhotoCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"PhotoCollCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    if ([_name containsString:@"视频"] == YES) {
        cell.image.image = [self firstFrameWithVideoURL:_collectDataArray[indexPath.row - 1] size:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    else
    {
        [cell.image sd_setImageWithURL:[NSURL URLWithString:[_collectDataArray[indexPath.row - 1] convertImageUrl]]];
    }
    [cell.selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.selectButton.tag = indexPath.row - 1 + 1000;
    return cell;
}

-(void)setIsDetails:(BOOL)isDetails
{
    _isDetails = isDetails;
    [self.collectionView reloadData];
}


#pragma mark -- Collection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_isDetails == YES) {
        if ([_name containsString:@"视频"] == YES) {
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            // 3、配置媒体播放控制器
            AVPlayerViewController *_playerViewController = [[AVPlayerViewController alloc]  init];
            // 设置媒体源数据
            NSString*  urlStr = [NSString stringWithFormat:@"%@",self.collectDataArray[indexPath.row]];
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
        else
            
        {
            NSMutableArray *imageArray = [NSMutableArray array];
            for (int i = 0; i < self.collectDataArray.count; i ++) {
                [imageArray addObject:[_collectDataArray[i] convertImageUrl]];
            }
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:indexPath.row  imagesBlock:^NSArray *{
                return imageArray;
            }];
        }
    }else
    {
        if (indexPath.row == 0) {
            if ([_name containsString:@"视频"] == YES) {
                [self.imagePicker videoPicker];
            }else
            {
                [self.imagePicker picker];
            }
        }
        else
        {
            
            if ([_name containsString:@"视频"] == YES) {
                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                // 3、配置媒体播放控制器
                AVPlayerViewController *_playerViewController = [[AVPlayerViewController alloc]  init];
                // 设置媒体源数据
                NSString*  urlStr = [NSString stringWithFormat:@"%@",self.collectDataArray[indexPath.row-1]];
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
            else
                
            {
                NSMutableArray *imageArray = [NSMutableArray array];
                for (int i = 0; i < self.collectDataArray.count; i ++) {
                    [imageArray addObject:[_collectDataArray[i] convertImageUrl]];
                }
                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:indexPath.row - 1 imagesBlock:^NSArray *{
                    return imageArray;
                }];
            }
        }
    }
}



#pragma mark ---- 获取图片第一帧
- (UIImage *)firstFrameWithVideoURL:(NSString *)urlStr size:(CGSize)size
{
    
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
    // 获取视频第一帧
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];\
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:urlAsset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return thumb;
}

-(void)selectButtonClick:(UIButton *)sender
{
    NSMutableArray *ary = [NSMutableArray array];
    [ary addObjectsFromArray:self.collectDataArray];
    [ary removeObjectAtIndex:sender.tag - 1000];
    self.collectDataArray = ary;
    [self.collectionView reloadData];
    self.returnAryBlock(self.collectDataArray, _name, _selectSection);
    [self CustomBlock];
}


@end
