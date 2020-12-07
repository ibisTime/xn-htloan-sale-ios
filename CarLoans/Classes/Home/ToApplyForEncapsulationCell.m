





      //
//  ToApplyForEncapsulationCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/28.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForEncapsulationCell.h"

@implementation ToApplyForEncapsulationCell
//{
//    UIImageView *chooseImg;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        
        UILabel *topLbl = [UILabel labelWithFrame:CGRectMake(15, 23, SCREEN_WIDTH - 107 - 30, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(11) textColor:kHexColor(@"#999999")];
        self.topLbl = topLbl;
        [self addSubview:topLbl];
        
        
        UITextField *textFid = [[UITextField alloc]initWithFrame:CGRectMake(15, 34, SCREEN_WIDTH - 137, 24)];
        textFid.placeholder = @"请输入";
        textFid.font = HGfont(12);
        self.inputTextField = textFid;
        [self addSubview:textFid];
        
        
        UILabel *chooseLbl = [UILabel labelWithFrame:CGRectMake(15, 39, SCREEN_WIDTH - 137 - 15, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#333333")];
        self.chooseLbl = chooseLbl;
        chooseLbl.text = @"请选择";
        [self addSubview:chooseLbl];
        
        self.chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(chooseLbl.xx + 9, 40, 6, 12)];
        self.chooseImg.image = kImage(@"跳转");
        [self addSubview:self.chooseImg];
        
        UILabel *showLbl = [UILabel labelWithFrame:CGRectMake(15, 39, SCREEN_WIDTH - 137, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#333333")];
        self.showLbl = showLbl;
        showLbl.text = @"";
        [self addSubview:showLbl];
    }
    return self;
}

-(void)setBottomStr:(NSString *)bottomStr
{
    self.showLbl.text = [BaseModel convertNull:bottomStr];
    self.chooseLbl.text = [BaseModel convertNull:bottomStr];
    self.inputTextField.text = [BaseModel convertNull:bottomStr];
}

-(void)setType:(UIType)type
{
    if (type == InputType)
    {
        self.chooseLbl.hidden = YES;
        self.chooseImg.hidden = YES;
        self.showLbl.hidden = YES;
        self.inputTextField.hidden = NO;
        
    }
    else if (type == ChooseType)
    {
        self.chooseLbl.hidden = NO;
        self.chooseImg.hidden = NO;
        self.showLbl.hidden = YES;
        self.inputTextField.hidden = YES;
    }
    else
    {
        self.chooseLbl.hidden = YES;
        self.chooseImg.hidden = YES;
        self.showLbl.hidden = NO;
        self.inputTextField.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
