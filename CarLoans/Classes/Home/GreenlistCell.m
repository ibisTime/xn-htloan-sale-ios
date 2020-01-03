//
//  GreenlistCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "GreenlistCell.h"

@implementation GreenlistCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for (int i = 0; i < 6; i ++) {
            UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 35 * i, 135, 35) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
            label.tag = 1000 + i;
            [self.contentView addSubview:label];
            
            UILabel * label1 = [UILabel labelWithFrame:CGRectMake(150, 35 * i, SCREEN_WIDTH - 160, 35) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
            label1.tag = 2000 + i;
            label1.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:label1];
            
        }
        
        UIButton * button = [UIButton buttonWithTitle:@"已缴纳清收成本" titleColor:MainColor backgroundColor:kWhiteColor titleFont:14 cornerRadius:3];
        [button.titleLabel sizeToFit];
        button.frame = CGRectMake(SCREEN_WIDTH - button.titleLabel.width - 10 - 15, 220, button.titleLabel.width + 10, 50);
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.hidden = YES;
        self.button = button;
        [self.contentView addSubview:button];
    }
    return self;
}



-(void)setRightTitle:(NSArray *)RightTitle{
    for (int i = 0; i < RightTitle.count; i ++) {
        UILabel * label1 = [self viewWithTag:2000 + i];
        label1.text = RightTitle[i];
    }
}

-(void)setLeftTitle:(NSArray *)LeftTitle{
    for (int i = 0; i < LeftTitle.count; i ++) {
        UILabel * label = [self viewWithTag:1000 + i];
        label.text = LeftTitle[i];
    }
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
