//
//  BottomView.m
//  pod_test
//
//  Created by YY_ZYQ on 2017/6/23.
//  Copyright © 2017年 YY_ZYQ. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.allBtn];
//        [self addSubview:self.readBtn];
        [self addSubview:self.deleteBtn];
        [self addSubview:self.delayBtn];
    }
    return self;
}

- (UIButton *)allBtn{
    if (!_allBtn) {
        self.allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allBtn.frame = CGRectMake(10, 0, 40, self.bounds.size.height);
        _allBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_allBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_allBtn setTitleColor:MainColor forState:UIControlStateNormal];
//        [_allBtn setImage:kImage(@"选中") forState:<#(UIControlState)#>]
    }
    return _allBtn;
}


- (UIButton *)readBtn{
    if (!_readBtn) {
        self.readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _readBtn.frame = CGRectMake((self.bounds.size.width - 70)/2, 0, 70, self.bounds.size.height);
        _readBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_readBtn setTitle:@"标记已读" forState:UIControlStateNormal];
        [_readBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return _readBtn;
}

- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteBtn.frame = CGRectMake(self.bounds.size.width - 115, 17.5, 100, 40);
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _deleteBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_deleteBtn setTitle:@"人工确认还款" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:MainColor forState:UIControlStateNormal];
        kViewBorderRadius(_deleteBtn, 3, 1, MainColor);
    }
    return _deleteBtn;
}
-(UIButton *)delayBtn{
    if (!_delayBtn) {
        self.delayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delayBtn.frame = CGRectMake(self.bounds.size.width - 230, 17.5, 100, 40);
        _delayBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _delayBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_delayBtn setTitle:@"人工确认逾期" forState:UIControlStateNormal];
        [_delayBtn setTitleColor:MainColor forState:UIControlStateNormal];
        kViewBorderRadius(_delayBtn, 3, 1, MainColor);
    }
    return _delayBtn;
}

@end
