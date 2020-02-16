//
//  ChooseCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ChooseCell.h"

@implementation ChooseCell

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, 100, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _nameLabel;
}

-(UIImageView *)xiaImage
{
    if (!_xiaImage) {
//        _xiaImage = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 7, 19, 7, 12)];
//        _xiaImage.image = HGImage(@"下拉");
    }
    return _xiaImage;
}

-(UILabel *)detailsLabel
{
    if (!_detailsLabel) {
        _detailsLabel = [UILabel labelWithFrame:CGRectMake(115, 0, SCREEN_WIDTH - 155, 50) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _detailsLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailsLabel];
        [self addSubview:self.xiaImage];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
        self.lineView = lineView;
    }
    return self;
}

-(void)setName:(NSString *)name
{
    _nameLabel.text = name;
    _nameLabel.frame = CGRectMake(15, 0, 100, 50);
    [_nameLabel sizeToFit];
    _nameLabel.frame = CGRectMake(15, 0, _nameLabel.width, 50);
    _detailsLabel.frame = CGRectMake(_nameLabel.xx, 0, SCREEN_WIDTH - 55 - _nameLabel.width, 50);
}

-(void)setDetails:(NSString *)details
{
    _detailsLabel.text = details;
}

-(void)setText:(NSString *)text{
    NSArray * array = [text componentsSeparatedByString:@"\n"];
    _detailsLabel.text = text;
    _detailsLabel.numberOfLines = 0;
    [_detailsLabel sizeToFit];
    _detailsLabel.frame = CGRectMake(115, 0, SCREEN_WIDTH - 155, 28 * (array.count + 1));
    
    _nameLabel.frame = CGRectMake(15, 0,_nameLabel.width, 28 * (array.count + 1));
    
    _xiaImage.frame = CGRectMake(SCREEN_WIDTH - 15 - 7, _detailsLabel.height / 2 - 12, 7, 12);
    
    _lineView.frame = CGRectMake(0, _detailsLabel.height - 1, SCREEN_WIDTH, 1);
}

@end
