//
//  RepayPlanCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "RepayPlanCell.h"

@implementation RepayPlanCell

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
        for (int i = 0; i < 6; i ++) {
            if (i == 0) {
                UILabel * label = [UILabel labelWithFrame:CGRectMake(0, 0, 30, 50) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kTextColor];
//                kViewBorderRadius(label, 1, 1, kLineColor);
                label.tag = 10000 + i;
                [self addSubview:label];
            }
            else if (i == 1){
                UILabel * label = [UILabel labelWithFrame:CGRectMake(30, 0, 100, 50) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kTextColor];
                label.tag = 10000 + i;
//                kViewBorderRadius(label, 1, 1, kLineColor);
                [self addSubview:label];
            }
            else{
                UILabel * label = [UILabel labelWithFrame:CGRectMake(130 + (i-2) * ((SCREEN_WIDTH - 130) / 4), 0, ((SCREEN_WIDTH-130) / 4), 50) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kTextColor];
                label.tag = 10000 + i;
//                kViewBorderRadius(label, 1, 1, kLineColor);
                [self addSubview:label];
            }
            
        }
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
