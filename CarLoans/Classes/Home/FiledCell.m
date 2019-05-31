//
//  FiledCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/31.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "FiledCell.h"

@implementation FiledCell

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
        UILabel  *label = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kLineColor font:Font(12) textColor:kBlackColor];
        label.numberOfLines = 2;
        label.tag = 1001;
        [self addSubview:label];
    }
    return self;
}

-(void)setFiledname:(NSString *)filedname{
    UILabel  *label = [self viewWithTag:1001];
    label.text = filedname;
}
@end
