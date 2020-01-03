//
//  TaskManagementCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TaskManagementCell.h"

@implementation TaskManagementCell
{
    UILabel *nameLbl;
    UILabel *identityLbl;
    UILabel *statusLbl;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 15 - 55, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
//        nameLbl.text = @"王大锤（18838908888）";
        [self addSubview:nameLbl];
        
        identityLbl = [UILabel labelWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 15 - 55, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
//        identityLbl.text = @"主贷人";
        [self addSubview:identityLbl];
        
        statusLbl = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
//        statusLbl.text = @"6小时";
        [self addSubview:statusLbl];
        [statusLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-31);
            make.bottom.top.mas_equalTo(0);
        }];
        
        UIImageView *youImg = [[UIImageView alloc]init];
        youImg.contentMode = UIViewContentModeScaleAspectFit;
        youImg.image = kImage(@"you");
        [self addSubview:youImg];
        
        [youImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(5);
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

-(void)setDataDic:(NSDictionary *)dataDic
{
    nameLbl.text = dataDic[@"name"];
    for (int i = 0; i<_saleUserIdAry.count; i ++) {
        if ([_saleUserIdAry[i][@"userId"] isEqualToString:dataDic[@"getUser"]]) {
            identityLbl.text = _saleUserIdAry[i][@"realName"];
        }
    }
    
    statusLbl.text = [NSString stringWithFormat:@"%@小时",dataDic[@"time"]];
}

-(void)setSaleUserIdAry:(NSArray *)saleUserIdAry
{
    _saleUserIdAry = saleUserIdAry;
}

@end
