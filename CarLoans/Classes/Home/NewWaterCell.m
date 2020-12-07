//
//  NewWaterCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/2.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "NewWaterCell.h"

@implementation NewWaterCell
{
    UIImageView *chooseImg;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UILabel *topLbl = [UILabel labelWithFrame:CGRectMake(15, 23, SCREEN_WIDTH - 30, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(11) textColor:kHexColor(@"#999999")];
        self.topLbl = topLbl;
        [self addSubview:topLbl];
        
        
        UITextField *textFid = [[UITextField alloc]initWithFrame:CGRectMake(15, 39, SCREEN_WIDTH - 30, 14)];
        textFid.placeholder = @"请输入";
        textFid.font = HGfont(12);
        self.inputTextField = textFid;
        [self addSubview:textFid];
        
        
        UILabel *chooseLbl = [UILabel labelWithFrame:CGRectMake(15, 39, SCREEN_WIDTH - 30 - 15, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#333333")];
        self.chooseLbl = chooseLbl;
        chooseLbl.text = @"请选择";
        [self addSubview:chooseLbl];
        
        chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(chooseLbl.xx + 9, 40, 6, 12)];
        chooseImg.image = kImage(@"跳转");
        [self addSubview:chooseImg];
        
        UILabel *showLbl = [UILabel labelWithFrame:CGRectMake(15, 39, SCREEN_WIDTH - 30, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#333333")];
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

-(void)setType:(UICellType)type
{
    if (type == UIInputType)
    {
        self.chooseLbl.hidden = YES;
        chooseImg.hidden = YES;
        self.showLbl.hidden = YES;
        self.inputTextField.hidden = NO;
        
    }
    else if (type == UIChooseType)
    {
        self.chooseLbl.hidden = NO;
        chooseImg.hidden = NO;
        self.showLbl.hidden = YES;
        self.inputTextField.hidden = YES;
    }
    else
    {
        self.chooseLbl.hidden = YES;
        chooseImg.hidden = YES;
        self.showLbl.hidden = NO;
        self.inputTextField.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
