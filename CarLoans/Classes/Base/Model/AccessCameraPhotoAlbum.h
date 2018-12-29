//
//  AccessCameraPhotoAlbum.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/19.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AccessCameraPhotoAlbumDelegate <NSObject>

-(void)AccessCameraPhotoAlbumImage:(UIImage *)image typeStr:(NSString *)type;

@end

@interface AccessCameraPhotoAlbum : NSObject

@property (nonatomic, assign) id <AccessCameraPhotoAlbumDelegate> PhotoDelegate;

-(void)AccessCameraPhotoAlbumMethods;

@end
