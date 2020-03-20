//
//  MessageCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/15.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell
{
    UILabel *nameLbl;
    UILabel *stateLbl;
    UILabel *timeLbl;
    UILabel *typeLbl;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
//        nameLbl.text = @"车贷B端系统正式上线";
        [self addSubview:nameLbl];
        
//        stateLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2, 15, SCREEN_WIDTH/2 - 15, 20) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(13) textColor:kHexColor(@"#333333")];
//        stateLbl.text = @"";
//        [self addSubview:stateLbl];
        
        timeLbl = [UILabel labelWithFrame:CGRectMake(15, 45.5, 150, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        timeLbl.text = @"2019-10-10 20:00:00";
        [self addSubview:timeLbl];
        
        typeLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH - 215, 45.5, 200, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        typeLbl.text = @"系统公告";
        [self addSubview:typeLbl];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 76.5, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = kLineColor;
        [self addSubview:lineView];
        
    }
    return self;
}

-(void)setIndex:(NSInteger)index
{
    _index = index;
}

-(void)setModels:(TodoModel *)models
{
    if ([BaseModel isBlankString:models.title] == NO) {
        nameLbl.text = models.title;
        timeLbl.text= [models.updateDatetime convertToDetailDate];
        if (_index == 0) {
            typeLbl.text = @"消息";
            if ([models.content hasPrefix:@"<p>"]) {
                NSRange startRange = [models.content rangeOfString:@"<p>"];
                NSRange endRange = [models.content rangeOfString:@"</p>"];
                NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
                NSString * con = [models.content substringWithRange:range];
                nameLbl.text = con;
            }else
            {
                nameLbl.text = models.content;
            }
        }else
        {
            typeLbl.text = @"系统公告";
            nameLbl.text = models.title;
        }
        
    }else
    {
        
        nameLbl.text = models.content;
        timeLbl.text= [models.createDatetime convertToDetailDate];
        typeLbl.text = models.bizCode;
    }
}

@end
