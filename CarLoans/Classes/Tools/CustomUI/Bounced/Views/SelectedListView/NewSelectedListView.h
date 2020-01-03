//
//  NewSelectedListView.h
//  CarLoans
//
//  Created by shaojianfei on 2018/12/21.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectedListModel.h"

@interface NewSelectedListView : UITableView
@property (nonatomic , strong ) NSArray<SelectedListModel *>* array;
/**
 已选中Block
 */
@property (nonatomic , copy ) void (^selectedBlock)(NSArray <SelectedListModel *>*);

/**
 选择改变Block (多选情况 当选择改变时调用)
 */
@property (nonatomic , copy ) void (^changedBlock)(NSArray <SelectedListModel *>*);

/**
 是否单选
 */
@property (nonatomic , assign ) BOOL isSingle;

/**
 完成选择 (多选会调用selectedBlock回调所选结果)
 */
- (void)finish;
@end
