//
//  SelectedCell.m
//  CarLoans
//
//  Created by shaojianfei on 2018/12/24.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SelectedCell.h"

@implementation SelectedCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(45, 0, self.contentView.bounds.size.width-90, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:[UIColor blackColor]];
        _nameLabel.numberOfLines = 2;
    }
    return _nameLabel;
}

-(void)setModle:(SelectedListModel *)modle
{
    _modle = modle;
    self.nameLabel.text = modle.title;
    
}
@end
