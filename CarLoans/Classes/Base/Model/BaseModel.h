//
//  BaseModel.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SurveyModel.h"
@protocol BaseModelDelegate <NSObject>

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid;

-(void)TheReturnValuearr:(NSArray *)arr ;

@end

@interface BaseModel : NSObject

@property (nonatomic, assign) id <BaseModelDelegate> ModelDelegate;



+ (NSString *)getCurrentTime;

+ (instancetype)user;
//是否为需要登录，如果已登录，取出用户信息
- (BOOL)isLogin;
//字符串是否为空
+ (BOOL) isBlankString:(NSString *)string;
+ (BOOL)isBlankDictionary:(NSDictionary *)dic;
+ (NSString*)convertNull:(id)object;
+ (NSString*)convertNullReturnStr:(id)object;
//存储用户信息
- (void)saveUserInfo:(NSDictionary *)userInfo;

- (void)updateUserInfoWithNotification;
//
- (void)CustomBouncedView:(NSMutableArray *)nameArray setState:(NSString *)state;

- (void)CustomBounced:(NSMutableArray *)nameArray setState:(NSString *)state isSign:(BOOL)sign;

-(NSString *)ReturnEnterNameByCode:(NSString *)code;
//选择框数据
-(void )ReturnsParentKeyAnArray:(NSString *)parentKey;
//查找节点
-(NSString *)note:(NSString *)curNodeCode;

-(NSString *)value:(NSString *)code;
//查找角色............
-(NSString *)setParentKey:(NSString *)parentKey setDkey:(NSString *)dkey;
-(NSString *)setParentKey:(NSString *)parentKey setDvalue:(NSString *)dvalue;
-(void)phoneCode:(UIButton *)sender;
-(NSString *)FindUrlWithModel:(SurveyModel *)model ByKname:(NSString *)Kname;

-(NSString *)setCompanyFullName:(NSString *)fullName;
-(NSString *)setCompanyCode:(NSString *)code;
-(void)ReturnsEnterLocation:(NSString *)parentKey;
-(void)AlterImageByUrl:(NSString *)url;
-(NSString *)ReturnBankcardNumberByCode:(NSString *)code;
@end
