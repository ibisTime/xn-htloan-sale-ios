//
//  SurveyACreditTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
@protocol SelectButtonDelegate <NSObject>

-(void)selectButtonClick:(UIButton *)sender;

@end
@interface SurveyACreditTableView : TLTableView
@property (nonatomic, assign) id <SelectButtonDelegate> ButtonDelegate;
@property (nonatomic , copy)NSString *bankStr;

@property (nonatomic , copy)NSString *speciesStr;

@property (nonatomic , strong)NSMutableArray *peopleAray;

@property (nonatomic , copy)NSString *secondCarReport;

//    行驶证正面
@property (nonatomic , copy)NSString *xszFront;
//     行驶证反面
@property (nonatomic , copy)NSString *xszReverse;


@property (nonatomic,strong) NSArray * carinfo;




@end
