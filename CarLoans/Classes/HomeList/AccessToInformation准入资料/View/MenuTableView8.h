//
//  MenuTableView8.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnPhotoAryBlock)(NSArray *imgAry,NSString *name,NSInteger section);


@interface MenuTableView8 : TLTableView

@property (nonatomic, copy) ReturnPhotoAryBlock returnAryBlock;
@property (nonatomic , assign)BOOL isDetails;
@property (nonatomic , strong)NSArray *doorPdf;
@property (nonatomic , strong)NSArray *groupPhoto;
@property (nonatomic , strong)NSArray *houseVideo;

@end

NS_ASSUME_NONNULL_END
