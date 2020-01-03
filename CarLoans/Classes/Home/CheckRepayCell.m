//
//  CheckRepayCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CheckRepayCell.h"

@implementation CheckRepayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView1.backgroundColor = LineBackColor;
        [self addSubview:lineView1];
        
        [self.contentView addSubview:self.codeLabel];
        [self.contentView addSubview:self.stateLabel];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self.contentView addSubview:lineView];
//        int k = 15;
        int k = 6;
        
//        if (self.isGps == YES) {
//            k = 13;
//        }else{
//            //            if (self.isFinancial == YES) {
//            //                k = 100;
//            //            }else
//            k = 11;
//        }
//        if (self.isCar == YES) {
//            k = 7;
//        }
        
        for (int i = 0; i < k; i ++) {
            _nameLabel = [UILabel labelWithFrame:CGRectMake(15 , 70 + i % k * 35, 150, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];
            //            _nameLabel.text = nameArray[i];
            _nameLabel.tag = 100000 + i;
            [self.contentView addSubview:_nameLabel];
            
            _InformationLabel = [UILabel labelWithFrame:CGRectMake(115 , 70 + i % k * 35, SCREEN_WIDTH - 130, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:TextColor];
            _InformationLabel.tag = 1000000 + i;
            [self addSubview:_InformationLabel];
        }
        _button = [UIButton buttonWithTitle:@"提前还款申请" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
        _button.frame =CGRectMake(SCREEN_WIDTH - 230, 295, 100, 30);
        kViewBorderRadius(_button, 5, 1, MainColor);
        [self addSubview:_button];
        _button.hidden = YES;
        
        _button1 = [UIButton buttonWithTitle:@"还款计划" titleColor:MainColor backgroundColor:kClearColor titleFont:15 cornerRadius:5];
        kViewBorderRadius(_button1, 5, 1, MainColor);
        _button1.frame = CGRectMake(SCREEN_WIDTH - 115, 295, 100, 30);
        [self addSubview:_button1];
        _button1.hidden = YES;
        
        _button2 = [UIButton buttonWithTitle:@"还款计划" titleColor:MainColor backgroundColor:kClearColor titleFont:15 cornerRadius:5];
        kViewBorderRadius(_button2, 5, 1, MainColor);
        _button2.frame = CGRectMake(SCREEN_WIDTH - 345, 295, 100, 30);
        [self addSubview:_button2];
        _button2.hidden = YES;

//        if (k == 13) {
//            UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 279+70+90+60, SCREEN_WIDTH, 1)];
//            lineView2.backgroundColor = LineBackColor;
//            [self addSubview:lineView2];
//            _button = [UIButton buttonWithTitle:@"提交银行" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
//            _button.frame = CGRectMake(SCREEN_WIDTH - 115, 290+60+90+60, 100, 30);
//            kViewBorderRadius(_button, 5, 1, MainColor);
//            [self addSubview:_button];
//            _button.hidden = YES;
//        }else if(k == 11)
//        {
//
//            UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 279+70+90, SCREEN_WIDTH, 1)];
//            lineView2.backgroundColor = LineBackColor;
//            [self addSubview:lineView2];
//            _button = [UIButton buttonWithTitle:@"提交银行" titleColor:MainColor backgroundColor:kClearColor titleFont:14];
//            //            _button.frame = CGRectMake(SCREEN_WIDTH - 115, 290+60+90, 100, 30);
//            _button.frame = CGRectMake(SCREEN_WIDTH - 115, 290, 100, 30);
//            kViewBorderRadius(_button, 5, 1, MainColor);
//            [self addSubview:_button];
//            _button.hidden = YES;
//        }
//        else if (k == 100){
//            UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 279+70+90, SCREEN_WIDTH, 1)];
//            lineView2.backgroundColor = LineBackColor;
//            [self addSubview:lineView2];
//            _button = [UIButton buttonWithTitle:@"提交银行" titleColor:MainColor backgroundColor:kClearColor titleFont:14];
//            _button.frame = CGRectMake(SCREEN_WIDTH - 115, 280, 100, 30);
//            kViewBorderRadius(_button, 5, 1, MainColor);
//            [self addSubview:_button];
//            _button.hidden = YES;
//        }
//
//        else{
//            UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 279, SCREEN_WIDTH, 1)];
//            lineView2.backgroundColor = LineBackColor;
//            [self addSubview:lineView2];
//            _button = [UIButton buttonWithTitle:@"提交银行" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
//            _button.frame = CGRectMake(SCREEN_WIDTH - 115, 290, 100, 30);
//            kViewBorderRadius(_button, 5, 1, MainColor);
//            [self addSubview:_button];
//            _button.hidden = YES;
//        }
        
        
        
        
    }
    return self;
}

-(void)setRepayModel:(RepayModel *)repayModel{
    _codeLabel.text = [NSString stringWithFormat:@"%@",repayModel.code];
    _stateLabel.text = [[BaseModel user]note:repayModel.curNodeCode];
    
//    NSArray *nameArray = @[
//                           @"业务编号",
//                           @"贷款人",
//                           @"手机号",
//                           @"贷款银行",
//                           @"贷款金额（元）",
//                           @"贷款期数",
//                           @"剩余期数",
//                           @"还款日",
//                           @"月供（元）",
//                           @"剩余欠款(元)",
//                           @"未还清收总成本(元)",
//                           @"逾期金额(元)",
//                           @"累计逾期期数",
//                           @"实际逾期期数",
//                           @"放款日期"];
    NSArray *nameArray = @[
                           @"业务编号",
                           @"贷款人",
                           @"贷款银行",
                           @"贷款金额（元）",
                           @"月供（元）"];
    //    NSString *bizType;
    
    
//    NSArray *InformationArray = @[
//                                  [NSString stringWithFormat:@"%@",repayModel.code],
//                                  [NSString stringWithFormat:@"%@",repayModel.user[@"realName"]],
//                                  [NSString stringWithFormat:@"%@",repayModel.user[@"mobile"]],
//                                  [NSString stringWithFormat:@"%@",repayModel.loanBankName],
//                                  [NSString stringWithFormat:@"%.2f",[repayModel.loanAmount floatValue]/1000],
//                                  [NSString stringWithFormat:@"%@",repayModel.periods],
//                                  [NSString stringWithFormat:@"%@",repayModel.restPeriods],
//                                  [NSString stringWithFormat:@"%@",repayModel.monthDatetime],
//                                  [NSString stringWithFormat:@"%.2f",[repayModel.monthAmount floatValue]/1000],
//                                  [NSString stringWithFormat:@"%.2f",[repayModel.restAmount floatValue]/1000],
//                                  [NSString stringWithFormat:@"%.2f",[repayModel.restTotalCost floatValue]/1000],
//                                  [NSString stringWithFormat:@"%.2f",[repayModel.overdueAmount floatValue]/1000],
//                                  [NSString stringWithFormat:@"%@",repayModel.totalOverdueCount],
//                                  [NSString stringWithFormat:@"%@",repayModel.curOverdueCount],
//                                  [repayModel.bankFkDatetime convertToDetailDate]
//                                  ];
    
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",repayModel.code],
                                  [NSString stringWithFormat:@"%@",repayModel.realName],
                                  [NSString stringWithFormat:@"%@ %@",repayModel.loanBankName,repayModel.subbranchBankName],
                                  [NSString stringWithFormat:@"%.2f",[repayModel.loanAmount floatValue]/1000],
                                   [NSString stringWithFormat:@"%.2f",[repayModel.monthAmount floatValue]/1000]
                                  ];
    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text =[BaseModel convertNull: InformationArray[i]];
    }
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 230,SCREEN_WIDTH, 1)];
    line.backgroundColor = kLineColor;
    [self addSubview:line];
}

-(void)setConfirmrepayModel:(RepayModel *)ConfirmrepayModel{
    _codeLabel.text = [NSString stringWithFormat:@"%@",ConfirmrepayModel.code];
    _stateLabel.text = [[BaseModel user]note:ConfirmrepayModel.curNodeCode];
    
    NSArray *nameArray = @[
                           @"业务编号",
                           @"贷款人",
                           @"期数",
                           @"当前期数",
                           @"本月还款日",
                           @"月供"];
 
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",ConfirmrepayModel.code],
                                  [NSString stringWithFormat:@"%@",ConfirmrepayModel.user[@"realName"]],
                                  [NSString stringWithFormat:@"%@",ConfirmrepayModel.periods],
                                  [NSString stringWithFormat:@"%@",ConfirmrepayModel.curPeriods],
                                  [NSString stringWithFormat:@"%@",[ConfirmrepayModel.repayDatetime convertDate]],
                                  [NSString stringWithFormat:@"%.2f",[ConfirmrepayModel.repayAmount floatValue]/1000]
                                  ];
    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        nameLabel.backgroundColor = kClearColor;
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text =[BaseModel convertNull: InformationArray[i]];
        InformationLabel.backgroundColor = kClearColor;
    }
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 280,SCREEN_WIDTH, 1)];
    line.backgroundColor = kLineColor;
    [self addSubview:line];
}
-(void)setSettlementAuditModel:(SettlementAuditModel *)settlementAuditModel{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (!self.editing) {
        return;
    }
    [super setSelected:selected animated:animated];
    
    if (self.editing) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIControl * _Nonnull control, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]) {
            
            for (UIView *view in control.subviews) {
                
                if ([view isKindOfClass:[UIImageView class]]) {
                    
                    UIImageView *imageView = (UIImageView *)view;
                    if (self.selected) {
                        //设置选中时的照片
                        imageView.image = [UIImage imageNamed:@"选中"];
                    }else{
                        //设置未选中时的照片
                        imageView.image = [UIImage imageNamed:@"未选中"];
                    }
                }
            }
        }
    }];
}

@end
