//
//  PhotoCollCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "PhotoCollCell.h"

@implementation PhotoCollCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *image = [[UIImageView alloc]init];
        image.contentMode = UIViewContentModeScaleAspectFit;
        _image = image;
        kViewBorderRadius(image, 5, 1, HGColor(230, 230, 230));
        [self addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.mas_offset(0);
        }];
        
        UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        selectButton.frame = CGRectMake(self.width - 40, 0, 40, 40);
        _selectButton = selectButton;
        [selectButton setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
        [self addSubview:selectButton];
        
        [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.mas_offset(0);
            make.width.height.mas_equalTo(40);
        }];
    }
    return self;
}

@end
