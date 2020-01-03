//
//  MenuToSelectView.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MenuDelegate <NSObject>

-(void)MenuSelectTag:(NSInteger)tag;

@end
NS_ASSUME_NONNULL_BEGIN

@interface MenuToSelectView : UIView
@property (nonatomic, assign) id <MenuDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
