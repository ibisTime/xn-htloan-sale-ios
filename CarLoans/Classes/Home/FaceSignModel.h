//
//  FaceSignModel.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FaceSignModel : NSObject

@property (nonatomic , copy)NSString *code;

@property (nonatomic , copy)NSString *curNodeCode;

@property (nonatomic , copy)NSString *bizType;

@property (nonatomic , copy)NSString *applyUserName;

@property (nonatomic , assign)CGFloat loanAmount;

@property (nonatomic , copy)NSString *loanBankName;

@property (nonatomic , copy)NSString *applyDatetime;

@property (nonatomic , copy)NSString *intevCurNodeCode;

@end
