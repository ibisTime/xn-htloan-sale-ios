//
//  IdCardModel.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IdCardFrontModel : NSObject
@property (nonatomic,copy) NSString * birthAddress;
@property (nonatomic,copy) NSString * customerBirth;
@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString * nation;
@property (nonatomic,copy) NSString * idNo;
@property (nonatomic,copy) NSString * gender;
@property (nonatomic,copy) NSString * success;

@end

NS_ASSUME_NONNULL_END
