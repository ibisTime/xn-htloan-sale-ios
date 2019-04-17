//
//  CustomerDetailsChooseCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CustomerDetailsChooseCell.h"

@implementation CustomerDetailsChooseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *leftLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 50, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
        self.leftLbl = leftLbl;
        [self addSubview:leftLbl];
        
        UIImageView *youImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 24.5,  16.5, 7, 12)];
        youImg.image = kImage(@"跳转");
        [self addSubview:youImg];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor= kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}

@end
