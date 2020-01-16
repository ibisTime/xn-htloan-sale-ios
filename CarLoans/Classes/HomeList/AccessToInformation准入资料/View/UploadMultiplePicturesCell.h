//
//  UploadMultiplePicturesCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLImagePicker.h"
@protocol UploadMultiplePicturesDelegate <NSObject>

-(void)UploadMultiplePicturesDelegatePics:(NSArray *)pics;

@end

NS_ASSUME_NONNULL_BEGIN

typedef void (^ReturnPhotoAryBlock)(NSArray *imgAry,NSString *name,NSInteger section);

@interface UploadMultiplePicturesCell : UITableViewCell
@property (nonatomic , assign)BOOL isDetails;
@property (nonatomic, assign) id<UploadMultiplePicturesDelegate> delegate;

@property (nonatomic, copy) ReturnPhotoAryBlock returnAryBlock;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UILabel *nameLbl;
@property (nonatomic , copy)NSString *name;

@property (nonatomic,strong)TLImagePicker *imagePicker;

@property (nonatomic , assign)BOOL isSingle;

@property (nonatomic , assign)NSInteger selectSection;
//图片数组
@property (nonatomic,strong)NSArray *collectDataArray;

@end

NS_ASSUME_NONNULL_END
