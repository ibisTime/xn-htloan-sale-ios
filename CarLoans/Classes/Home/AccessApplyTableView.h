//
//  AccessApplyTableView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN



@protocol AccessApplyDelegate <NSObject>

-(void)selectButtonClick:(NSInteger)index;

@end

@interface AccessApplyTableView : TLTableView

@property (nonatomic, assign) id <AccessApplyDelegate> selectDelegate;

@property (nonatomic , strong)NSMutableArray <SurveyModel *>*model;

@end


NS_ASSUME_NONNULL_END
