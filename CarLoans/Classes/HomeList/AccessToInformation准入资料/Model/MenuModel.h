//
//  MenuModel.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuModel : NSObject

@property (nonatomic , strong)NSArray *menuArray;

@property (nonatomic , strong)NSArray *menuArray1;
@property (nonatomic , strong)NSArray *menuSecondgHandArray1;

@property (nonatomic , strong)NSArray *menuArray2;
@property (nonatomic , strong)NSArray *menuArray3;
@property (nonatomic , strong)NSArray *menuArray4;
@property (nonatomic , strong)NSArray *menuArray5;
@property (nonatomic , strong)NSArray *menuArray6;
@property (nonatomic , strong)NSArray *usedCarMenuArray6;
@property (nonatomic , strong)NSArray *menuArray7;
@property (nonatomic , strong)NSArray *menuArray8;
@property (nonatomic , strong)NSArray *menuArray9;




//新增贷款人信息
@property (nonatomic , strong)NSArray *newLenderArray;
//完善主贷人信息
@property (nonatomic , strong)NSArray *improveInformationArray;
//身份证信息
@property (nonatomic , strong)NSArray *idInformationArray;

@property (nonatomic , strong)NSArray *homeArray;
@property (nonatomic , strong)NSArray *detailsInfoArray;

@property (nonatomic , strong)NSArray *detailsMenuArray;

@end

NS_ASSUME_NONNULL_END
