//
//  SettlementAuditCell.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/24.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettlementAuditCell : UITableViewCell
@property (nonatomic , strong)SettlementAuditModel *settlementAuditModel;

@property (nonatomic , strong)UIButton *button;

@property (nonatomic , strong)UILabel *codeLabel;

@property (nonatomic , strong)UILabel *stateLabel;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)UILabel *InformationLabel;
@end

NS_ASSUME_NONNULL_END
