//
//  TransferCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/8.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "TransferCell.h"

@implementation TransferCell
-(UILabel *)codeLabel
{
    if (!_codeLabel) {
        _codeLabel = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH/2 - 10, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];
    }
    return _codeLabel;
}

-(UILabel *)stateLabel
{
    if (!_stateLabel) {
        _stateLabel = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2, 10, SCREEN_WIDTH/2 - 10, 40) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(12) textColor:GaryTextColor];
        _stateLabel.numberOfLines = 2;
        
    }
    return _stateLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView1.backgroundColor = LineBackColor;
        [self addSubview:lineView1];
        
        [self addSubview:self.codeLabel];
        [self addSubview:self.stateLabel];
        for (int i = 0; i < 11; i ++) {
            _nameLabel = [UILabel labelWithFrame:CGRectMake(15 , 70 + i % 11 * 35, 100, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];
            _nameLabel.tag = 100000 + i;
            [self addSubview:_nameLabel];
            
            _InformationLabel = [UILabel labelWithFrame:CGRectMake(115 , 70 + i % 11 * 35, SCREEN_WIDTH - 130, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:TextColor];
            _InformationLabel.tag = 1000000 + i;
            [self addSubview:_InformationLabel];
        }
        
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
        
        _button = [UIButton buttonWithTitle:@"确认提交银行" titleColor:MainColor backgroundColor:kClearColor titleFont:14];
        _button.frame = CGRectMake(SCREEN_WIDTH - 115, 280, 100, 30);
        kViewBorderRadius(_button, 5, 1, MainColor);
        [self addSubview:_button];
//        _button.hidden = YES;
    }
    return self;
}
-(void)setDataTransferModel:(DataTransferModel *)dataTransferModel{
    _codeLabel.text = [NSString stringWithFormat:@"%@",dataTransferModel.bizCode];
    _stateLabel.text = [[BaseModel user]note:dataTransferModel.curNodeCode];
    NSArray * nameArray = [[NSArray alloc]init];
    NSArray *InformationArray = [[NSArray alloc]init];
    NSString *state;
    if ([dataTransferModel.status isEqualToString:@"0"]) {
        state = @"待发件";
    }else if ([dataTransferModel.status isEqualToString:@"1"])
    {
        state = @"已发件待收件";
    }else if ([dataTransferModel.status isEqualToString:@"2"])
    {
        state = @"已收件审核";
    }else
    {
        state = @"已收件待补件";
    }
    if (!dataTransferModel.sendType) {
        nameArray = @[
                               @"发件节点",
                               @"收件节点",
                               @"业务团队",
                               @"信贷专员",
                               @"内勤专员",
                               @"快递状态"];
        InformationArray = @[
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:dataTransferModel.fromNodeCode]],
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:dataTransferModel.toNodeCode]],
                             [NSString stringWithFormat:@"%@",dataTransferModel.teamName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.saleUserName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.insideJobName],
                             state];
    }
    if ([dataTransferModel.sendType isEqualToString:@"2"]) {
        nameArray = @[
                               @"发件节点",
                               @"收件节点",
                               @"快递方式",
                               @"快递公司",
                               @"单号",
                               @"发件人",
                               @"收件人",
                               @"业务团队",
                               @"信贷专员",
                               @"内勤专员",
                               @"快递状态"];
        
        InformationArray = @[
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:dataTransferModel.fromNodeCode]],
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:dataTransferModel.toNodeCode]],
                             [NSString stringWithFormat:@"%@",[[BaseModel user]value:dataTransferModel.sendType]],
                             [NSString stringWithFormat:@"%@",[[BaseModel user] setParentKey:@"kd_company" setDkey:dataTransferModel.logisticsCompany]],
                             [NSString stringWithFormat:@"%@",dataTransferModel.logisticsCode],
                             [NSString stringWithFormat:@"%@",dataTransferModel.senderName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.receiverName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.teamName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.saleUserName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.insideJobName],
                             state];
    }
    else if ([dataTransferModel.sendType isEqualToString:@"1"]){
        nameArray = @[
                               @"发件节点",
                               @"收件节点",
                               @"快递方式",
                               @"发件人",
                               @"收件人",
                               @"业务团队",
                               @"信贷专员",
                               @"内勤专员",
                               @"快递状态"];
        InformationArray = @[
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:dataTransferModel.fromNodeCode]],
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:dataTransferModel.toNodeCode]],
                             [NSString stringWithFormat:@"%@",[[BaseModel user]value:dataTransferModel.sendType]],
                             [NSString stringWithFormat:@"%@",dataTransferModel.senderName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.receiverName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.teamName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.saleUserName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.insideJobName],
                             state];
        
    }
  
    
    
    
    
    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text = [BaseModel convertNull:InformationArray[i]];
    }
}
//-(void)setCadListModel:(CadListModel *)cadListModel{
//    _codeLabel.text = [NSString stringWithFormat:@"%@",cadListModel.code];
//    _stateLabel.text = [[BaseModel user]note:cadListModel.curNodeCode];
//    
//    NSLog(@"%@",[[BaseModel user]note:cadListModel.curNodeCode]);
//    NSArray *nameArray = @[
//                           @"发件节点",
//                           @"收件节点",
//                           @"快递方式",
//                           @"快递公司",
//                           @"单号",
//                           @"发件人",
//                           @"收件人",
//                           @"业务团队",
//                           @"信贷专员",
//                           @"内勤专员",
//                           @"快递状态"];
//    
//    NSString *state;
//    if ([cadListModel.status isEqualToString:@"0"]) {
//        state = @"待发件";
//    }else if ([cadListModel.status isEqualToString:@"1"])
//    {
//        state = @"已发件待收件";
//    }else if ([cadListModel.status isEqualToString:@"2"])
//    {
//        state = @"已收件审核";
//    }else
//    {
//        state = @"已收件待补件";
//    }
//    
//    NSArray *InformationArray = @[
//                                  [NSString stringWithFormat:@"%@",[[BaseModel user]note:cadListModel.fromNodeCode]],
//                                  [NSString stringWithFormat:@"%@",[[BaseModel user]note:cadListModel.toNodeCode]],
//                                  [NSString stringWithFormat:@"%@",cadListModel.customerName],
//                                  [NSString stringWithFormat:@"%@",[[BaseModel user] setParentKey:@"kd_company" setDkey:dataTransferModel.logisticsCompany]],
//                                  [NSString stringWithFormat:@"%@",dataTransferModel.logisticsCode],
//                                  [NSString stringWithFormat:@"%@",dataTransferModel.senderName],
//                                  [NSString stringWithFormat:@"%@",dataTransferModel.receiverName],
//                                  [NSString stringWithFormat:@"%@",dataTransferModel.teamName],
//                                  [NSString stringWithFormat:@"%@",dataTransferModel.saleUserName],
//                                  [NSString stringWithFormat:@"%@",dataTransferModel.insideJobName],
//                                  state];
//    
//    for (int i = 0; i < nameArray.count; i ++ ) {
//        UILabel *nameLabel = [self viewWithTag:100000 + i];
//        nameLabel.text = nameArray[i];
//        UILabel *InformationLabel = [self viewWithTag:100000 + i];
//        InformationLabel.text = [BaseModel convertNull:InformationArray[i]];
//    }
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
