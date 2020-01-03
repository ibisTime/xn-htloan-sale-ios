//
//  ToApplyForRightTableView9.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ReturnAryBlock)(NSArray *imgAry,NSString *name);
@interface ToApplyForRightTableView9 : TLTableView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)SurveyModel *model;
@property (nonatomic , strong)NSArray *WaterArray;
@property (nonatomic, copy) ReturnAryBlock returnAryBlock;
@property (nonatomic , strong)NSArray * AgentFontPic;
@property (nonatomic , strong)NSArray * AgentReversePic;
@property (nonatomic, assign) UIType type;
@end

NS_ASSUME_NONNULL_END
