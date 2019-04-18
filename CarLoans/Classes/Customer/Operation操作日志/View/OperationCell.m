//
//  OperationCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "OperationCell.h"

@implementation OperationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *array = @[@"发起征信",@"业务开始第一步，发起征信",@"操作人：张三",@"操作时间：2019-10-10 10:20:00"];
        for (int i = 0; i < 4; i ++) {
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 12.5 + i % 4 * 35, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
            nameLbl.text = array[i];
            nameLbl.tag = 100 + i;
            [self addSubview:nameLbl];
        }
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 152.5, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = kBackgroundColor;
        [self addSubview:lineView];
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    UILabel *label1 = [self viewWithTag:100];
    UILabel *label2 = [self viewWithTag:101];
    UILabel *label3 = [self viewWithTag:102];
    UILabel *label4 = [self viewWithTag:103];
    label1.text = dataDic[@"dealNode"];
    label2.text = dataDic[@"dealNote"];
    label3.text = [NSString stringWithFormat:@"操作人：%@",dataDic[@"operatorName"]];
    label4.text = [dataDic[@"startDatetime"] convertToDetailDate];
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
