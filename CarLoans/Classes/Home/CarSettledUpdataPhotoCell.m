//
//  CarSettledUpdataPhotoCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarSettledUpdataPhotoCell.h"

@implementation CarSettledUpdataPhotoCell
{
    NSString *Str;
    UIImageView *_photoImg;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _photoBtn = [UIButton buttonWithTitle:@"" titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
        _photoBtn.frame = CGRectMake(15 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3);
        _photoBtn.userInteractionEnabled = YES;
        kViewBorderRadius(_photoBtn, 5, 1, HGColor(230, 230, 230));

        [_photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_photoBtn];


        UIImageView *photoImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3)];
        _photoImg = photoImg;
        [_photoBtn addSubview:photoImg];




    }
    return self;
}

-(void)setPhotoimg:(NSString *)photoimg
{
    if ([BaseModel isBlankString:photoimg] == NO) {
        [_photoImg sd_setImageWithURL:[NSURL URLWithString:[photoimg convertImageUrl]]];
        UIButton *btn = [UIButton buttonWithTitle:@"更换照片" titleColor:kWhiteColor backgroundColor:kClearColor titleFont:17];
        
        btn.frame = CGRectMake(15 , 0, (SCREEN_WIDTH - 40)/2, SCREEN_WIDTH/3);
        [_photoBtn addSubview:btn];
        
        [btn addTarget:self action:@selector(change:) forControlEvents:UIControlEventTouchUpInside];
    }
    
   
}


- (void)change: (UIButton *)btn
{
    [_IdCardDelegate CarSettledUpdataPhotoBtn:(UIButton*)btn.superview selectStr:Str];
    
}

-(void)setSelectStr:(NSString *)selectStr
{
    Str = selectStr;
}

-(void)setPhotoStr:(NSString *)photoStr
{
    [_photoBtn setTitle:photoStr forState:(UIControlStateNormal)];
    [_photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
        [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
    }];

}

-(void)photoBtnClick:(UIButton *)sender
{
    [_IdCardDelegate CarSettledUpdataPhotoBtn:sender selectStr:Str];
}

@end
