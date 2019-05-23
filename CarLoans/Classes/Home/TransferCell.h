//
//  TransferCell.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/8.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataTransferModel.h"
#import "CadListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TransferCell : UITableViewCell
@property (nonatomic , strong)UIButton *button;

@property (nonatomic , strong)UILabel *codeLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *InformationLabel;

@property (nonatomic , strong)UIView *lineView;

@property (nonatomic , strong)DataTransferModel *dataTransferModel;
@property (nonatomic , strong)DataTransferModel *gpsmodel;
@end

NS_ASSUME_NONNULL_END
