//
//  AddPeopleCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/21.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AddPeopleCell.h"

@implementation AddPeopleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        _photoBtn = [UIButton buttonWithTitle:@"" titleColor:[UIColor blackColor] backgroundColor:BackColor titleFont:13];
        _photoBtn.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 135);
        [_photoBtn setTitleColor:GaryTextColor forState:(UIControlStateNormal)];
        _photoBtn.tag = 102;
        kViewBorderRadius(_photoBtn, 5, 1, HGColor(230, 230, 230));
        
        [_photoBtn setTitle:@"添加征信人" forState:(UIControlStateNormal)];
        [_photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        }];
        [self addSubview:_photoBtn];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
