//
//  CreditDetailsPeopleIDCardCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CreditDetailsPeopleIDCardCell.h"
#import <UIButton+WebCache.h>
#import "ImageBrowserViewController.h"
@implementation CreditDetailsPeopleIDCardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *topLbl = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
        topLbl.text = @"身份证";
        [self addSubview:topLbl];
        NSArray *array = @[@"身份证正面",@"身份证反面"];
        for (int i = 0; i < 2; i ++) {
            UIButton *cardImg = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [cardImg setBackgroundImage:kImage(@"默认") forState:(UIControlStateNormal)];
            cardImg.frame = CGRectMake(15 + i % 2 * ((SCREEN_WIDTH - 45)/2 + 15) , 45, (SCREEN_WIDTH - 45)/2, (SCREEN_WIDTH - 45)/2/300*200);
            cardImg.tag = i + 1000;
            [cardImg addTarget:self action:@selector(cardImgClick:) forControlEvents:(UIControlEventTouchUpInside)];
            kViewRadius(cardImg, 5);
            [self addSubview:cardImg];
            
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15 + i % 2 * ((SCREEN_WIDTH - 45)/2 + 15), cardImg.yy + 10, (SCREEN_WIDTH - 45)/2, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
            nameLbl.text = array[i];
            [self addSubview:nameLbl];
            
        }
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 45 + (SCREEN_WIDTH - 45)/2/300*200 + 26.5 + 14, SCREEN_WIDTH - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}

-(void)cardImgClick:(UIButton *)sender
{
    NSMutableArray *muArray = [NSMutableArray array];
    if (sender.tag == 1000) {
        [muArray addObject:[_dataDic[@"idNoFront"] convertImageUrl]];
    }else
    {
        [muArray addObject:[_dataDic[@"idNoReverse"] convertImageUrl]];
    }

    NSArray *seleteArray = muArray;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
        return seleteArray;
    }];
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    UIButton *button1 =[self viewWithTag:1000];
    UIButton *button2 =[self viewWithTag:1001];
    if (dataDic[@"idNoFront"])
    {
        [button1 sd_setImageWithURL:[NSURL URLWithString:[dataDic[@"idNoFront"] convertImageUrl]] forState:UIControlStateNormal];
    }
    if (dataDic[@"idNoReverse"])
    {
        [button2 sd_setImageWithURL:[NSURL URLWithString:[dataDic[@"idNoReverse"] convertImageUrl]] forState:UIControlStateNormal];
    }
}

@end
