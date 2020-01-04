//
//  MenuModel.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel

-(NSArray *)menuArray
{
    if (!_menuArray) {
        _menuArray = @[@"基本信息",@"主贷人信息",@"紧急联系人",@"贷款信息",@"费用信息",@"车辆信息",@"贷款材料图",@"上门调查图",@"车辆图"];
    }
    return _menuArray;
}



-(NSArray *)menuArray1
{
    if (!_menuArray1) {
        _menuArray1 = @[@"*业务员",@"*经办银行",@"*业务发生地",@"*汽车经销商",@"*购车途径",@"*品牌",@"*车系",@"*车型"];
    }
    return _menuArray1;
}

-(NSArray *)menuSecondgHandArray1
{
    if (!_menuSecondgHandArray1) {
        _menuSecondgHandArray1 = @[@"*业务员",@"*经办银行",@"*业务发生地",@"*汽车经销商",@"*购车途径",@"*品牌",@"*车系",@"*车型",@"*上牌时间",@"*公里数(万)",@"*评估报告"];
    }
    return _menuSecondgHandArray1;
}

-(NSArray *)menuArray4
{
    if (!_menuArray4) {
        _menuArray4 = @[@"*贷款本金",
                        @"*贷款期数",
                        @"*银行利率",
                        @"*总利率%",
                        @"*返存利率%",
                        @"*是否垫资",
                        @"*月供",
                        @"*首月还款额",
                        @"*开卡金额",
                        @"贴息利率%",
                        @"贴息金额",
                        @"发票价格",
                        @"贷款成数",
                        @"开票日期",
                        @"利率类型",
                        @"服务费",
                        @"是否贴息",
                        @"高抛金额",
                        @"费用总额",
                        @"客户承担利率%",
                        @"附加费费率%",
                        @"附加费",
                        @"备注事项"
                        ];
    }
    return _menuArray4;
}


-(NSArray *)menuArray5
{
    if (!_menuArray5) {
        _menuArray5 = @[@"*GPS费",
                        @"担保风险金",
                        @"履约押金",
                        @"其他费用",
                        @"车款1",
                        @"车款2",
                        @"车款3",
                        @"车款4",
                        @"车款5"];
    }
    return _menuArray5;
}

-(NSArray *)menuArray6
{
    if (!_menuArray6) {
        _menuArray6 = @[@"车辆型号",
                        @"厂商指导价",
                        @"车架号",
                        @"发动机",
                        @"车牌号",
                        @"行驶里程(万)",
                        @"评估价格",
                        @"上牌时间",
                        @"上牌地",
                        @"是否公牌"];
    }
    return _menuArray6;
}

-(NSArray *)newLenderArray
{
    if (!_newLenderArray) {
        _newLenderArray = @[@"*贷款人关系",
                            @"*资料上传",
                            @"身份证信息",
                            @"*手机号",
                            @"*征信结果",
                            @"*征信说明",
                            @"完善主贷人信息"];
    }
    return _newLenderArray;
}

-(NSArray *)improveInformationArray
{
    if (!_improveInformationArray) {
        _improveInformationArray = @[@"教育程度",
                                     @"住宅",
                                     @"住宅详细地址",
                                     @"住宅电话",
                                     @"入住日期",
                                     @"住宅状况",
                                     @"婚姻状况",
                                     @"住房类型",
                                     @"工作单位",
                                     @"单位地址",
                                     @"单位详细地址",
                                     @"单位性质",
                                     @"何时进入单位",
                                     @"职业",
                                     @"月收入",
                                     @"现职年数",
                                     @"常住类型"];
    }
    return _improveInformationArray;
}


-(NSArray *)idInformationArray
{
    if (!_idInformationArray) {
        _idInformationArray = @[@"姓名",
                                @"性别",
                                @"民族",
                                @"出生日期",
                                @"签发机关",
                                @"户籍地",
                                @"有效期开始",
                                @"有效期结束",
                                @"证件号"];
    }
    return _idInformationArray;
}

-(NSArray *)detailsInfoArray
{
    if (!_detailsInfoArray) {
        _detailsInfoArray = @[@"业务编号",
                              @"主贷人",
                              @"经办银行",
                              @"业务种类",
                              @"贷款金额",
                              @"当前节点",
                              @"开始时间",
                              @"对应业务员"];
    }
    return _detailsInfoArray;
}

-(NSArray *)homeArray
{
    if (!_homeArray) {
        _homeArray = @[@"准入资料",@"准入审核",@"用款申请",@"用款审核",@"制单回录",@"垫资回录",@"理件",@"打件",@"银行收件",@"银行提交",@"录入放款",@"确认收款",@"发送抵押",@"确认抵押",@"入档"];
    }
    return _homeArray;
}


-(NSArray *)detailsMenuArray
{
    if (!_detailsMenuArray) {
        _detailsMenuArray = @[@"基本信息",@"主贷人信息",@"紧急联系人",@"贷款信息",@"费用信息",@"车辆信息",@"贷款材料图",@"上门调查图",@"车辆图",@"垫资详情",@"理件详情",@"放款详情",@"入档详情",@"操作日志",@"还款计划"];
    }
    return _detailsMenuArray;
}


@end
