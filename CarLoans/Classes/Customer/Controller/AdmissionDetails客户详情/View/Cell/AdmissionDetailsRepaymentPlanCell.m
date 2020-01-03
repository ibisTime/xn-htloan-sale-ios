//
//  RepaymentPlanCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsRepaymentPlanCell.h"

@implementation AdmissionDetailsRepaymentPlanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 15, (SCREEN_WIDTH)/2 - 15, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#333333")];
        nameLbl.tag = 1000;
//        nameLbl.text = [NSString stringWithFormat:@"第%@期",self.dic[@"curPeriods"]];
        [self addSubview:nameLbl];
        
        
        UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(15, nameLbl.yy + 4, (SCREEN_WIDTH)/2 - 15, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        timeLbl.tag = 2000;
//        timeLbl.text = [self.dic[@"repayDatetime"] convertDate];
        [self addSubview:timeLbl];
        
        UILabel *priceLbl = [UILabel labelWithFrame:CGRectMake((SCREEN_WIDTH)/2, 0, (SCREEN_WIDTH )/2 - 15, 67) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];

        priceLbl.tag = 3000;

        [self addSubview:priceLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, 66, (SCREEN_WIDTH) - 30, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic{
    
    UILabel * label = [self viewWithTag:1000];
    NSLog(@"curPeriods%d",[dic[@"curPeriods"] intValue]);
    label.text = [NSString stringWithFormat:@"第%@期",dic[@"curPeriods"]];
    
    UILabel * label2 = [self viewWithTag:2000];
    label2.text = [dic[@"repayDatetime"] convertDate];
    
    UILabel * label3 = [self viewWithTag:3000];
    NSString *price = [NSString stringWithFormat:@"%.2f元",[dic[@"repayAmount"] floatValue] / 1000 ];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:price];
    [attrString addAttribute:NSFontAttributeName value:Font(10) range:NSMakeRange(price.length - 1,1)];
    label3.attributedText = attrString;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
