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

//查询未读消息条数
+(void)QueriesNumberOfUnreadMessageBars
{
//    if ([USERDEFAULTS objectForKey:TOKEN_ID]) {
//        TLNetworking * http = [[TLNetworking alloc]init];
//        http.code = @"805309";
//        http.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
//        [http postWithSuccess:^(id responseObject) {
//            [USERDEFAULTS setObject:responseObject[@"data"] forKey:@"unreadnumber"];
//            [[XGPush defaultManager] setXgApplicationBadgeNumber:[responseObject[@"data"] integerValue]];
//        } failure:^(NSError *error) {
//
//        }];
//
//    }
}

+ (BOOL) isBlankString:(NSString *)string {
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    else if ([string isEqualToString:@""])
    {
        return YES;
    }
    else if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if ([string isEqualToString:@"(null)"])
    {
        return YES;
    }
    else if (string==nil){
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
    else if ([object isEqualToString:@"0.00"]){
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
    [self CustomBouncedView:array1 setState:@"1001"];
}
-(void)ReturnsEnterLocation:(NSString *)parentKey{
    NSMutableArray *dataArray = [NSMutableArray array];
    NSArray *array = [USERDEFAULTS objectForKey:ENTERLOCATION];
    for (int i = 0; i < array.count; i ++) {
//        if ([array[i][@"parentKey"] isEqualToString:parentKey]) {
            [dataArray addObject:array[i]];
//        }
    }
    NSMutableArray *array1 = [NSMutableArray array];
    for (int i = 0; i < dataArray.count; i ++) {
        [array1 addObject:dataArray[i]];
    }
    [self CustomBouncedView:array1 setState:@"1"];
}
-(NSString *)ReturnEnterNameByCode:(NSString *)code{
    NSString * name;
    NSArray *array = [USERDEFAULTS objectForKey:ENTERLOCATION];
    for (int i = 0; i < array.count; i++) {
        if ([array[i][@"code"] isEqualToString:code]) {
            name = array[i][@"name"];
        }
    }
    return name;
}
-(NSString *)ReturnLocationNameByCode:(NSString *)code{
    NSString * name;
    NSArray *array = [USERDEFAULTS objectForKey:ENTERLOCATION];
    for (int i = 0; i < array.count; i++) {
        if ([array[i][@"code"] isEqualToString:code]) {
            name = array[i][@"location"];
        }
    }
    return name;
}

//弹框
-(void)CustomBouncedView:(NSMutableArray *)nameArray setState:(NSString *)state
{
    NSMutableArray *dvalueArray = [NSMutableArray array];
    if ([state isEqualToString:@"100"]) {
        dvalueArray = nameArray;
    }
    else if ([state isEqualToString:@"1"]){
        for (int i = 0; i < nameArray.count ; i ++) {
            [dvalueArray addObject:nameArray[i][@"name"]];
        }
    }
    else if ([state isEqualToString:@"666"]){
        for (int i = 0; i < nameArray.count ; i ++) {
            [dvalueArray addObject:nameArray[i][@"gpsDevNo"]];
        }
    }
    else if ([state isEqualToString:@"1000"]){
        for (int i = 0; i < nameArray.count ; i ++) {
            [dvalueArray addObject:[NSString stringWithFormat:@"%@", nameArray[i][@"dkey"]]];
        }
    }
    else
    {
        for (int i = 0; i < nameArray.count ; i ++) {
            [dvalueArray addObject:nameArray[i][@"dvalue"]];
        }
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0;  i < dvalueArray.count; i ++) {
        [array addObject:[[SelectedListModel alloc] initWithSid:i Title:[NSString stringWithFormat:@"%@",dvalueArray[i]]]];
    }
    SelectedListView *view = [[SelectedListView alloc] initWithFrame:CGRectMake(0, 0, 300, 0) style:UITableViewStylePlain];
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

//根据key获取附件池图片
+(NSString *)GetImgAccordingKeyAttachments:(NSArray *)attachments kname:(NSString *)kname
{
    for (int i = 0; i < attachments.count; i ++) {
        if ([attachments[i][@"kname"] isEqualToString:kname]) {
            return attachments[i][@"url"];
        }
    }
    return @"";
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

+(NSString *)Cheng1000:(NSString *)num
{
    NSString *num1 = [NSString stringWithFormat:@"%@",num];
    if ([num1 floatValue] == 0) {
        return @"0";
    }
    return [BaseModel CHENGmult1:num1 mult2:@"1000" scale:0];
//    [NSString stringWithFormat:@"%.0f",[num floatValue] * 1000];
}

+(NSString *)Chu1000:(NSString *)num
{
    NSString *num1 = [NSString stringWithFormat:@"%@",num];
    if ([num1 floatValue] == 0) {
        return @"";
    }
    return [BaseModel CHUmult1:num1 mult2:@"1000" scale:2];
//    [NSString stringWithFormat:@"%.2f",[num floatValue] / 1000];
}



+(NSString *)Cheng100:(NSString *)num
{
    NSString *num1 = [NSString stringWithFormat:@"%@",num];
    if ([num1 floatValue] == 0) {
        return @"";
    }
    return [BaseModel CHENGmult1:num1 mult2:@"100" scale:4];
}

+(NSString *)Chu100:(NSString *)num
{
    NSString *num1 = [NSString stringWithFormat:@"%@",num];
    if ([num1 floatValue] == 0) {
        return @"0";
    }
//[NSString stringWithFormat:@"%.6f",[num floatValue] / 100]
    return [BaseModel CHUmult1:num1 mult2:@"100" scale:4];
}


+ (NSString *)CHENGmult1:(NSString *)mult1 mult2:(NSString *)mult2 scale:(NSUInteger)scale{
    if ([mult1 isEqualToString:@""] || [mult2 isEqualToString:@""]) {
        return @"0";
    }
    NSDecimalNumber *mult1Num = [[NSDecimalNumber alloc] initWithString:mult1];
    NSDecimalNumber *mult2Num = [[NSDecimalNumber alloc] initWithString:mult2];
    NSDecimalNumber *result = [mult1Num decimalNumberByMultiplyingBy:mult2Num];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler  decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                              scale:scale
                                                                                   raiseOnExactness:NO
                                                                                    raiseOnOverflow:NO
                                                                                   raiseOnUnderflow:NO
                                                                                raiseOnDivideByZero:YES];
    
    return [[result decimalNumberByRoundingAccordingToBehavior:roundUp] stringValue];
    
}

+ (NSString *)CHUmult1:(NSString *)mult1 mult2:(NSString *)mult2 scale:(NSUInteger)scale{
    if ([mult1 floatValue] == 0 || [mult2 floatValue]  == 0) {
        return @"0";
    }
    NSDecimalNumber *mult1Num = [[NSDecimalNumber alloc] initWithString:mult1];
    NSDecimalNumber *mult2Num = [[NSDecimalNumber alloc] initWithString:mult2];
    NSDecimalNumber *result = [mult1Num decimalNumberByDividingBy:mult2Num];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler  decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                              scale:scale
                                                                                   raiseOnExactness:NO
                                                                                    raiseOnOverflow:NO
                                                                                   raiseOnUnderflow:NO
                                                                                raiseOnDivideByZero:YES];
    
    return [[result decimalNumberByRoundingAccordingToBehavior:roundUp] stringValue];
    
}

+ (NSString *)JIANGmult1:(NSString *)mult1 mult2:(NSString *)mult2 scale:(NSUInteger)scale{
    if ([mult1 isEqualToString:@""] || [mult2 isEqualToString:@""]) {
        return @"0";
    }
    NSDecimalNumber *mult1Num = [[NSDecimalNumber alloc] initWithString:mult1];
    NSDecimalNumber *mult2Num = [[NSDecimalNumber alloc] initWithString:mult2];
    NSDecimalNumber *result = [mult1Num decimalNumberBySubtracting:mult2Num];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler  decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                              scale:scale
                                                                                   raiseOnExactness:NO
                                                                                    raiseOnOverflow:NO
                                                                                   raiseOnUnderflow:NO
                                                                                raiseOnDivideByZero:YES];
    
    return [[result decimalNumberByRoundingAccordingToBehavior:roundUp] stringValue];
    
}

+ (NSString *)JIAmult1:(NSString *)mult1 mult2:(NSString *)mult2 scale:(NSUInteger)scale{
    if ([mult1 isEqualToString:@""] || [mult2 isEqualToString:@""]) {
        return @"0";
    }
    NSDecimalNumber *mult1Num = [[NSDecimalNumber alloc] initWithString:mult1];
    NSDecimalNumber *mult2Num = [[NSDecimalNumber alloc] initWithString:mult2];
    NSDecimalNumber *result = [mult1Num decimalNumberByAdding:mult2Num];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler  decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                              scale:scale
                                                                                   raiseOnExactness:NO
                                                                                    raiseOnOverflow:NO
                                                                                   raiseOnUnderflow:NO
                                                                                raiseOnDivideByZero:YES];
    return [[result decimalNumberByRoundingAccordingToBehavior:roundUp] stringValue];
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

-(NSString *)setid:(NSString *)cityid
{
    NSString *dvalue;
    
    NSArray *dataArray = [USERDEFAULTS objectForKey:REGION];
    NSLog(@"%@",dataArray);
    for (int i = 0; i < dataArray.count; i ++) {
        if ([dataArray[i][@"cityId"] integerValue] == [cityid integerValue]) {
            dvalue = dataArray[i][@"cityName"];
        }
    }
    return dvalue;
}
-(NSString *)setvalue:(NSString *)cityvalue
{
    NSString *dvalue;
    NSArray *dataArray = [USERDEFAULTS objectForKey:REGION];
    for (int i = 0; i < dataArray.count; i ++) {
        if ([[NSString stringWithFormat:@"%@", dataArray[i][@"cityName"]] isEqualToString:cityvalue]) {
            dvalue = dataArray[i][@"cityId"];
        }
    }
    return dvalue;
}

-(NSString *)ReturnBankcardNumberByCode:(NSString *)code{
    NSString * name;
    NSArray *array = [USERDEFAULTS objectForKey:ADVANCECARD];
    for (int i = 0; i < array.count; i++) {
        if ([array[i][@"code"] isEqualToString:code]) {
            name =[NSString stringWithFormat:@"%@ %@ %@",array[i][@"bankName"],array[i][@"subbranch"],array[i][@"bankcardNumber"]];
        }
    }
    return name;
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



-(void)AlterImageByUrl:(NSString *)url{
    NSMutableArray *muArray = [NSMutableArray array];
    NSArray * arr = [NSArray array];
    if ([url containsString:@"||"]) {
        arr = [url componentsSeparatedByString:@"||"];
    }else
        arr = @[url];
    for (int i = 0; i < arr.count; i++) {
        [muArray addObject:[arr[i] convertImageUrl]];
    }
    NSArray *seleteArray = muArray;
    
    if (muArray.count > 0) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
            return seleteArray;
        }];
        
    }
}
-(NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//-(void)alertselectimage{
//    UIImagePickerController *pickCtrl = [[UIImagePickerController alloc] init];
//    pickCtrl.delegate = self;
//    pickCtrl.allowsEditing = self.allowsEditing;
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
//        [action setValue:HGColor(138, 138, 138) forKey:@"titleTextColor"];
//    }];
//    UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {
//        
//        pickCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self.vc presentViewController:pickCtrl animated:YES completion:nil];
//        
//    }];
//    UIAlertAction* fromPhotoAction1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {
//        
//        pickCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [self.vc presentViewController:pickCtrl animated:YES completion:nil];
//        
//    }];
//    [cancelAction setValue:GaryTextColor forKey:@"_titleTextColor"];
//    [fromPhotoAction setValue:MainColor forKey:@"_titleTextColor"];
//    [fromPhotoAction1 setValue:MainColor forKey:@"_titleTextColor"];
//    [alertController addAction:cancelAction];
//    [alertController addAction:fromPhotoAction];
//    [alertController addAction:fromPhotoAction1];
//    [self.vc presentViewController:alertController animated:YES completion:nil];
//}

@end
