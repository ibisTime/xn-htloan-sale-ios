//
//  FileModel.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/11.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileModel : NSObject
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * bizCode;
@property (nonatomic,copy) NSString * content;
@property (nonatomic,assign) NSInteger * fileCount;
@property (nonatomic,copy) NSString * operatorName;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * depositDateTime;
@end

NS_ASSUME_NONNULL_END
