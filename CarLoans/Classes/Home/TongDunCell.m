//
//  TongDunCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TongDunCell.h"

@implementation TongDunCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSLog(@"%f",self.xx);
        NSLog(@"%f",self.width);
        NSLog(@"%f",SCREEN_WIDTH);
        UILabel * label = [UILabel labelWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 60) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        label.numberOfLines = 0;
        self.label = label;
        [self.contentView addSubview:label];
    }
    return self;
}
-(void)setType:(NSString *)type{
    _type = type;
}
-(void)setTitle:(NSString *)title{
    if ([_type isEqualToString:@"details"]) {
        self.label.frame = CGRectMake(10, 0, SCREEN_WIDTH-107 - 20, 60);
    }
    self.label.text = title;
    
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
