//
//  SettlementAuditCell.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/24.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "SettlementAuditCell.h"

@implementation SettlementAuditCell


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
        
        [self addSubview:self.codeLabel];
        [self addSubview:self.stateLabel];
        
        
        _button = [UIButton buttonWithTitle:@"审核" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
        _button.frame = CGRectMake(SCREEN_WIDTH - 115, 300, 100, 30);
        kViewBorderRadius(_button, 5, 1, MainColor);
        [self addSubview:_button];
        //        _button.hidden = YES;
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
        
        
        
        
        for (int i = 0; i < 8; i ++) {
            _nameLabel = [UILabel labelWithFrame:CGRectMake(15 , 70 + i % 8 * 35, 100, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];
            //            _nameLabel.text = nameArray[i];
            _nameLabel.tag = 100000 + i;
            [self addSubview:_nameLabel];
            
            _InformationLabel = [UILabel labelWithFrame:CGRectMake(115 , 70 + i % 8 * 35, SCREEN_WIDTH - 130, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:TextColor];
            _InformationLabel.tag = 1000000 + i;
            [self addSubview:_InformationLabel];
        }
        
        
    }
    return self;
}
-(void)setSettlementAuditModel:(SettlementAuditModel *)settlementAuditModel
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",settlementAuditModel.code];
    _stateLabel.text = [[BaseModel user]note:settlementAuditModel.curNodeCode];
    NSArray *nameArray = @[
                           @"业务种类",
                           @"客户姓名",
                           @"贷款金额",
                           @"剩余欠款",
                           @"未还清收成本",
                           @"未还代偿金额",
                           @"扣除履约保证金",
                           @"是否提前还款"];
    NSString *bizType;
    if ([settlementAuditModel.bizType integerValue] == 0) {
        bizType = @"新车";
    }
    else
    {
        bizType = @"二手车";
    }
    
    NSArray *InformationArray = @[
                                  bizType,
                                  [NSString stringWithFormat:@"%@",settlementAuditModel.realName],
                                  [NSString stringWithFormat:@"%.2f",[settlementAuditModel.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%.2f",[settlementAuditModel.restAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%.2f",[settlementAuditModel.restTotalCost floatValue]/1000],
                                  [NSString stringWithFormat:@"%.2f",[settlementAuditModel.unRepayTotalAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%.2f",[settlementAuditModel.cutLyDeposit floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",[settlementAuditModel.isAdvanceSettled isEqualToString:@"1"]?@"是":@"否"]
                                  ];
    
    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text = InformationArray[i];
    }
    
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
