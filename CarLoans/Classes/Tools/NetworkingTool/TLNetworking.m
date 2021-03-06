//
//  TLNetworking.m
//  WeRide
//
//  Created by  蔡卓越 on 2016/11/28.
//  Copyright © 2016年 trek. All rights reserved.
//

#import "TLNetworking.h"
//Manager
//#import "AppConfig.h"
//#import "TLUser.h"
//Category

#import "TLAlert.h"
#import "HttpLogger.h"
//#import "UIViewController+Extension.h"
//Extension
#import "SVProgressHUD.h"
//C
#import "BaseViewController.h"

//121.43.101.148:5703/cd-qlqq-front

@interface TLNetworking()

@property (nonatomic, strong) BaseViewController *baseVC;

@end

@implementation TLNetworking

- (BaseViewController *)baseVC {
    
    if (!_baseVC) {
        
//        _baseVC = [[BaseViewController alloc] getCurrentVC];
    }
    return _baseVC;
}

+ (AFHTTPSessionManager *)HTTPSessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    manager.requestSerializer.timeoutInterval = 60.0;
    //去除返回的null的value
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.removesKeysWithNullValues = YES;
    manager.responseSerializer = response;
    
    NSSet *set = manager.responseSerializer.acceptableContentTypes;
    
    set = [set setByAddingObject:@"text/plain"];
    set = [set setByAddingObject:@"text/html"];
//    set = [set setByAddingObject:@"text/html"];

    manager.responseSerializer.acceptableContentTypes = set;
    
    return manager;
}

//+ (NSString *)serveUrl {
//
////    return [[self baseUrl] stringByAppendingString:@"/forward-service/api"];
//}
//
//+ (NSString *)ipUrl {
//
//    return [[self baseUrl] stringByAppendingString:@"/forward-service/ip"];
//
//}


//+ (NSString *)baseUrl {
//
////    return [AppConfig config].addr;
//
//}
//
//
//+ (NSString *)systemCode {
//
//    return [AppConfig config].systemCode;
//
//}
//
//+ (NSString *)companyCode {
//
//    return [AppConfig config].companyCode;
//}

- (instancetype)init{

    if(self = [super init]){
    
       _manager = [[self class] HTTPSessionManager];
        _isShowMsg = YES;
        _isToken = YES;
        self.parameters = [NSMutableDictionary dictionary];
        
    }
    return self;

}


- (NSURLSessionDataTask *)postWithSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //如果想要设置其它 请求头信息 直接设置 HTTPSessionManager 的 requestSerializer 就可以了，不用直接设置 NSURLRequest
    
    if(self.showView){
    
        [SVProgressHUD show];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
    
    if (self.isShowMsg == NO) {
        [SVProgressHUD dismiss];
    }
    
    if(self.code && self.code.length > 0){
    
//        if (!(self.url && self.url.length > 0)) {

//            self.url = [[self class] serveUrl];
//        }

        if (![_isShow isEqualToString:@"100"]) {
            
//            self.parameters[@"systemCode"] = [[self class] systemCode];
        }
        if (_isToken == YES) {
            if ([USERDEFAULTS objectForKey:TOKEN_ID]) {
                
                self.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
            }
        }
        
//
//        self.parameters[@"companyCode"] = [[self class] companyCode];


    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.parameters options:NSJSONWritingPrettyPrinted error:nil];
//    self.parameters = [NSMutableDictionary dictionaryWithCapacity:2];

//    self.parameters[@"token"] = [USERDEFAULTS objectForKey:TOKEN_ID];
//    self.parameters[@"companyCode"] = @"CD-HTWT000020";
//    self.parameters[@"systemCode"] = @"CD-HTWT000020";
//
//    self.parameters[@"code"] = self.code;
//
//
//
//    self.parameters[@"json"] = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
//    NSLog(@"%@",self.parameters);

    NSDictionary *paraDic = @{@"json":[TLNetworking dictionaryToJson:self.parameters],
                              @"companyCode":@"CD-HTWT000020",
                              @"systemCode":@"CD-HTWT000020",
                              @"code":self.code
                              };
    
//    NSLog(@"%@",self.parameters);
//    [HttpLogger logJSONStringWithResponseObject:self.parameters];
//    if (!self.url || !self.url.length) {
//        NSLog(@"url 不存在啊");
////        if (hud || self.showView) {
////            [hud hideAnimated:YES];
////        }
//        return nil;
//    }
//
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:APPURL]];
    [HttpLogger logDebugInfoWithRequest:request apiName:self.code requestParams:paraDic httpMethod:@"POST"];
//    NSLog(@"code==%@ %@ %@",self.code,self.parameters,APPURL);
    return [self.manager POST:APPURL parameters:paraDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
      [HttpLogger logDebugInfoWithResponse:task.response apiName:self.code resposeString:responseObject request:task.originalRequest error:nil];

      //打印JSON字符串
      [HttpLogger logJSONStringWithResponseObject:responseObject];

      if(self.showView){
          
          [SVProgressHUD dismiss];
      }
      
      if([responseObject[@"errorCode"] isEqual:@"0"]){ //成功
          
          if(success) {
              
              //在主线程中加载UI
              dispatch_async(dispatch_get_main_queue(), ^{
                  
                  if (self.baseVC) {
                      if ([self.baseVC isKindOfClass:[BaseViewController class]]) {
//                          [self.baseVC removePlaceholderView];

                      }
                  }
              });
              
              success(responseObject);
          }
          
      } else {
          
          if (failure) {
              
              failure(nil);
          }
          
          if ([responseObject[@"errorCode"] isEqual:@"4"]) {
              //token错误  4
              if ([BaseModel isBlankString:[USERDEFAULTS objectForKey:USER_ID]] == NO) {
                  TLNetworking * http = [[TLNetworking alloc]init];
                  http.code = @"805085";
                  http.parameters[@"deviceToken"] = @"";
                  http.isToken = NO;
                  http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
                  [http postWithSuccess:^(id responseObject) {
                      //                      [USERDEFAULTS setObject:XGPushtokenStr forKey:@"deviceToken"];
                      LoginVC *vc = [[LoginVC alloc]init];
                      UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                      UINavigationController *vcC = [[UINavigationController alloc]initWithRootViewController:vc];
                      [USERDEFAULTS removeObjectForKey:USER_ID];
                      [USERDEFAULTS removeObjectForKey:TOKEN_ID];
                      window.rootViewController = vcC;
                      
                  } failure:^(NSError *error) {
                      
                  }];
              }else
              {
                  LoginVC *vc = [[LoginVC alloc]init];
                  UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                  UINavigationController *vcC = [[UINavigationController alloc]initWithRootViewController:vc];
                  [USERDEFAULTS removeObjectForKey:USER_ID];
                  [USERDEFAULTS removeObjectForKey:TOKEN_ID];
                  window.rootViewController = vcC;
              }
              
              return;
          }
          if (_isShowMsg) {
              if ([responseObject[@"errorInfo"] isEqualToString:@""]) {
                  [TLAlert alertWithInfo:@"操作失败"];
              }
              else
                  [TLAlert alertWithInfo:responseObject[@"errorInfo"]];
          }
          
      }
      
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       [TLAlert alertWithInfo:@"网络异常"];

       if(failure) {
           //在主线程中加载UI
//           dispatch_async(dispatch_get_main_queue(), ^{
//
//               if (self.baseVC) {
//
////                   [self.baseVC addPlaceholderView];
//               }
//           });
        
           failure(error);
       }
       
   }];

}

+(NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return str;
}


- (void)hundleSuccess:(id)responseObj {

    if([responseObj[@"success"] isEqual:@1]){
    
        
    }
}


+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(NSDictionary *)parameters
                       success:(void (^)(id responseObject))success
                       failure: (void (^)(NSError *error))failure{
    
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
    
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            
            failure(error);
            
        }
        
    }];


}

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                       parameters:(NSDictionary *)parameters
                          success:(void (^)(id responseObject))success
                      abnormality:(void (^)(NSString *msg))abnormality
                          failure:(void (^)(NSError * _Nullable  error))failure;
{
    //先检查网络
    
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
    
    return [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure){
            failure(error);
        }
        
    }];
    
}


//#pragma mark - GET
+ (NSURLSessionDataTask *)GET:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                         success:(void (^)(NSString *msg,id data))success
                     abnormality:(void (^)())abnormality
                         failure:(void (^)(NSError *error))failure;
{
    AFHTTPSessionManager *manager = [self HTTPSessionManager];
    
    
    return [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(@"",responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
    
    
}



@end
