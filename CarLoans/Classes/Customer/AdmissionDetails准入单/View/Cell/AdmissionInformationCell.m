//
//  AdmissionInformationCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionInformationCell.h"

@implementation AdmissionInformationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *topLbl = [UILabel labelWithFrame:CGRectMake(15, 23, SCREEN_WIDTH - 107 - 30, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(11) textColor:kHexColor(@"#999999")];
        self.topLbl = topLbl;
        [self addSubview:topLbl];
        
        UILabel *bottomLbl = [UILabel labelWithFrame:CGRectMake(15, 39, SCREEN_WIDTH - 137, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#333333")];
        self.bottomLbl = bottomLbl;
        [self addSubview:bottomLbl];
    }
    return self;
}


@end
