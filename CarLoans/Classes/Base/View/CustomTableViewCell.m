//
//  CustomTableViewCell.m
//  CarLoans
//
//  Created by shaojianfei on 2018/10/25.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

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
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
        int k = 0;
       
            k = 7;
       
        
        for (int i = 0; i < k; i ++) {
            _nameLabel = [UILabel labelWithFrame:CGRectMake(15 , 70 + i % k * 35, 100, 15) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:GaryTextColor];
            //            _nameLabel.text = nameArray[i];
            _nameLabel.tag = 100000 + i;
            [self addSubview:_nameLabel];
            
            _InformationLabel = [UILabel labelWithFrame:CGRectMake(115 , 70 + i % k * 35, SCREEN_WIDTH - 130, 15) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:HGfont(14) textColor:TextColor];
            _InformationLabel.tag = 1000000 + i;
            [self addSubview:_InformationLabel];
        }
        if (k == 13) {
            UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 279+70+90+60, SCREEN_WIDTH, 1)];
            lineView2.backgroundColor = LineBackColor;
            [self addSubview:lineView2];
            _button = [UIButton buttonWithTitle:@"确认提交银行" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
            _button.frame = CGRectMake(SCREEN_WIDTH - 115, 290+60+90+60, 100, 30);
            kViewBorderRadius(_button, 5, 1, MainColor);
            [self addSubview:_button];
            _button.hidden = YES;
        }else if(k == 11)
        {
            
            UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 279, SCREEN_WIDTH, 1)];
            lineView2.backgroundColor = LineBackColor;
            [self addSubview:lineView2];
            _button = [UIButton buttonWithTitle:@"确认提交银行" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
            _button.frame = CGRectMake(SCREEN_WIDTH - 115, 290, 100, 30);
            kViewBorderRadius(_button, 5, 1, MainColor);
            [self addSubview:_button];
            _button.hidden = YES;
        }
        
        else{
            UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 279, SCREEN_WIDTH, 1)];
            lineView2.backgroundColor = LineBackColor;
            [self addSubview:lineView2];
            _button = [UIButton buttonWithTitle:@"确认提交银行" titleColor:MainColor backgroundColor:kClearColor titleFont:15];
            _button.frame = CGRectMake(SCREEN_WIDTH - 115, 290, 100, 30);
            kViewBorderRadius(_button, 5, 1, MainColor);
            [self addSubview:_button];
            _button.hidden = YES;
        }
        
        
        
        
    }
    return self;
}


//资信调查
-(void)setSurveyModel:(SurveyModel *)surveyModel
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",surveyModel.code];
    _stateLabel.text = [[BaseModel user]note:surveyModel.curNodeCode];
    
    NSLog(@"%@",[[BaseModel user]note:surveyModel.curNodeCode]);
    NSArray *nameArray = @[
                           @"业务种类",
                           @"客户姓名",
                           @"贷款金额",
                           @"贷款银行",
                           @"驻行内勤",
                           @"申请时间"];
    NSString *bizType;
    if ([surveyModel.bizType integerValue] == 0) {
        bizType = @"新车";
    }
    else
    {
        bizType = @"二手车";
    }
    
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",bizType],
                                  [NSString stringWithFormat:@"%@",surveyModel.creditUser[@"userName"]],
                                  [NSString stringWithFormat:@"%.2f",[surveyModel.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",surveyModel.loanBankName],
                                  [NSString stringWithFormat:@"%@",surveyModel.operatorName],
                                  [NSString stringWithFormat:@"%@",[surveyModel.applyDatetime convertToDetailDate]]];
    
    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text =[BaseModel convertNull: InformationArray[i]];
    }
}


//准入单     车辆抵押    车辆落户
-(void)setAccessSingleModel:(AccessSingleModel *)accessSingleModel
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",accessSingleModel.code];
    _stateLabel.text = [[BaseModel user]note:accessSingleModel.curNodeCode];
    
    NSLog(@"%@",[[BaseModel user]note:accessSingleModel.curNodeCode]);
    NSArray *nameArray = @[
                           @"业务种类",
                           @"客户姓名",
                           @"贷款金额",
                           @"贷款银行",
                           @"是否垫资",
                           @"申请时间"];
    NSString *bizType;
    if ([accessSingleModel.bizType integerValue] == 0) {
        bizType = @"新车";
    }
    else
    {
        bizType = @"二手车";
    }
    NSString *isAdvanceFund;
    if ([accessSingleModel.isAdvanceFund isEqualToString:@"1"]) {
        isAdvanceFund = @"已垫资";
    }else
    {
        isAdvanceFund = @"未垫资";
    }
    NSArray *InformationArray = @[
                                  [NSString stringWithFormat:@"%@",bizType],
                                  [NSString stringWithFormat:@"%@",accessSingleModel.applyUserName],
                                  [NSString stringWithFormat:@"%.2f",[accessSingleModel.loanAmount floatValue]/1000],
                                  [NSString stringWithFormat:@"%@",accessSingleModel.loanBankName],
                                  isAdvanceFund,
                                  [NSString stringWithFormat:@"%@",[accessSingleModel.applyDatetime convertToDetailDate]]];
    
    for (int i = 0; i < nameArray.count; i ++ ) {
        UILabel *nameLabel = [self viewWithTag:100000 + i];
        nameLabel.text = nameArray[i];
        UILabel *InformationLabel = [self viewWithTag:1000000 + i];
        InformationLabel.text = [BaseModel convertNull:InformationArray[i]];
    }
}


//资料传递
-(void)setDataTransferModel:(DataTransferModel *)dataTransferModel
{
    _codeLabel.text = [NSString stringWithFormat:@"%@",dataTransferModel.bizCode];
    //    _stateLabel.text = [[BaseModel user]note:accessSingleModel.curNodeCode];
    NSArray *nameArray;
    if (self.isGps == YES) {
        nameArray = @[
                      @"申请人",
                      @"快递公司",
                      @"快递单号",
                      @"发件人",
                      @"收件人",
                      @"业务团队",
                      @"信贷专员",
                      @"内勤",
                      @"GPS无线个数",
                      @"GPS有线个数",
                      @"快递状态"];
    }else{
        nameArray = @[
                      @"发件节点",
                      @"收件节点",
                      @"客户姓名",
                      @"快递公司",
                      @"快递单号",
                      @"发件人",
                      @"收件人",
                      @"业务团队",
                      @"信贷专员",
                      @"内勤专员",
                      @"快递状态"];
    }
    //    NSArray *nameArray = @[
    //                           @"发件节点",
    //                           @"收件节点",
    //                           @"客户姓名",
    //                           @"快递公司",
    //                           @"快递单号",
    //                           @"发件人",
    //                           @"收件人",
    //                           @"业务团队",
    //                           @"信贷专员",
    //                           @"内勤专员",
    //                           @"快递状态"];
    //    (0 待发件 1已发件待收件 2已收件审核 3已收件待补件)
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
    NSArray *InformationArray;
    if (self.isGps == YES) {
        InformationArray = @[
                             [NSString stringWithFormat:@"%@",dataTransferModel.receiverName],
                             [NSString stringWithFormat:@"%@",[[BaseModel user] setParentKey:@"kd_company" setDkey:dataTransferModel.logisticsCompany]],
                             [NSString stringWithFormat:@"%@",dataTransferModel.logisticsCode],
                             [NSString stringWithFormat:@"%@",dataTransferModel.senderName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.receiverName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.teamName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.saleUserName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.insideJobName],
                             [NSString stringWithFormat:@"%@",dataTransferModel.gpsApply[@"applyWiredCount"]],
                             [NSString stringWithFormat:@"%@",dataTransferModel.gpsApply[@"applyWirelessCount"]],
                             
                             
                             state];
    }else{
        InformationArray = @[
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:dataTransferModel.fromNodeCode]],
                             [NSString stringWithFormat:@"%@",[[BaseModel user]note:dataTransferModel.toNodeCode]],
                             [NSString stringWithFormat:@"%@",dataTransferModel.customerName],
                             [NSString stringWithFormat:@"%@",[[BaseModel user] setParentKey:@"kd_company" setDkey:dataTransferModel.logisticsCompany]],
                             [NSString stringWithFormat:@"%@",dataTransferModel.logisticsCode],
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
        InformationLabel.text = [BaseModel convertNull: InformationArray[i]];
    }
}

@end
