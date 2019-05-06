//
//  TaskCell.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TaskDelegate <NSObject>

-(void)SurveyTaskSelectButton:(UIButton *)sender;

@end
@interface TaskCell : UITableViewCell
@property (nonatomic, assign) id <TaskDelegate> delegate;



@property (nonatomic , strong)NSArray *TaskArray;

@property (nonatomic , copy)NSString *Taskname;

@property (nonatomic , copy)NSString *TaskUser;

@property (nonatomic , copy)NSString *TaskCreateTime;

@property (nonatomic , copy)NSString *TaskTime;

@property (nonatomic , strong)UILabel *nameLbl;

@property (nonatomic , strong)UIButton *photoBtn;

@property (nonatomic , strong)UIImageView *photoImage;

@property (nonatomic , copy)NSString *btnStr;

@property (nonatomic , copy)NSString *name;
@end

NS_ASSUME_NONNULL_END