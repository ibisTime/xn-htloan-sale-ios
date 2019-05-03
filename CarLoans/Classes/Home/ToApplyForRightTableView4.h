//
//  ToApplyForRightTableView4.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnAryBlock)(NSArray *imgAry,NSString *name);
@interface ToApplyForRightTableView4 : TLTableView
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic, copy) ReturnAryBlock returnAryBlock;
// 户口本资料
@property (nonatomic , strong)NSArray *hkBookPdf;
// 结婚证资料
@property (nonatomic , strong)NSArray *marryPdf;
// 购房合同
@property (nonatomic , strong)NSArray *houseContract;
// 购房发票
@property (nonatomic , strong)NSArray *houseInvoice;
// 居住证明
@property (nonatomic , strong)NSArray *liveProvePdf;
// 自建房证明
@property (nonatomic , strong)NSArray *buildProvePdf;
// 家访照片
@property (nonatomic , strong)NSArray *housePictureApply;
@end

NS_ASSUME_NONNULL_END
