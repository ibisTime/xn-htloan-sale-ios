//
//  JoinLiveController.h
//  CarLoans
//
//  Created by shaojianfei on 2018/12/4.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
//#import <ILiveSDK/ILiveCoreHeader.h>

@interface JoinLiveController : BaseViewController
@property (nonatomic, assign) long long chinaID;
@property (nonatomic , copy)void (^curreryBlock)(NSString* roomID);
@property (nonatomic, copy) NSString* roomId;

@end
