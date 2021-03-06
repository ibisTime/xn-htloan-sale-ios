//
//  CadListModel.h
//  CarLoans
//
//  Created by shaojianfei on 2018/9/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CadListModel : NSObject

@property (nonatomic ,copy) NSString *number;

@property (nonatomic ,copy) NSString *updaterName;

@property (nonatomic ,copy) NSString *ID;

@property (nonatomic ,copy) NSString *no;

@property (nonatomic ,copy) NSString *updateDatetime;

@property (nonatomic ,copy) NSString *vname;
@property (nonatomic ,copy) NSString *name;

@property (nonatomic ,copy) NSString *updater;

@property (nonatomic,strong) NSString * code;

@property (nonatomic,strong) NSString * curNodeCode;

@property (nonatomic,strong) NSString * attachType;
@end
