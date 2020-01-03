//
//  LenderInformationCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "LenderInformationCell.h"

@implementation LenderInformationCell
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
        
        [self addSubview:nameLbl];
        
        identityLbl = [UILabel labelWithFrame:CGRectMake(15, 44, SCREEN_WIDTH - 15 - 55, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        identityLbl.text = @"主贷人";
        [self addSubview:identityLbl];
        
        statusLbl = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#0AB86C")];
        
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

-(void)setCreditUserList:(NSArray *)creditUserList
{
    nameLbl.text = [NSString stringWithFormat:@"未录入%@信息",_dataDic[@"dvalue"]];
    statusLbl.text = @"";
    for (int i = 0 ; i < creditUserList.count; i ++) {
        if ([creditUserList[i][@"loanRole"] isEqualToString:_dataDic[@"dkey"]]) {
            nameLbl.text = [NSString stringWithFormat:@"%@（%@）",[BaseModel convertNull:creditUserList[i][@"userName"]],[BaseModel convertNull:creditUserList[i][@"mobile"]]];
            if ([creditUserList[i][@"bankCreditResult"] isEqualToString:@"1"]) {
                statusLbl.text = @"通过";
            }else if ([creditUserList[i][@"bankCreditResult"] isEqualToString:@"0"]) {
                statusLbl.text = @"不通过";
            }else
            {
                statusLbl.text = @"";
            }
        }
    }
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    identityLbl.text = dataDic[@"dvalue"];
}

@end
