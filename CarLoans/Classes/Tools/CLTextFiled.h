//
//  CLTextFiled.h
//  CarLoans
//
//  Created by shaojianfei on 2018/12/25.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLTextFiled : UITextField
@property (nonatomic, strong) UILabel *leftLbl;
@property (nonatomic, strong) UILabel *contentLab;

- (instancetype)initWithFrame:(CGRect)frame
                    leftTitle:(NSString *)leftTitle
                   titleWidth:(CGFloat)titleWidth
                  placeholder:(NSString *)placeholder;

//禁止复制粘贴等功能
@property (nonatomic,assign) BOOL isSecurity;
@end
