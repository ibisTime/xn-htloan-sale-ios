//
//  SecondReportCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "SecondReportCell.h"

@implementation SecondReportCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 50, SCREEN_WIDTH-30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        label.numberOfLines = 0;
        [label setTextColor:MainColor];
        label.tag = 9999;
        [self addSubview:label];
    }
    return self;
}

-(void)setSecondreport:(NSString *)secondreport{
    UILabel * label = [self viewWithTag:9999];
    label.text = secondreport;
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
