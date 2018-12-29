//
//  HomeCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HomeCell.h"
#import "IconView.h"
@implementation HomeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {


    }
    return self;
}


-(void)setSectionNum:(NSInteger)sectionNum
{
    if (sectionNum == 0)
    {


//        if ([[USERDEFAULTS objectForKey:USERDATA][@"loginName"] isEqualToString:@"ios"]) {
//            NSArray *imageArray = @[HGImage(@"咨信调查"),HGImage(@"面签"),HGImage(@"车辆落户")];
//            NSArray *nameArray = @[@"申请列表",@"面签",@"车辆落户"];
//            for (int i = 0; i < 3; i ++) {
//                IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
//                [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
//                iconView.backButton.tag = 100 + i;
//                iconView.image = imageArray[i];
//                iconView.nameStr = nameArray[i];
//                iconView.numberLabel.tag = 5000 + i;
//                [self addSubview:iconView];
//            }
//        }else
//        {
            NSArray *imageArray = @[HGImage(@"咨信调查"),HGImage(@"面签"),HGImage(@"GPS安装"),HGImage(@"车辆落户"),HGImage(@"车辆抵押")];
            NSArray *nameArray = @[@"业务发起",@"面签",@"GPS安装",@"发保合",@"车辆抵押"];
            for (int i = 0; i < 5; i ++) {
                IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
                [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
                iconView.backButton.tag = 100 + i;

                iconView.image = imageArray[i];
                iconView.nameStr = nameArray[i];
                //            iconView.numberStr = numberArray[i];
                iconView.numberLabel.tag = 5000 + i;

                [self addSubview:iconView];
//            }
        }
    }
    else if (sectionNum == 1)
    {

//        if ([[USERDEFAULTS objectForKey:USERDATA][@"loginName"] isEqualToString:@"ios"]) {
//            NSArray *imageArray = @[HGImage(@"客户作废"),HGImage(@"历史客户")];
//            NSArray *nameArray = @[@"客户作废",@"历史客户"];
//            for (int i = 0; i < 2; i ++) {
//                IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
//                [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
//                iconView.backButton.tag = 1000 + i;
//
//                iconView.image = imageArray[i];
//                iconView.nameStr = nameArray[i];
//                //            iconView.numberStr = numberArray[i];
//                [self addSubview:iconView];
//            }
//
//        }else
//        {
            NSArray *imageArray = @[HGImage(@"客户作废"),HGImage(@"GPS申领"),HGImage(@"历史客户")];
            NSArray *nameArray = @[@"客户作废",@"GPS申领",@"历史客户"];
            for (int i = 0; i < 3; i ++) {
                IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
                [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
                iconView.backButton.tag = 1000 + i;

                iconView.image = imageArray[i];
                iconView.nameStr = nameArray[i];
                //            iconView.numberStr = numberArray[i];
                [self addSubview:iconView];
//            }
        }


    }
    else if (sectionNum == 2)
    {
        NSArray *imageArray = @[HGImage(@"资料传递")];
        NSArray *nameArray = @[@"资料传递"];
        for (int i = 0; i < 1; i ++) {
            IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
            [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            iconView.backButton.tag = 10000 + i;

            iconView.image = imageArray[i];
            iconView.nameStr = nameArray[i];
//            iconView.numberStr = numberArray[i];
            iconView.numberLabel.tag = 5005;
            [self addSubview:iconView];
        }
    }else if (sectionNum == 100)
    {
        NSArray *imageArray = @[HGImage(@"咨信调查"),HGImage(@"面签"),HGImage(@"银行放款"),HGImage(@"车辆抵押"),HGImage(@"结清审核")];
        NSArray *nameArray = @[@"资信调查",@"面签",@"银行放款",@"车辆抵押",@"结清审核"];
        for (int i = 0; i < imageArray.count; i ++) {
            IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
            [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            iconView.backButton.tag = 100 + i;
            iconView.numberLabel.tag = 5000 + i;

            if (i == 2) {
                iconView.numberLabel.tag = 5000 + i + 10;
            }
            if (i == 4) {
                iconView.numberLabel.tag = 5000 + i + 10;
            }

            iconView.image = imageArray[i];
            iconView.nameStr = nameArray[i];
//            iconView.numberStr = numberArray[i];
            [self addSubview:iconView];
        }
    }else if (sectionNum == 101)
    {
        NSArray *imageArray = @[HGImage(@"资料传递")];
        NSArray *nameArray = @[@"资料传递"];
        for (int i = 0; i < 3; i ++) {
            IconView *iconView = [[IconView alloc]initWithFrame:CGRectMake(i % 3 * SCREEN_WIDTH/3, i / 3 * (SCREEN_WIDTH/3), SCREEN_WIDTH/3, SCREEN_WIDTH/3 )];
            [iconView.backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            iconView.backButton.tag = 1000 + i;
            iconView.numberLabel.tag = 5005;

            if (i == 0) {
                iconView.image = imageArray[i];
                iconView.nameStr = nameArray[i];
            }
            [self addSubview:iconView];
        }
    }
}



-(void)backButtonClick:(UIButton *)sender
{
    [_HomeDelegate HomeCell:sender.tag button:sender];
}

@end
