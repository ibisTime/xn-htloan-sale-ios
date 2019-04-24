//
//  AdmissionDetailsCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsCell.h"

@implementation AdmissionDetailsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, 107 - 15, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(11) textColor:kHexColor(@"#666666")];
        self.nameLbl = nameLbl;
        [self addSubview:nameLbl];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    self.highlighted = selected;
    if (selected == YES)
    {
        self.backgroundColor = kHexColor(@"#E0EEFA");
        self.nameLbl.textColor = kAppCustomMainColor;
    }else
    {
        self.backgroundColor = kBackgroundColor;
        self.nameLbl.textColor = kHexColor(@"#666666");
    }
    // Configure the view for the selected state
}

@end
