//
//  GPSCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/23.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "GPSCell.h"

@implementation GPSCell

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
        for (int i = 0; i < 2; i ++) {
            
                UILabel * label = [UILabel labelWithFrame:CGRectMake(15 + (i) * ((SCREEN_WIDTH -30) / 2), 0, ((SCREEN_WIDTH-30) / 2), 49) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kTextColor];
                label.tag = 10000 + i;
                //                kViewBorderRadius(label, 1, 1, kLineColor);
                [self addSubview:label];
            }
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(10, 49, SCREEN_WIDTH - 20, 1)];
        view.backgroundColor = kLineColor;
        [self addSubview:view];
    }
    return self;
}
-(void)setRightarray:(NSArray *)rightarray{
    for (int j = 0; j < rightarray.count; j ++) {
        UILabel * label = [self viewWithTag:10000 + j];
        label.text = rightarray[j];
    }
}

@end
