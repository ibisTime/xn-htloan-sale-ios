//
//  BrandTableViewCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BrandTableViewCell.h"

@implementation BrandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
        self.logo.contentMode =UIViewContentModeScaleAspectFill;
        [self addSubview:self.logo];
        
        
        self.namelab = [UILabel labelWithFrame:CGRectMake(55, 20, SCREEN_WIDTH - 55 - 15, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
        [self addSubview:self.namelab];
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 54, SCREEN_WIDTH - 45, 1)];
        v1.backgroundColor = kLineColor;
        [self addSubview:v1];
    }
    return self;
}
@end
