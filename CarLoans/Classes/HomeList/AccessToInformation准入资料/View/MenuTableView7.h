//
//  MenuTableView7.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^DataUploadBlock)(NSString *driveCard,NSString *marryPdf,NSString *divorcePdf,NSString *singleProve,NSString *incomeProve,NSString *liveProvePdf,NSString *housePropertyCardPdf);
typedef void (^ReturnPhotoAryBlock)(NSArray *imgAry,NSString *name,NSInteger section);


@interface MenuTableView7 : TLTableView
@property (nonatomic, copy) DataUploadBlock dataUploadBlock;

@property (nonatomic, copy) ReturnPhotoAryBlock returnAryBlock;
@property (nonatomic , assign)BOOL isDetails;
@property (nonatomic , strong)NSString *driveCard;
@property (nonatomic , strong)NSString *marryPdf;
@property (nonatomic , strong)NSString *divorcePdf;
@property (nonatomic , strong)NSString *singleProve;
@property (nonatomic , strong)NSString *incomeProve;
@property (nonatomic , strong)NSString *liveProvePdf;
@property (nonatomic , strong)NSString *housePropertyCardPdf;

@property (nonatomic , strong)NSArray *hkBookFirstPage;
@property (nonatomic , strong)NSArray *bankJourFirstPage;
@property (nonatomic , strong)NSArray *zfbJour;
@property (nonatomic , strong)NSArray *wxJour;
@property (nonatomic , strong)NSArray *otherPdf;
@property (nonatomic , strong)NSArray *contractAwardVideo;
@end

NS_ASSUME_NONNULL_END
