//
//  AdmiissionDetailsIDCardCellCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmiissionDetailsIDCardCellCell.h"

@implementation AdmiissionDetailsIDCardCellCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *topLbl = [UILabel labelWithFrame:CGRectMake(15, 23, SCREEN_WIDTH - 107 - 30, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(11) textColor:kHexColor(@"#999999")];
        self.topLbl = topLbl;
        topLbl.text = @"身份证";
        [self addSubview:topLbl];
        
        for (int i = 0; i < 2; i ++) {
            UIButton *cardImg = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [cardImg setBackgroundImage:kImage(@"默认") forState:(UIControlStateNormal)];
            cardImg.frame = CGRectMake(15 + i % 2 * ((SCREEN_WIDTH - 107 - 40)/2 + 10) , 47, (SCREEN_WIDTH - 107 - 40)/2, (SCREEN_WIDTH - 107 - 40)/2/210*133);
            [self addSubview:cardImg];
        }
        
    }
    return self;
}

@end
