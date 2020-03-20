//
//  AppDelegate.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "LoginVC.h"
#import "TLTabBarController.h"
#import "CheckDetailsVC.h"
#import "CheckDetailsVC.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<XGPushDelegate,UNUserNotificationCenterDelegate>
@property (nonatomic , assign)BOOL isLaunchedByNotification;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    [application registerForRemoteNotifications];
    
    [BaseModel QueriesNumberOfUnreadMessageBars];
    [self XGPushSetUp];
    [[XGPush defaultManager] reportXGNotificationInfo:launchOptions];
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    if (launchOptions) {
        self.isLaunchedByNotification = YES;
    }else{
        self.isLaunchedByNotification = NO;
    }
    
    if([BaseModel user].isLogin == NO) {
        LoginVC *VC = [[LoginVC alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
        self.window.rootViewController = nav;
    }
    else
    {
        TLTabBarController *TabBarVC = [[TLTabBarController alloc]init];
        self.window.rootViewController = TabBarVC;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self upgrade];
    });
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (NSString *)version {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

-(void)upgrade
{
    TLNetworking *http2 = [[TLNetworking alloc] init];
    http2.code = @"630048";
    http2.parameters[@"type"] = @"ios";
    http2.parameters[@"start"] = @"1";
    http2.parameters[@"limit"] = @"10";
//    http2.isLocal = YES;
    [http2 postWithSuccess:^(id responseObject) {
        
        NSDictionary *update = responseObject[@"data"];
        //获取当前版本号
        NSString *currentVersion = [self version];
        if ([currentVersion integerValue] < [update[@"version"] integerValue]) {
            if ([update[@"forceUpdate"] isEqualToString:@"0"]) {
                //不强制
                [TLAlert alertWithTitle:@"更新提示" msg:update[@"note"] confirmMsg:@"立即升级" cancleMsg:@"稍后提醒" cancle:^(UIAlertAction *action) {
                    
                } confirm:^(UIAlertAction *action) {
                    [self goBcoinWeb];
                }];
            } else {
                //强制
                [TLAlert alertWithTitle:@"更新提醒" message:update[@"note"] confirmMsg:@"立即升级" confirmAction:^{
                    [self goBcoinWeb];
                }];
            }
        } else {
            
//            [self configurationLoadData];
            
        }
        
    } failure:^(NSError *error) {

    }];
}


- (void)goBcoinWeb{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/m-help/id1449227379?mt=8"]];
    [[UIApplication sharedApplication]openURL:url];
}

-(void)XGPushSetUp
{
    
    //    信鸽推送
    [[XGPush defaultManager] setEnableDebug:YES];
    [[XGPush defaultManager] startXGWithAppID:2200353277 appKey:@"IYHP7973DV3G"  delegate:self];
    //角标设置
    //    [[XGPush defaultManager] setXgApplicationBadgeNumber:4];
    
    //    在通知消息中创建一个可以点击的事件行为
    XGNotificationAction *action1 = [XGNotificationAction actionWithIdentifier:@"xgaction001" title:@"xgAction1" options:XGNotificationActionOptionNone];
    XGNotificationAction *action2 = [XGNotificationAction actionWithIdentifier:@"xgaction002" title:@"xgAction2" options:XGNotificationActionOptionNone];
    
    
    XGNotificationCategory *category = [XGNotificationCategory categoryWithIdentifier:@"xgCategory" actions:@[action1, action2] intentIdentifiers:@[] options:XGNotificationCategoryOptionNone];
    XGNotificationConfigure *configure = [XGNotificationConfigure configureNotificationWithCategories:[NSSet setWithObject:category] types:XGUserNotificationTypeAlert|XGUserNotificationTypeBadge|XGUserNotificationTypeSound];
    
    [[XGPush defaultManager] setNotificationConfigure:configure];
    
    //    上报角标s
//    NSInteger number;
//    if ([USERDEFAULTS objectForKey:USER_ID]) {
//        //        [[XGPush defaultManager] setXgApplicationBadgeNumber:[ integerValue]]
//        number = [[USERDEFAULTS objectForKey:@"unreadnumber"] integerValue];
//    }else
//    {
//        number = 0;
//    }
//    [[XGPush defaultManager] setBadge:number];
}



- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    //将来需要将此Token上传给后台服务器
    NSString *XGPushtokenStr = [[XGPushTokenManager defaultTokenManager] deviceTokenString];
    NSLog(@"XGPushtokenStr===>%@",XGPushtokenStr);
    [USERDEFAULTS setObject:XGPushtokenStr forKey:@"deviceToken1"];
    if([BaseModel user].isLogin == YES) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"805085";
        http.parameters[@"deviceToken"] = XGPushtokenStr;
        http.isToken = NO;
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            [USERDEFAULTS setObject:XGPushtokenStr forKey:@"deviceToken"];
        } failure:^(NSError *error) {

        }];
    }
}





- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"%s======》",__func__);
    
    NSString *zero =[[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] objectForKey:@"body"];
    if (application.applicationState == UIApplicationStateActive) {
        //        [self showAlertViewWithTitle:@"新消息提示" Message:zero ConfirmTitle:@"确定" CancelTitle:nil];
    }
    //    [self receiveRemoteNotificationWithUserInfo:userInfo];
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"%s",__func__);
    
    NSLog(@"[XGDemo] receive slient Notification");
    NSLog(@"[XGDemo] userinfo %@", userInfo);
    
    if (self.isLaunchedByNotification == NO) {
        if (application.applicationState == UIApplicationStateActive) {
            //iOS10之前，在前台时用自定义AlertView展示消息
            [self receiveRemoteNotificationWithUserInfo:userInfo];
        }else {
            [self receiveRemoteNotificationWithUserInfo:userInfo];
        }
    }else{
        self.isLaunchedByNotification = NO;
    }
    
    //iOS 9.x 及以前，需要在 UIApplicationDelegate 的回调方法(如下)中调用上报数据的接口
    [[XGPush defaultManager] reportXGNotificationInfo:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
}


//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [[XGPush defaultManager] reportXGNotificationInfo:notification.request.content.userInfo];
    //可设置是否在应用内弹出通知
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}


//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
- (void)xgPushUserNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s",__func__);
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    NSLog(@"Userinfo %@",response.notification.request.content.userInfo);
    //处理接收到的消息
    
    [self receiveRemoteNotificationWithUserInfo:response.notification.request.content.userInfo];
    [[XGPush defaultManager] reportXGNotificationResponse:response];
    completionHandler();
}

-(void)receiveRemoteNotificationWithUserInfo:(NSDictionary *)dic
{
    
    UITabBarController *tbc = (UITabBarController *)self.window.rootViewController;
    UINavigationController *nav = tbc.viewControllers[tbc.selectedIndex];
    
    
    if ([dic[@"custom"][@"key1"] isEqualToString:@"1"] || [dic[@"custom"][@"key1"] isEqualToString:@"2"]) {
        TLNetworking *http = [TLNetworking new];
        http.code = @"632516";
//        http.showView = self.view;
        http.parameters[@"code"] = dic[@"custom"][@"key2"];
        [http postWithSuccess:^(id responseObject) {
            
            
            [tbc setSelectedIndex:1];
            
//            CheckDetailsVC * vc = [CheckDetailsVC new];
//            vc.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
//            vc.hidesBottomBarWhenPushed = YES;
//            [nav pushViewController:vc animated:YES];
        
        } failure:^(NSError *error) {

        }];
    }

}




- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray *))restorationHandler
{
    NSLog(@"userActivity : %@",userActivity.webpageURL.description);
    if ([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]) {
        NSURL *webpageURL = userActivity.webpageURL;
        NSString *host = webpageURL.host;
        //        if ([host isEqualToString:@"yohunl.com"]) {
        //            //进行我们需要的处理
        //        }
        //        else {
        //            [[UIApplication sharedApplication]openURL:webpageURL];
        //        }
    }
    
    return YES;
    
}

//推送token传给服务器
- (void)xgPushDidRegisteredDeviceToken:(nullable NSString *)deviceToken error:(nullable NSError *)error;
{
    [USERDEFAULTS setObject:deviceToken forKey:@"deviceToken1"];
    if([BaseModel user].isLogin == YES) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"805085";
        http.isToken = NO;
        http.parameters[@"deviceToken"] = deviceToken;
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            [USERDEFAULTS setObject:deviceToken forKey:@"deviceToken"];
        } failure:^(NSError *error) {

        }];
    }
}






- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    [[SDImageCache sharedImageCache]clearMemory];
    [[SDWebImageManager sharedManager]cancelAll];
}
-(void)applicationDidFinishLaunching:(UIApplication *)application{
    SDImageCache.sharedImageCache.maxMemoryCost = 1024*1024*8;
}

@end
