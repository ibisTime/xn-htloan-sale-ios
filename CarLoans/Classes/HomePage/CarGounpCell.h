//
//  CarGounpCell.h
//  CarLoans
//
//  Created by shaojianfei on 2018/10/11.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
#import <Masonry.h>
#import <AVKit/AVKit.h>
@protocol CarSettledUpdataPhotoDelegate <NSObject>

-(void)CarSettledUpdataPhotoBtn:(UIButton *)sender selectStr:(NSString *)Str;

@end
@protocol CustomCollectionDelegate1 <NSObject>

- (void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString*)str;

-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str;

@end
@interface CarGounpCell : UITableViewCell
@property (nonatomic , copy)NSString *selectStr;
@property (nonatomic , copy)NSString *photoStr;
@property (nonatomic , copy)NSString *photoimg;
@property (nonatomic, assign) id<CustomCollectionDelegate1> delegate;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *collectDataArray;
@property (nonatomic, assign) id <CarSettledUpdataPhotoDelegate> IdCardDelegate;

@property (nonatomic , strong)UIButton *photoBtn;
@end
