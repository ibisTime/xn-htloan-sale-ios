//
//  MenuTableView9.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
typedef void (^ReturnPhotoAryBlock)(NSArray *imgAry,NSString *name,NSInteger section);

NS_ASSUME_NONNULL_BEGIN

@interface MenuTableView9 : TLTableView
@property (nonatomic, copy) ReturnPhotoAryBlock returnAryBlock;
@property (nonatomic , strong)NSArray *carHead;
@property (nonatomic , strong)NSArray *carRegisterCertificateFirst;
@property (nonatomic , strong)NSArray *policy;
@property (nonatomic , strong)NSArray *carInvoice;

@property (nonatomic , assign)BOOL isDetails;

@end

NS_ASSUME_NONNULL_END
