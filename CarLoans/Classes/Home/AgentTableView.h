//
//  AgentTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "UploadIdCardCell.h"
NS_ASSUME_NONNULL_BEGIN
@protocol SelectButtonDelegate <NSObject>

-(void)selectButtonClick:(UIButton *)sender;

@end

@interface AgentTableView : TLTableView<UITableViewDataSource,UITableViewDelegate,UploadIdCardDelegate>
@property (nonatomic , strong)AccessSingleModel *model;
@property (nonatomic,weak) id<SelectButtonDelegate> AgentDelegate;
//    身份证正面
@property (nonatomic , copy)NSString *idNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *idNoReverse;
@end

NS_ASSUME_NONNULL_END
