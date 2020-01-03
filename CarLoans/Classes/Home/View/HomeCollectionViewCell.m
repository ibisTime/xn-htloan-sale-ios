//
//  HomeCollectionViewCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = kWhiteColor;
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3/2 - 18, 25.5, 36, 36)];
        [self addSubview:iconImg];
        self.iconImg = iconImg;
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, iconImg.yy + 6, SCREEN_WIDTH/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#333333")];
        [self addSubview:nameLbl];
        self.nameLbl = nameLbl;
        

        
    }
    return self;
}


@end
