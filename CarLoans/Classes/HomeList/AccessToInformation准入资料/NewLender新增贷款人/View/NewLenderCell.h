//
//  NewLenderCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLImagePicker.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^ReturnPhotoAryBlock1)(NSString *idFront,NSDictionary *idFrontDic,NSString *idReverse,NSDictionary *idReverseDic,NSString *holdIdCardPdf);

@interface NewLenderCell : UITableViewCell
@property (nonatomic , strong)UILabel *leftLbl;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic, copy) ReturnPhotoAryBlock1 returnAryBlock1;
@property (nonatomic , strong)NSString *idFront;
@property (nonatomic , strong)NSString *idReverse;
@property (nonatomic , strong)NSDictionary *idFrontDic;
@property (nonatomic , strong)NSDictionary *idReverseDic;
@property (nonatomic , strong)NSString *holdIdCardPdf;

@property (nonatomic , assign)BOOL isDetails;

@end

NS_ASSUME_NONNULL_END
