//
//  AttachmentPoolCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AttachmentPoolCell.h"

@implementation AttachmentPoolCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        NSArray *array = @[@"附件类型：主贷人工行征信附件",@"资源类型：图片",@"资源数量：5张",@"创建时间：2019-10-10 20:00:00"];
        for (int i = 0; i < 4; i ++) {
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 12.5 + i % 4 * 35, self.width - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
           
            nameLbl.tag = 1000 +  i;
            [self addSubview:nameLbl];
        }
//
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 152.5, self.width, 10)];
        lineView.backgroundColor = kBackgroundColor;
        [self addSubview:lineView];
    }
    return self;
}
-(void)setArray:(NSArray *)array{
    for (int i = 0; i < 4; i ++) {
        UILabel * label = [self viewWithTag:1000 + i];
//        if (i == 0) {
//            label.numberOfLines = 2;
//            [label sizeToFit];
//            label.frame = CGRectMake(15, 12.5 + i % 4 * 35, self.width - 30, label.height);
//        }
        label.text = array[i];
    }

}
@end
