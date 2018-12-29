//
//  CADChooseCell.m
//  CarLoans
//
//  Created by shaojianfei on 2018/9/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CADChooseCell.h"
#import <Masonry.h>
@implementation CADChooseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier   ];
    if (self) {
       
        self.firstLabl = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:14];
        self.secondLabl = [UILabel labelWithBackgroundColor:kClearColor textColor:kBlackColor font:14];
        self.firstLabl.text = @"参考材料清单";
        [self addSubview:self.firstLabl];
        [self addSubview:self.secondLabl];
        [self.firstLabl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.left.equalTo(self.mas_left).offset(15);
            
            
        }];
        [self.secondLabl mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerX.equalTo(self.mas_centerX);
            make.left.equalTo(self.firstLabl.mas_right).offset(15);
        }];
        
    }
    return self;
}

@end
