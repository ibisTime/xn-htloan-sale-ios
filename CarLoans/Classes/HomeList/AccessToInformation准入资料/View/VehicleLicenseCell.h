//
//  VehicleLicenseCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/17.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLImagePicker.h"
typedef void (^ReturnPhotoAryBlock)(NSArray *imgAry,NSString *name,NSInteger section);

NS_ASSUME_NONNULL_BEGIN

@interface VehicleLicenseCell : UITableViewCell
@property (nonatomic , strong)TLImagePicker *imagePicker;

@property (nonatomic, copy) ReturnPhotoAryBlock returnAryBlock;

@property (nonatomic , assign)BOOL isDetails;
//图片数组
@property (nonatomic,strong)NSArray *collectDataArray;
@end

NS_ASSUME_NONNULL_END
