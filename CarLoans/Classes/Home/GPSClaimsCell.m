//
//  GPSClaimsCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSClaimsCell.h"

@implementation GPSClaimsCell

-(UILabel *)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH/2 - 10, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];
    }
    return _codeLabel;
}

-(UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, SCREEN_WIDTH/2 - 10, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];
        _stateLabel.numberOfLines = 2;

    }
    return _stateLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView1.backgroundColor = LineBackColor;
        [self addSubview:lineView1];

        [self addSubview:self.codeLabel];
        [self addSubview:self.stateLabel];


        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
        for (int i = 0; i < 5; i ++) {
            _nameLabel = [UILabel labelWithFrame:CGRectMake(15 , 70 + i % 5 * 25, SCREEN_WIDTH - 30, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];
            _nameLabel.tag = 100000 + i;
            [self addSubview:_nameLabel];

        }

    }
    return self;
}

- (void)buttonClick:(UIButton *)btn
{
    
    NSLog(@"%ld",btn.tag);
    
}

-(void)setDataAry:(NSArray *)dataAry
{
    _dataAry = dataAry;
}

-(void)setGpsclaimsModel:(GPSClaimsModel *)gpsclaimsModel
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",gpsclaimsModel.companyName];
//0 待审核 1 审核通过,待发货 2 审核不通过 3 已发货,待收货 4 已收货
    
    
    for (int i = 0; i < _dataAry.count; i ++) {
        if ([_dataAry[i][@"dkey"] integerValue] == gpsclaimsModel.status) {
            _stateLabel.text = _dataAry[i][@"dvalue"];
        }
    }
    
    

    NSArray *nameArray = @[
                           @"所属公司",
                           @"申领个数",
                           @"申领时间",
                           @"",
                           @""
                           ];
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"申请人：%@",[BaseModel convertNull:gpsclaimsModel.applyUserName]],
                                  [NSString stringWithFormat:@"所属团队：%@",[BaseModel convertNull:gpsclaimsModel.teamName]],
                                  [NSString stringWithFormat:@"申请时间：%@",[gpsclaimsModel.applyDatetime convertToDetailDate]],
                                  [NSString stringWithFormat:@"申请个数：%ld",[gpsclaimsModel.applyCount integerValue]],
                                  [NSString stringWithFormat:@"备注：%@",[BaseModel convertNull:gpsclaimsModel.applyReason]]
                                  ];

    for (int i = 0; i < nameArray.count; i ++ ) {
//        UILabel *nameLabel = [self viewWithTag:100000 + i];
//        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:100000 + i];
        InformationLabel.text = [BaseModel convertNull:InformationArray[i]];
    }
}


-(void)setGpsInstallationModel:(GPSInstallationModel *)gpsInstallationModel{
    _codeLabel.text = [NSString stringWithFormat:@"%@",gpsInstallationModel.code];
    _stateLabel.text = [[BaseModel user]note:gpsInstallationModel.advanfCurNodeCode];
    NSArray *nameArray = @[
                           @"客户姓名",
                           @"业务公司",
                           @"品牌型号",
                           
                           ];
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",gpsInstallationModel.applyUserName],
                                  [NSString stringWithFormat:@"%.@",gpsInstallationModel.companyName],
                                  [NSString stringWithFormat:@"%@",gpsInstallationModel.carBrand]];

    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text = [BaseModel convertNull:InformationArray[i]];
    }
}


@end
