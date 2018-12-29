//
//  HomeHeadView.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HomeHeadView.h"
#import "UIView+Frame.h"
@implementation HomeHeadView

-(UIImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 70, 70)];
        _headImage.image = HGImage(@"默认头像");
    }
    return _headImage;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(95+20, 40, SCREEN_WIDTH - 110, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(18) textColor:[UIColor whiteColor]];

    }
    return _nameLabel;
}

-(UIButton *)bgView
{
    if (!_bgView) {
        _bgView = [UIButton buttonWithType:UIButtonTypeCustom];
        _bgView.frame = CGRectMake(90, 45, 20, 20);
        _bgView.layer.cornerRadius = 10;
        _bgView.clipsToBounds = YES;
        [_bgView.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_bgView setBackgroundColor:[UIColor redColor]];
        _bgView.hidden = YES;


    }
    return _bgView;
}
-(UILabel *)countLable
{
    if (!_countLable) {
        
    
        _countLable = [UILabel labelWithFrame:CGRectMake(95+ 100+ 110, 40, SCREEN_WIDTH - 110, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(18) textColor:[UIColor whiteColor]];
        
    }
    return _countLable;
}
-(UILabel *)introduceLabel
{
    if (!_introduceLabel) {
        _introduceLabel = [UILabel labelWithFrame:CGRectMake(95+20, 70, SCREEN_WIDTH - 110, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:[UIColor whiteColor]];

        NSLog(@"%@",[USERDEFAULTS objectForKey:USERDATA]);
    }
    return _introduceLabel;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {

        UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
        backImage.image = HGImage(@"背景");
        [self addSubview:backImage];

        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.bgView];

        [self addSubview:self.introduceLabel];
//        [self addSubview:self.countLable];
    }
    return self;
}

-(void)setDic:(NSDictionary *)dic
{

    NSString *remark;
    if (dic[@"postName"]) {
        if ([BaseModel isBlankString:dic[@"postName"]] == YES) {
            remark = @"[其他]";
        }
        else
        {
            remark = [NSString stringWithFormat:@"[%@]",dic[@"postName"]];
            
        }
        NSString *needText = [NSString stringWithFormat:@"%@ %@",[BaseModel convertNull:dic[@"loginName"]],remark];
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:needText];
        [attrString addAttribute:NSFontAttributeName value:HGfont(11) range:NSMakeRange(needText.length - remark.length,remark.length)];
        _nameLabel.attributedText = attrString;
        _introduceLabel.text = [BaseModel convertNull:dic[@"companyName"]];
    }else{
        long  text1 = [dic[@"creditTodo"] integerValue] ;
        long  text2 = [dic[@"interviewTodo"] integerValue];
        long  text3 = [dic[@"gpsInstallTodo"] integerValue];
        long  text4 = [dic[@"carSettleTodo"] integerValue];
        long  text5 = [dic[@"entryMortgageTodo"] integerValue];
        long  text6 = [dic[@"logisticsTodo"] integerValue];
        if (text1+text2+text3+text4+text5+text6 == 0) {
            _countLable.hidden = YES;
            _bgView.hidden = YES;
        }else{
            _countLable.hidden = YES;
            _bgView.hidden = NO;
           NSString *text = [NSString stringWithFormat:@"%ld",text1+text2+text3+text4+text5+text6];
            [_bgView setTitle:text forState:UIControlStateNormal];
            
        }
        
    }
    
    
}

@end
