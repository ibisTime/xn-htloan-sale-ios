//
//  NewLenderTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnPhotoAryBlock)(NSString *idFront,NSDictionary *idFrontDic,NSString *idReverse,NSDictionary *idReverseDic,NSString *holdIdCardPdf);

@interface NewLenderTableView : TLTableView
@property (nonatomic , strong)NSDictionary *dataDic;
@property (nonatomic, copy) ReturnPhotoAryBlock returnAryBlock;
@property (nonatomic , strong)NSString *idFront;
@property (nonatomic , strong)NSString *idReverse;
@property (nonatomic , strong)NSDictionary *idFrontDic;
@property (nonatomic , strong)NSDictionary *idReverseDic;
@property (nonatomic , strong)NSString *holdIdCardPdf;
@property (nonatomic , strong)NSString *bankCreditResult;
@property (nonatomic , assign)BOOL isDetails;
@end

NS_ASSUME_NONNULL_END
