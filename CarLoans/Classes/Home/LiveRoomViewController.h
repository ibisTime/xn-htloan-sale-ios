//
//  LiveRoomViewController.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/7.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import <ILiveSDK/ILiveCoreHeader.h>


@interface LiveRoomViewController : BaseViewController<ILiveMemStatusListener, ILiveRoomDisconnectListener>
@property (nonatomic, assign) long long chinaID;
@property (nonatomic , copy)void (^curreryBlock)(NSString* roomID);
@property (nonatomic, copy) NSString* roomId;
@property (nonatomic , strong) NSNumber *num;
@property (nonatomic, copy) NSString* faceStr;
@property (nonatomic, assign) BOOL isjoin;


@end
