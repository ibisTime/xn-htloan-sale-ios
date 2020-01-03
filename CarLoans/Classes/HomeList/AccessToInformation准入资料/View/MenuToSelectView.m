//
//  MenuToSelectView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MenuToSelectView.h"

@implementation MenuToSelectView
{
    UIButton *selectBtn;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        backView.backgroundColor = kHexColor(@"#000000");
        backView.alpha = 0.5;
        [self addSubview:backView];
        
        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        [singleTapGestureRecognizer setNumberOfTapsRequired:1];
        [backView addGestureRecognizer:singleTapGestureRecognizer];
        
        
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 176)];
        whiteView.backgroundColor = kWhiteColor;
        [self addSubview:whiteView];
        
        
        NSArray *ary = [MenuModel new].menuArray;
        for (int i = 0; i < ary.count; i ++) {
            UIButton *menuBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            menuBtn.titleLabel.font = Font(12);
//            UIButton *menuBtn = [UIButton buttonWithTitle:ary[i] titleColor:kHexColor(@"#999999") backgroundColor:kHexColor(@"#F5F5F5") titleFont:12];
            [menuBtn setTitle:ary[i] forState:(UIControlStateNormal)];
            menuBtn.frame = CGRectMake(15 + i % 4 *((SCREEN_WIDTH - 75)/4 + 15), 25 + i / 4 * 47, (SCREEN_WIDTH - 75)/4, 32);
            [menuBtn setTitleColor:kHexColor(@"#999999") forState:(UIControlStateNormal)];
//            [menuBtn setBackgroundColor:kHexColor(@"#F5F5F5") forState:(UIControlStateNormal)];
            menuBtn.backgroundColor = kHexColor(@"#F5F5F5");
            [menuBtn setTitleColor:kWhiteColor forState:(UIControlStateSelected)];
            if (i == 0) {
                menuBtn.selected = YES;
                selectBtn = menuBtn;
                menuBtn.backgroundColor = kHexColor(@"#028EFF");
            }
            [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            menuBtn.tag = i;
            [self addSubview:menuBtn];
        }
    }
    return self;
}

-(void)menuBtnClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    selectBtn.selected = !selectBtn.selected;
    sender.backgroundColor = kHexColor(@"#028EFF");
    if (sender != selectBtn) {
        selectBtn.backgroundColor = kHexColor(@"#F5F5F5");
    }
    selectBtn = sender;
    [_delegate MenuSelectTag:sender.tag];
}


- (void)singleTap:(UIGestureRecognizer*)gestureRecognizer
{
    [_delegate MenuSelectTag:100];
}

@end
