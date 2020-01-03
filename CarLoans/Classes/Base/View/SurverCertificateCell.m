//
//  SurverCertificateCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurverCertificateCell.h"

@implementation SurverCertificateCell

-(UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _nameLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLbl];
        [self addSubview:self.photoBtn];

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
    }
    return self;
}

-(void)setName:(NSString *)name
{
    _nameLbl.text = name;
}


-(void)btnClick:(UIButton *)sender
{
    if (_picArray.count == 0) {
        return;
    }
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];

    [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:sender.tag - 10000 imagesBlock:^NSArray *{
        return self.photoArray;
    }];
}
- (void)btnclick1:(UITapGestureRecognizer*)ta
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:ta.view.tag - 10000 imagesBlock:^NSArray *{
        return self.photoArray;
    }];
}
-(void)setPicArray:(NSArray *)picArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < picArray.count; i ++) {
        [array addObject:[picArray[i] convertImageUrl]];
    }
    self.photoArray = array;

    for (int i = 0; i < picArray.count; i ++) {

        UIImageView *photoImage = [[UIImageView alloc]initWithFrame:CGRectMake(15 + i % 3 *  ((SCREEN_WIDTH - 50)/3 + 10), 50 + i / 3 * ((SCREEN_WIDTH - 50)/3 + 10), (SCREEN_WIDTH - 50)/3, (SCREEN_WIDTH - 50)/3)];
        [photoImage sd_setImageWithURL:[NSURL URLWithString:[picArray[i] convertImageUrl]]];
        photoImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnclick1:)];
        [photoImage addGestureRecognizer:tap];
        [self addSubview:photoImage];

        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = photoImage.frame;
        [button addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 10000 + i;
        [self addSubview:button];

    }
}

@end
