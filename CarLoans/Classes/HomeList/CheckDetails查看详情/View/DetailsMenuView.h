//
//  DetailsMenuView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MenuDelegate <NSObject>

-(void)MenuSelectTag:(NSInteger)tag;

@end
NS_ASSUME_NONNULL_BEGIN

@interface DetailsMenuView : UIView
@property (nonatomic, assign) id <MenuDelegate> delegate;
@property (nonatomic , strong)SurveyModel *model;
@end

NS_ASSUME_NONNULL_END
