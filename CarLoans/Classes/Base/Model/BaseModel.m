//
//  BaseModel.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BaseModel.h"
#import "SelectedListView.h"
#import "LEEAlert.h"
#import "NewSelectedListView.h"
@implementation BaseModel

+ (instancetype)user{

    static BaseModel *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[BaseModel alloc] init];
    });

    return user;
}

-(void)phoneCode:(UIButton *)sender
{
    __block NSInteger time = 59;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(time <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [sender setTitle:@"重新发送" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
                kViewBorderRadius(sender, 2, 1, kAppCustomMainColor);
                [sender setTitleColor:kAppCustomMainColor forState:(UIControlStateNormal)];
            });
        }else{
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [sender setTitle:[NSString stringWithFormat:@"%@(%.2d)",@"重新发送", seconds] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
                [sender setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
                kViewBorderRadius(sender, 2, 1, [UIColor grayColor]);
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}


- (BOOL)isLogin {
    NSString *userId = [USERDEFAULTS objectForKey:USER_ID];
    NSString *token = [USERDEFAULTS objectForKey:TOKEN_ID];
    NSLog(@"%@===%@",userId,token);
    if ([BaseModel isBlankString:userId] == NO && [BaseModel isBlankString:token] == NO) {

        return YES;
    } else {

        return NO;
    }
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL )
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }

    return NO;
}

+ (NSString*)convertNull:(id)object{

    // 转换空串

    if ([object isEqual:[NSNull null]]) {
        return @"";
    }
    else if ([object isEqualToString:@""])
    {
        return @"";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if ([object isEqualToString:@"(null)"])
    {
        return @"";
    }
    else if (object==nil){
        return @"";
    }
    return object;

}

+ (NSString*)convertNullReturnStr:(id)object{
    
    // 转换空串
    
    if ([object isEqual:[NSNull null]]) {
        return @"暂无";
    }
    else if ([object isEqualToString:@""])
    {
        return @"暂无";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"暂无";
    }
    else if ([object isEqualToString:@"(null)"])
    {
        return @"暂无";
    }
    else if (object==nil){
        return @"暂无";
    }
    return object;
    
}


+ (BOOL)isBlankDictionary:(NSDictionary *)dic {
    
    if (!dic) {
       return YES;
    }
    if ([dic isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if (!dic.count) {
        return YES;
    }
    if (dic == nil) {
        return YES;
    }
    if (dic == NULL) {
        return YES;
    }
    return NO;
}



-(NSString *)note:(NSString *)curNodeCode
{
    NSString *name;
    NSArray *array = [USERDEFAULTS objectForKey:NODE];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"code"] isEqualToString:curNodeCode]) {
            name = array[i][@"name"];
        }
    }
    return name;
}
-(NSString *)value:(NSString *)code{
    NSString * name;
    NSArray * array =[USERDEFAULTS objectForKey:BOUNCEDDATA];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"parentKey"] isEqualToString:@"send_type"]) {
            if([array[i][@"dkey"] isEqualToString:code]){
                name = array[i][@"dvalue"];
            }
        }
    }
    return name;
}

-(void)ReturnsParentKeyAnArray:(NSString *)parentKey
{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *array = [USERDEFAULTS objectForKey:BOUNCEDDATA];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"parentKey"] isEqualToString:parentKey]) {
            [dataArray addObject:array[i]];
        }
    }
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i = 0; i < dataArray.count; i ++) {
        [array1 addObject:dataArray[i]];
    }
    [self CustomBouncedView:array1 setState:@""];
}

//弹框
-(void)CustomBouncedView:(NSMutableArray *)nameArray setState:(NSString *)state
{
    NSMutableArray *dvalueArray = [NSMutableArray array];
    if ([state isEqualToString:@"100"]) {
        dvalueArray = nameArray;
    }else
    {
        for (int i = 0; i < nameArray.count ; i ++) {
            [dvalueArray addObject:nameArray[i][@"dvalue"]];
        }
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0;  i < dvalueArray.count; i ++) {
        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",dvalueArray[i]]]];
    }
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = YES;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            NSLog(@"选中的%@" , array);
            SelectedListModel *model = array[0];
            [self.ModelDelegate TheReturnValueStr:model.title selectDic:nameArray[model.sid] selectSid:model.sid];
        }];
    };
    [LEEAlert alert].config
    .LeeTitle(@"选择")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
}

-(void)CustomBounced:(NSMutableArray *)nameArray setState:(NSString *)state isSign:(BOOL)sign
{
    
    NSMutableArray *dvalueArray = [NSMutableArray array];
    if ([state isEqualToString:@"100"]) {
        dvalueArray = nameArray;
    }else
    {
        for (int i = 0; i < nameArray.count ; i ++) {
            [dvalueArray addObject:nameArray[i][@"dvalue"]];
        }
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0;  i < dvalueArray.count; i ++) {
        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",dvalueArray[i]]]];
    }
    NewSelectedListView *view = [[NewSelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    view.isSingle = NO;
    view.array = array;
    view.selectedBlock = ^(NSArray<SelectedListModel *> *array) {
        [LEEAlert closeWithCompletionBlock:^{
            NSLog(@"选中的%@" , array);
            SelectedListModel *model = array[0];
            [self.ModelDelegate TheReturnValueStr:model.title selectDic:nameArray[model.sid] selectSid:model.sid];
        }];
    };
    view.changedBlock = ^(NSArray<SelectedListModel *> *array) {
        [self.ModelDelegate TheReturnValuearr:array];
    };
    [LEEAlert alert].config
    .LeeTitle(@"选择")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
}


-(NSString *)setParentKey:(NSString *)parentKey setDkey:(NSString *)dkey
{
    NSString *dvalue;
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *array = [USERDEFAULTS objectForKey:BOUNCEDDATA];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"parentKey"] isEqualToString:parentKey]) {
            [dataArray addObject:array[i]];
        }
    }
    for (int i = 0; i < dataArray.count; i ++) {
        if ([dataArray[i][@"dkey"] isEqualToString:dkey]) {
            dvalue = dataArray[i][@"dvalue"];
        }
    }
    return dvalue;
}


-(NSString *)setParentKey:(NSString *)parentKey setDvalue:(NSString *)dvalue
{
    NSString *dkey;
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *array = [USERDEFAULTS objectForKey:BOUNCEDDATA];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"parentKey"] isEqualToString:parentKey]) {
            [dataArray addObject:array[i]];
        }
    }
    for (int i = 0; i < dataArray.count; i ++) {
        if ([dataArray[i][@"dvalue"] isEqualToString:dvalue]) {
            dkey = dataArray[i][@"dkey"];
        }
    }
    return dkey;
}
+ (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // yyyy-MM-dd 可自定义，也可以换成 yyyy-MM-dd HH:MM:SS
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
-(NSString *)FindUrlWithModel:(SurveyModel *)model ByKname:(NSString *)Kname{
    NSString * string;
    NSLog(@"%ld",model.attachments.count)
    for (int i = 0; i < model.attachments.count; i++) {
        if ([Kname isEqualToString:model.attachments[i][@"kname"]]) {
            string = model.attachments[i][@"url"];
        }
    }
    return string;
}
-(NSString *)setCompanyCode:(NSString *)code{
    NSString *fullname;
    NSArray *array = [USERDEFAULTS objectForKey:COMPANYNODE];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"code"] isEqualToString:code]) {
            fullname = array[i][@"fullName"];
        }
    }
    return fullname;
}
-(NSString *)setCompanyFullName:(NSString *)fullName{
    NSString *code;
//    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *array = [USERDEFAULTS objectForKey:COMPANYNODE];
    for (int i = 0; i < array.count; i ++) {
        if ([array[i][@"fullName"] isEqualToString:fullName]) {
            code = array[i][@"code"];
        }
    }
    return code;
}
@end
