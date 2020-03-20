//
//  MenuInputCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MenuInputCell.h"
#import "CheckDetailsVC.h"
#import "AppDelegate.h"
@implementation MenuInputCell
{
    
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *leftLbl = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        _leftLbl = leftLbl;
        [self addSubview:leftLbl];
        [leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(150);
        }];
        
        UITextField *rightTF = [[UITextField alloc]initWithFrame:CGRectZero];
        rightTF.font = HGfont(12);
//        rightTF.backgroundColor = [UIColor redColor];
        rightTF.textAlignment = NSTextAlignmentLeft;
        [rightTF setValue:HGfont(12) forKeyPath:@"_placeholderLabel.font"];
        _rightTF = rightTF;
        rightTF.hidden = YES;
        [self addSubview:rightTF];
        [rightTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(105);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH - 120);
        }];
        
        UILabel *rightLbl = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
        rightLbl.hidden = YES;
        rightLbl.numberOfLines = 2;
        _rightLbl = rightLbl;
//        rightLbl.backgroundColor = [UIColor redColor];
        [self addSubview:rightLbl];
        [rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(105);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH - 120);
        }];
        
        UIImageView *youImg = [[UIImageView alloc]init];
        _youImg = youImg;
        youImg.contentMode = UIViewContentModeScaleAspectFit;
        youImg.image = kImage(@"you");
        youImg.hidden = YES;
        [self addSubview:youImg];
        
        [youImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(5);
        }];
        
        _checkDetailsBtn = [UIButton buttonWithTitle:@"查看详情" titleColor:kAppCustomMainColor backgroundColor:kClearColor titleFont:14];
        [self addSubview:_checkDetailsBtn];
        _checkDetailsBtn.hidden = YES;
        [_checkDetailsBtn addTarget:self action:@selector(_checkDetailsBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [_checkDetailsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(60);
        }];
        
        
        
        _checkDetailsBtn1 = [UIButton buttonWithTitle:@"重新获取" titleColor:kAppCustomMainColor backgroundColor:kClearColor titleFont:14];
        [self addSubview:_checkDetailsBtn1];
        _checkDetailsBtn1.hidden = YES;
        [_checkDetailsBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(60);
        }];
        
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.right.mas_equalTo(-15);
        }];
        
        
        
    }
    return self;
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(void)setModel:(SurveyModel *)model
{
    _model = model;
}

-(void)_checkDetailsBtnClick
{
//    CheckDetailsVC *vc = [CheckDetailsVC new];
////    self.
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    [window.rootViewController.navigationController pushViewController:nav animated:YES];
    
    
    CheckDetailsVC *vc = [[CheckDetailsVC alloc]init];
    vc.model = self.model;
    [[self viewController].navigationController pushViewController:vc animated:YES];
    
}

-(void)setLeftStr:(NSString *)leftStr
{
    
//    if ([leftStr isEqualToString:@"评估报告"]) {
//        _checkDetailsBtn1.hidden = NO;
//        [_rightLbl mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(_checkDetailsBtn1.mas_left).mas_equalTo(-15);
//        }];
//    }else
//    {
//        [_rightLbl mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_left).mas_equalTo(-15);
//        }];
//        _checkDetailsBtn1.hidden = YES;
//    }
    
    if ([leftStr containsString:@"*"]) {
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:leftStr];
        [attriStr addAttribute:NSForegroundColorAttributeName value:kHexColor(@"#F56A6A") range:NSMakeRange(0, 1)];
        _leftLbl.attributedText = attriStr;
    }else
    {
        _leftLbl.text = leftStr;
    }
}

-(void)setPlacStr:(NSString *)placStr
{
    NSString *str = [placStr stringByReplacingOccurrencesOfString:@"*" withString:@""];
    _rightTF.placeholder = str;
}

-(void)setRightStr:(NSString *)rightStr
{
    
    _rightLbl.text = rightStr;
    _rightTF.text = rightStr;
}

-(void)setType:(MenuType)type
{
    _type = type;
    
    _rightTF.hidden = YES;
    _rightLbl.hidden = YES;
    _youImg.hidden = YES;
    _checkDetailsBtn.hidden = YES;
    _checkDetailsBtn1.hidden = YES;
    if (type == MenuInputType) {
        _rightTF.hidden = NO;
        [_rightTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
        }];
        [_rightLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
        }];
    }
    if (type == MenuInputNotEnterType) {
        _rightTF.hidden = NO;
        _rightTF.enabled = NO;
        [_rightTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
        }];
        [_rightLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
        }];
    }
    if (type == MenuShowType) {
        
        _rightLbl.hidden = NO;
        [_rightTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
        }];
        [_rightLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
        }];
    }
    if (type == MenuChooseType) {
        _rightLbl.hidden = NO;
        _youImg.hidden = NO;
        _youImg.image = kImage(@"下拉1");
        [_youImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(8.5);
        }];
        [_rightTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_youImg.mas_left).mas_equalTo(-15);
        }];
        [_rightLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_youImg.mas_left).mas_equalTo(-15);
        }];
    }
    if (type == MenuPushType) {
        _rightLbl.hidden = NO;
        _youImg.hidden = NO;
        _youImg.image = kImage(@"you");
        [_youImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(5);
        }];
        [_rightTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_youImg.mas_left).mas_equalTo(-15);
        }];
        [_rightLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_youImg.mas_left).mas_equalTo(-15);
        }];
        
    }
    if (type == MenuCheckDetailsType) {
        _rightLbl.hidden = NO;
        _youImg.hidden = YES;
        _checkDetailsBtn.hidden = NO;
        [_rightTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_checkDetailsBtn.mas_left).mas_equalTo(-15);
        }];
        [_rightLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_checkDetailsBtn.mas_left).mas_equalTo(-15);
        }];
        
    }
    if (type == MenuCheckDetailsType) {
        _rightLbl.hidden = NO;
        _youImg.hidden = YES;
        _checkDetailsBtn.hidden = NO;
        [_rightTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_checkDetailsBtn.mas_left).mas_equalTo(-15);
        }];
        [_rightLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_checkDetailsBtn.mas_left).mas_equalTo(-15);
        }];
        
    }
    if (type == MenuCheckDetailsType1) 
    {
        _rightLbl.hidden = NO;
        _youImg.hidden = YES;
        _checkDetailsBtn1.hidden = NO;
        [_rightTF mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_equalTo(-80);
        }];
        [_rightLbl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).mas_equalTo(-80);
        }];
    }
}

@end
