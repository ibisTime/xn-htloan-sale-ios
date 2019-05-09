//
//  TopModel.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/30.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TopModel.h"

@implementation TopModel


+ (instancetype)user{
    
    static TopModel *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[TopModel alloc] init];
    });
    
    return user;
}

-(NSArray *)ary1
{
    if (!_ary1) {
        _ary1 = @[@"*贷款银行",@"*贷款期限",@"银行利率",@"*贷款金额",@"*贷款产品",@"*GPS费用",@"*公证费用",@"*开票价(元)",@"*首付金额（元）",@"*首付比例",@"*是否融资",@"*是否垫资",@"*是否安装GPS",@"*是否我司续保",@"*月供保证金(元)",@"*服务费(元)",@"*其他费用(元)"];
    }
    return _ary1;
}

-(NSArray *)ary2
{
    if (!_ary2) {
        _ary2 = @[@"*业务类型",@"*机动车销售公司",@"*开票单位",@"*车辆类型",@"*车辆品牌",@"*车辆车系",@"*车辆车型",@"*车辆颜色",@"*车架号",@"*发动机号",@"*市场指导价(元)",@"*所属区域",@"*厂家贴息(元)",@"*油补公里数",@"油补（元）",@"*落户地点"];
    }
    return _ary2;
}

-(NSArray *)ary3
{
    if (!_ary3) {
        _ary3 = @[@"*姓名",@"*电话",@"*身份证",@"*性别",@"*年龄",@"*民族",@"*政治面貌",@"*学历",@"职业",@"职称",@"*有无驾照",@"现有车辆",@"*主要收入来源",@"*紧急联系人1",@"*与主贷人关系",@"*手机号码",@"*紧急联系人2",@"*与主贷人关系",@"*手机号码"];
    }
    return _ary3;
}

-(NSArray *)ary4
{
    if (!_ary4) {
        _ary4 = @[@"*婚姻状况",@"*家庭人口",@"*家庭电话",@"*家庭主要财产（元）",@"*家庭主要财产说明",@"*户籍地（省市区）",@"详细地址",@"*户籍地邮编",@"*居住地（省市区）",@"详细地址",@"*居住地邮编",@"现住房屋类型"];
    }
    return _ary4;
}

-(NSArray *)ary5
{
    if (!_ary5) {
        _ary5 = @[@"所属行业",@"*单位经济性质",@"*工作单位名称",@"*工作单位地址",@"工作单位电话",@"何时进入该单位",@"职务",@"*月收入(元)",@"工作描述及还款来源分析",@"员工数量",@"企业月产值(万元)"];
    }
    return _ary5;
}

-(NSArray *)ary6
{
    if (!_ary6) {
        _ary6 = @[@"*姓名",@"*与主贷人关系",@"*手机号",@"*身份证号",@"*学历",@"*户籍地（省市区）",@"*户籍地（详细地址）",@"*户籍地邮编",@"*工作单位名称",@"*工作单位地址",@"*工作单位电话"];
    }
    return _ary6;
}

-(NSArray *)ary7
{
    if (!_ary7) {
        _ary7 = @[@"*姓名",@"*与主贷人关系",@"*手机号",@"*身份证号",@"*学历",@"*户籍地（省市区）",@"*户籍地（详细地址）",@"*户籍地邮编",@"*工作单位名称",@"*工作单位地址",@"*工作单位电话"];
    }
    return _ary7;
}


-(NSArray *)newWaterAry
{
    if (!_newWaterAry) {
        _newWaterAry = @[@"征信人",@"分类",@"流水：开始时间",@"流水：结束时间",@"结息时间1（月）",@"结息时间2（月）",@"结息1（元）",@"结息2（元）",@"总收入（元）",@"总支出（元）",@"月均收入（元）",@"月均支出（元）",@"账户余额（元）",@"流水明细"];
    }
    return _newWaterAry;
}

@end
