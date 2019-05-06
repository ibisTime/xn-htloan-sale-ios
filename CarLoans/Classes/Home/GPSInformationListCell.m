//
//  GPSInformationListCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/31.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "GPSInformationListCell.h"

@implementation GPSInformationListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *nameArray = @[@"设备号:",
                               @"位    置:",
                               @"时    间:",
                               @"人    员:"
                               ];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 135)];
        backView.backgroundColor = BackColor;
        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
        [self addSubview:backView];

        for (int j = 0; j < 4; j ++) {
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 15 + j%5*30, 60, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
            nameLabel.text = nameArray[j];
            [backView addSubview:nameLabel];

            UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 15+j%5*30, SCREEN_WIDTH - 120, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];

//            informationLabel.text = detailsArray[j];
            informationLabel.tag = 1000 + j;
            [backView addSubview:informationLabel];
        }

        
    }
    return self;
}
-(void)setDic:(NSDictionary *)dic
{
    NSArray *detailsArray = @[
                              [NSString stringWithFormat:@"%@",dic[@"gpsDevNo"]],
                              [NSString stringWithFormat:@"%@",dic[@"dic"][@"azLocation"]],
                              [NSString stringWithFormat:@"%@",dic[@"dic"][@"azDatetime"]],
                              [NSString stringWithFormat:@"%@",dic[@"dic"][@"azUser"]]
                              ];
    UILabel *label1 = [self viewWithTag:1000];
    UILabel *label2 = [self viewWithTag:1001];
    UILabel *label3 = [self viewWithTag:1002];
    UILabel *label4 = [self viewWithTag:1003];
    label1.text = [NSString stringWithFormat:@"%@",dic[@"gpsDevNo"]];
    label2.text = [NSString stringWithFormat:@"%@",dic[@"dic"][@"azLocation"]];
    label3.text = [NSString stringWithFormat:@"%@",dic[@"dic"][@"azDatetime"]];
    label4.text = [NSString stringWithFormat:@"%@",dic[@"dic"][@"azUser"]];
    
    
    UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 45, 0, 30, 30);
    _deleteBtn = deleteBtn;
    //        [deleteBtn addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [deleteBtn setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
    //        deleteBtn.backgroundColor = [UIColor redColor];
    [self addSubview:deleteBtn];
}
-(void)setDicionary:(NSDictionary *)Dicionary{
//    NSArray *detailsArray = @[
//                              [NSString stringWithFormat:@"%@",Dicionary[@"gpsDevNo"]],
//                              [NSString stringWithFormat:@"%@",Dicionary[@"dic"][@"azLocation"]],
//                              [NSString stringWithFormat:@"%@",Dicionary[@"dic"][@"azDatetime"]],
//                              [NSString stringWithFormat:@"%@",Dicionary[@"dic"][@"azUser"]]
//                              ];
    UILabel *label1 = [self viewWithTag:1000];
    UILabel *label2 = [self viewWithTag:1001];
    UILabel *label3 = [self viewWithTag:1002];
    UILabel *label4 = [self viewWithTag:1003];
    label1.text = [NSString stringWithFormat:@"%@",Dicionary[@"gpsDevNo"]];
    label2.text = [NSString stringWithFormat:@"%@",Dicionary[@"azLocation"]];
    label3.text = [NSString stringWithFormat:@"%@",Dicionary[@"azDatetime"]];
    label4.text = [NSString stringWithFormat:@"%@",Dicionary[@"azUser"]];
}

@end
