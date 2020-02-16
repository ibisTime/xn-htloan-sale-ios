//
//  DeleteGPSCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2020/2/16.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "DeleteGPSCell.h"

@implementation DeleteGPSCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        

        UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 70, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
        _nameLabel = nameLabel;
        [self addSubview:nameLabel];
        
        self.selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.selectButton.frame = self.selectButton.frame = CGRectMake(SCREEN_WIDTH - 45, 10, 30, 30);
        [self.selectButton setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
        
        [self addSubview:self.selectButton];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
