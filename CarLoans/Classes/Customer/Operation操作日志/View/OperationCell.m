//
//  OperationCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "OperationCell.h"

@implementation OperationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *array = @[@"发起征信",@"业务开始第一步，发起征信",@"操作人：张三",@"操作时间：2019-10-10 10:20:00"];
        for (int i = 0; i < 4; i ++) {
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 12.5 + i % 4 * 35, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
            nameLbl.text = array[i];
            [self addSubview:nameLbl];
        }
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 152.5, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = kBackgroundColor;
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
