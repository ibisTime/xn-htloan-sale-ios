//
//  TaskCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/6.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TaskCell.h"

@implementation TaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(UIButton *)photoBtn
{
    if (!_photoBtn) {
        _photoBtn = [UIButton buttonWithTitle:@"" titleColor:[UIColor blackColor] backgroundColor:BackColor titleFont:13];
        _photoBtn.frame = CGRectMake(15, 60, SCREEN_WIDTH - 30, 135);
        [_photoBtn setTitleColor:GaryTextColor forState:(UIControlStateNormal)];
        _photoBtn.tag = 102;
        kViewBorderRadius(_photoBtn, 5, 1, HGColor(230, 230, 230));
    }
    return _photoBtn;
}
-(UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, 100, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _nameLbl;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLbl];
        [self addSubview:self.photoBtn];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH/3 + 79, SCREEN_WIDTH, 1)];
        lineView1.backgroundColor = LineBackColor;
        [self addSubview:lineView1];
        
        UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        deleteBtn.frame = CGRectMake(SCREEN_WIDTH - 20 - 30 , 20 , 30, 30);
        
        [deleteBtn setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
        //        deleteBtn.backgroundColor = [UIColor redColor];
        self.deleteBtn = deleteBtn;
        [self addSubview:deleteBtn];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTaskArray:(NSArray *)TaskArray{
    NSArray *nameArray = @[@"任务名称:",
                           @"执行人 :",
                           @"创建时间:",
                           @"任务时效:"];
    for (int i = 0; i < TaskArray.count; i ++ ) {
        
        
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 60 + i % TaskArray.count * 145, SCREEN_WIDTH - 30, 135)];
        backView.backgroundColor = BackColor;
        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
        [self addSubview:backView];
        NSArray * array = TaskArray[i];
        
        for (int j = 0; j < array.count; j ++) {
            
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 10 + j%5*25, 60, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
            nameLabel.text = nameArray[j];
            [backView addSubview:nameLabel];
            
            UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 10+j%5*25, SCREEN_WIDTH - 120, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%@",TaskArray[i][@"name"]],
                                      [NSString stringWithFormat:@"%@",TaskArray[i][@"getUser"]],
                                      [NSString stringWithFormat:@"%@",TaskArray[i][@"createtime"]],
                                      [NSString stringWithFormat:@"%@",TaskArray[i][@"time"]]
                                      ];
            informationLabel.text = detailsArray[j];
            [backView addSubview:informationLabel];
        }
        
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        backButton.frame = CGRectMake(15, 60 + i % TaskArray.count * 145, SCREEN_WIDTH - 30, 135);
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        backButton.tag = 1234 + i;
        [self addSubview:backButton];
    }

    _photoBtn.frame = CGRectMake(15, 60 + TaskArray.count * 145, SCREEN_WIDTH - 30, 135);
}

-(void)setFileArray:(NSArray *)FileArray{
    NSArray *nameArray = @[@"文件内容:",
                           @"份数 :",
                           @"存放人:",
                           @"存放时间:",
                           @"备注"];
    for (int i = 0; i < FileArray.count; i ++ ) {
        
        
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 60 + i % FileArray.count * 145, SCREEN_WIDTH - 30, 135)];
        backView.backgroundColor = BackColor;
        kViewBorderRadius(backView, 2, 1, HGColor(230, 230, 230));
        [self addSubview:backView];
//        NSArray * array = FileArray[i];
        NSDictionary * dic = @{@"content":FileArray[i][@"content"],@"fileCount":FileArray[i][@"fileCount"],@"operatorName":FileArray[i][@"operatorName"],@"remark":FileArray[i][@"remark"],@"depositDateTime":[FileArray[i][@"depositDateTime"] convertDateWithFormat:@"yyyy-MM-dd HH:mm"]};
        
        
        NSLog(@" array.count %ld", dic.count);
        for (int j = 0; j < dic.count; j ++) {
            
            UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(15, 10 + j%5*25, 60, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:GaryTextColor];
            nameLabel.text = nameArray[j];
            [backView addSubview:nameLabel];
            
            UILabel *informationLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 10+j%5*25, SCREEN_WIDTH - 120, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(13) textColor:TextColor];
            NSArray *detailsArray = @[
                                      [NSString stringWithFormat:@"%@",dic[@"content"]],
                                      [NSString stringWithFormat:@"%@",dic[@"fileCount"]],
                                      [NSString stringWithFormat:@"%@",dic[@"operatorName"]],
                                      [NSString stringWithFormat:@"%@",dic[@"remark"]],
                                      [NSString stringWithFormat:@"%@",dic[@"depositDateTime"]]
                                      ];
            informationLabel.text = detailsArray[j];
            [backView addSubview:informationLabel];
        }
        
        UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        backButton.frame = CGRectMake(15, 60 + i % FileArray.count * 145, SCREEN_WIDTH - 30, 135);
        [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        backButton.tag = 1234 + i;
        [self addSubview:backButton];
    }
    
    _photoBtn.frame = CGRectMake(15, 60 + FileArray.count * 145, SCREEN_WIDTH - 30, 135);
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
