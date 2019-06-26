//
//  CarModel.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarModel : NSObject
@property (nonatomic,copy) NSString * totalCount;
@property (nonatomic,copy) NSString * code;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * seriesCode;
@property (nonatomic,copy) NSString * seriesName;
@property (nonatomic,copy) NSString * brandCode;
@property (nonatomic,copy) NSString * brandName;
@property (nonatomic,copy) NSString * originalPrice;
@property (nonatomic,copy) NSString * salePrice;
@property (nonatomic,copy) NSString * sfAmount;
@property (nonatomic,copy) NSString * orderNo;
@property (nonatomic,copy) NSString * slogan;
@property (nonatomic,copy) NSString * advPic;
@property (nonatomic,copy) NSString * pic;
@property (nonatomic,copy) NSString * Description;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * updater;
@property (nonatomic,copy) NSString * updateDatetime;
@property (nonatomic,copy) NSString * remark;
@property (nonatomic,copy) NSString * letter;
@property (nonatomic,copy) NSString * logo;
@property (nonatomic,copy) NSString * picNumber;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * highest;
@property (nonatomic,copy) NSString * lowest;
@property (nonatomic,copy) NSString * level;
@property (nonatomic,copy) NSString * isReferee;
@property (nonatomic,copy) NSString * fromPlace;
@property (nonatomic,copy) NSString * procedure;
@property (nonatomic,copy) NSString * isCollect;
@property (nonatomic,copy) NSString * collectNumber;
@property (nonatomic,copy) NSString * version;
@property (nonatomic,copy) NSString * outsideColor;
@property (nonatomic,copy) NSString * insideColor;
@property (nonatomic,strong) NSArray *cars;
@property (nonatomic,strong) NSArray *caonfigList;
@property (nonatomic,strong) NSArray *configs;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,copy) NSString * brandLogo;

+(NSDictionary *)mj_replacedKeyFromPropertyName;
@end

NS_ASSUME_NONNULL_END
