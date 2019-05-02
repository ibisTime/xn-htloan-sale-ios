//
//  ToApplyForRunningWaterCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/29.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForRunningWaterCell.h"

@implementation ToApplyForRunningWaterCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSArray *nameArray = @[@"征信人:",
                               @"分类:",
                               @"流水日期区间:",
                               @"总收入:",
                               @"总支出:",
                               @"余额:",
                               @"月均收入:",
                               @"月均支出:"];
        
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30 - 107, 210)];
        backView.backgroundColor = BackColor;
        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
        [self addSubview:backView];
        
        
        for (int i = 0; i < nameArray.count; i ++ ) {

            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 10 + i % nameArray.count*25, SCREEN_WIDTH - 107 - 60, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
            nameLabel.text = nameArray[i];
            nameLabel.tag = 100000 + i;
            [backView addSubview:nameLabel];

        }
        
        UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 107 - 20 - 30 , 20 , 30, 30);
//        [deleteBtn addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [deleteBtn setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
        //        deleteBtn.backgroundColor = [UIColor redColor];
        [self addSubview:deleteBtn];
    }
    return self;
}

-(void)setWaterDic:(NSDictionary *)WaterDic
{
    UILabel *label0 = [self viewWithTag:100000];
    UILabel *label1 = [self viewWithTag:100001];
    UILabel *label2 = [self viewWithTag:100002];
    UILabel *label3 = [self viewWithTag:100003];
    UILabel *label4 = [self viewWithTag:100004];
    UILabel *label5 = [self viewWithTag:100005];
    UILabel *label6 = [self viewWithTag:100006];
    UILabel *label7 = [self viewWithTag:100007];
    label0.text = [NSString stringWithFormat:@"征信人:%@",[BaseModel convertNull:WaterDic[@"creditUser"][@"userName"]]];
    NSString *type;
    if ([WaterDic[@"type"] isEqualToString:@"1"]) {
        type = @"微信";
    }else if ([WaterDic[@"type"] isEqualToString:@"2"])
    {
        type = @"支付宝";
    }else
    {
        type = @"银行";
    }
    label1.text = [NSString stringWithFormat:@"分类:%@",[BaseModel convertNull:type]];
    label2.text = [NSString stringWithFormat:@"%@-%@",[WaterDic[@"datetimeStart"] convertDate],[WaterDic[@"datetimeEnd"] convertDate]];
    label3.text = [NSString stringWithFormat:@"%.2f",[WaterDic[@"income"] floatValue]/1000];
    label4.text = [NSString stringWithFormat:@"%.2f",[WaterDic[@"expend"] floatValue]/1000];
    label5.text = [NSString stringWithFormat:@"%.2f",[WaterDic[@"balance"] floatValue]/1000];
    label6.text = [NSString stringWithFormat:@"%.2f",[WaterDic[@"monthIncome"] floatValue]/1000];
    label7.text = [NSString stringWithFormat:@"%.2f",[WaterDic[@"monthExpend"] floatValue]/1000];
    
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
