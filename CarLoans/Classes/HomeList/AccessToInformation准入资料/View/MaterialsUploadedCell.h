//
//  MaterialsUploadedCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLImagePicker.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^DataUploadBlock)(NSString *driveCard,NSString *marryPdf,NSString *divorcePdf,NSString *singleProve,NSString *incomeProve,NSString *liveProvePdf,NSString *housePropertyCardPdf);

@interface MaterialsUploadedCell : UITableViewCell
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic, copy) DataUploadBlock dataUploadBlock;
@property (nonatomic , strong)NSString *driveCard;
@property (nonatomic , strong)NSString *marryPdf;
@property (nonatomic , strong)NSString *divorcePdf;
@property (nonatomic , strong)NSString *singleProve;
@property (nonatomic , strong)NSString *incomeProve;

@property (nonatomic , strong)NSString *liveProvePdf;
@property (nonatomic , strong)NSString *housePropertyCardPdf;

@property (nonatomic , assign)BOOL isDetails;
@end

NS_ASSUME_NONNULL_END
