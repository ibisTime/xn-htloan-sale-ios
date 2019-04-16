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
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3/2 - 18, SCREEN_WIDTH/3/2 - 18 - 19, 36, 36)];
        [self addSubview:iconImg];
        self.iconImg = iconImg;
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, iconImg.yy + 7, SCREEN_WIDTH/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#333333")];
        [self addSubview:nameLbl];
        self.nameLbl = nameLbl;
        
        UILabel *permissionsLbl = [UILabel labelWithFrame:CGRectMake(0, nameLbl.yy, SCREEN_WIDTH/3, 14) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(10) textColor:kHexColor(@"#999999")];
        [self addSubview:permissionsLbl];
        self.permissionsLbl = permissionsLbl;
        
    }
    return self;
}


@end
