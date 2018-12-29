//
//  SelectedCell.h
//  CarLoans
//
//  Created by shaojianfei on 2018/12/24.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedListModel.h"
@interface SelectedCell : UITableViewCell
@property (nonatomic , copy)NSString *name;

@property (nonatomic , strong)UILabel *nameLabel;

@property (nonatomic , strong)SelectedListModel *modle;

@end
