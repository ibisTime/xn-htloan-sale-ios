//
//  SurveyModel.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/20.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SurveyModel.h"

@implementation SurveyModel

-(NSString *)bizTypeStr
{
    if (!_bizTypeStr) {
        if ([_bizType integerValue] == 0) {
            _bizTypeStr = @"新车";
        }
        else
        {
            _bizTypeStr = @"二手车";
        }
    }
    return _bizTypeStr;
}

@end
