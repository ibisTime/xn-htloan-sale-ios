//
//  AddPhotoCollCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AddPhotoCollCell.h"

@implementation AddPhotoCollCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectZero];
        img.image = kImage(@"资料上传");
        [self addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_offset(0);
        }];
    }
    return self;
}

@end
