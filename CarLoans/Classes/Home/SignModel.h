//
//  SignModel.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignModel : NSObject
@property (nonatomic,strong) NSString * roomCode;
@property (nonatomic,strong) NSString * streamId;
@property (nonatomic,strong) NSString * fileId;
@property (nonatomic,strong) NSString * videoUrl;
@property (nonatomic,strong) NSString * fileSize;
@property (nonatomic,strong) NSString * startTime;
@property (nonatomic,strong) NSString * endTime;
@property (nonatomic,strong) NSString * fileFormat;
@property (nonatomic,strong) NSString * bizCode;
@end

NS_ASSUME_NONNULL_END
