//
//  InstructionsCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "InstructionsCell.h"

@implementation InstructionsCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 12.5, SCREEN_WIDTH - 20, 100)];
        _textView = textView;
        [self addSubview:textView];
        
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"请输入内容";
        _placeHolderLabel = placeHolderLabel;
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = [UIColor lightGrayColor];
        [placeHolderLabel sizeToFit];
        [textView addSubview:placeHolderLabel];
        
        textView.font = [UIFont systemFontOfSize:12.f];
        placeHolderLabel.font = [UIFont systemFontOfSize:12.f];
        [textView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 124, SCREEN_WIDTH - 30, 1)];
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
