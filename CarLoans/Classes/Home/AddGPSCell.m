//
//  AddGPSCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AddGPSCell.h"

@implementation AddGPSCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSArray *nameArray = @[@"GPS类型:",
                               @"GPS设备号:"];
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 60)];
        backView.backgroundColor = BackColor;
        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
        [self addSubview:backView];
        for (int j = 0; j < 2; j ++) {
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 10 + j%5*25, 100, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
            nameLabel.text = nameArray[j];
            [backView addSubview:nameLabel];
            
            UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(125, 10+j%5*25, SCREEN_WIDTH - 120, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];
            informationLabel.tag = 100 + j;
            [backView addSubview:informationLabel];
        }
        self.selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.selectButton.frame = self.selectButton.frame = CGRectMake(SCREEN_WIDTH - 45, 15, 30, 30);
        [self.selectButton setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
        
        [self addSubview:self.selectButton];
    }
    return self;
}
-(void)setTaskDic:(NSDictionary *)taskDic{
    for (int i = 0; i < 2; i ++) {
        UILabel *label1 = [self viewWithTag:100 + i];
        
        NSArray *detailsArray = @[
                                  [NSString stringWithFormat:@"%@",[taskDic[@"gpsTypeStr"] isEqualToString:@"1"]?@"有线":@"无线"],
                                  [NSString stringWithFormat:@"%@",taskDic[@"gpsDevNo"]]
                                  ];
        label1.text = detailsArray[i];
    }
    _photoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _photoBtn.frame = CGRectMake(15, 60 , SCREEN_WIDTH - 30, 110);
    [_photoBtn addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_photoBtn];
}
-(void)deleteClick:(UIButton *)sender
{
    [_delegate deleteButton:sender];
}
-(void)backButtonClick:(UIButton *)sender
{
    [_delegate SurveyTaskSelectButton:sender];
}

-(void)setBtnStr:(NSString *)btnStr
{
    [_photoBtn setTitle:btnStr forState:(UIControlStateNormal)];
    [_photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
        [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
    }];
}
-(void)setName:(NSString *)name
{
    _nameLbl.text = name;
}

@end
