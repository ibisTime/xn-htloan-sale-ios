//
//  RepaymentPlanCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsRepaymentPlanCell.h"

@implementation AdmissionDetailsRepaymentPlanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH/2 - 15, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#333333")];
        nameLbl.text = @"第一期";
        [self addSubview:nameLbl];
        
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(15, nameLbl.yy + 4, SCREEN_WIDTH/2 - 15, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        timeLbl.text = @"2018.04.05";
        [self addSubview:timeLbl];
        
        UILabel *priceLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2 - 15, 67) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
        NSString *price = @"800.26元";
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:price];
        [attrString addAttribute:NSFontAttributeName value:Font(10) range:NSMakeRange(price.length - 1,1)];
        priceLbl.attributedText = attrString;
        [self addSubview:priceLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 66, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
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
