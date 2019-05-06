//
//  SurveyACreditTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

@interface SurveyACreditTableView : TLTableView

@property (nonatomic , copy)NSString *bankStr;

@property (nonatomic , copy)NSString *speciesStr;

@property (nonatomic , strong)NSArray *peopleAray;

@property (nonatomic , copy)NSString *secondCarReport;

//    行驶证正面
@property (nonatomic , copy)NSString *idNoFront;
//     行驶证反面
@property (nonatomic , copy)NSString *idNoReverse;

@end
