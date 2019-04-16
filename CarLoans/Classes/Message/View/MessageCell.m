//
//  MessageCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
        nameLbl.text = @"车贷B端系统正式上线";
        [self addSubview:nameLbl];
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(15, 45.5, 150, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        timeLbl.text = @"2019-10-10 20:00:00";
        [self addSubview:timeLbl];
        
        UILabel *typeLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 165, 45.5, 150, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        typeLbl.text = @"系统公告";
        [self addSubview:typeLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 76.5, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}

@end
