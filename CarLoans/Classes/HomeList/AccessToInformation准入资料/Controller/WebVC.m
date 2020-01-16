//
//  WebVC.m
//  Coin
//
//  Created by 蔡卓越 on 2017/11/16.
//  Copyright © 2017年  tianlei. All rights reserved.
//

#import "WebVC.h"
#import <WebKit/WebKit.h>


@interface WebVC ()<WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *currentWebView;
@end

@implementation WebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评估报告";
    
    WKWebViewConfiguration *webConfig = [[WKWebViewConfiguration alloc] init];
    // ************* js
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    webConfig.userContentController = userContentController;

    //
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
//  preferences.minimumFontSize = 40.0;
    webConfig.preferences = preferences;
    
//    [userContentController addScriptMessageHandler:self name:@"Share"];


    //*****************
    
    WKWebView *webV = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) configuration:webConfig];
    [self.view addSubview:webV];
    webV.navigationDelegate = self;
    self.currentWebView = webV;
    
    if ([BaseModel isBlankString:self.url] == NO) {
        NSURL *url = [[NSURL alloc] initWithString:self.url];
        NSURLRequest *req = [[NSURLRequest alloc] initWithURL:url];
        
        [webV loadRequest:req];
    }
    
    
    //
    if (self.canSendWX) {
        
        [self addTestMask];

    }
    
}


#pragma mark- 收到js方法
// js 调用oc方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    //     [userContentController addScriptMessageHandler:self name:@"Share"];
    //  相当于          window.webkit.messageHandlers.Share.postMessage({title:'测试分享的标题',content:'测试分享的内容',url:'https://github.com/maying1992'});
    // window.webkit.messageHandlers.Share 添加了一个 Share
    //
//    NSString *name =  message.name;
//    id body = message.body;
    
    
    
}


- (void)addTestMask {
    
    UIControl *maskCtrl = [[UIControl alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:maskCtrl];
    [maskCtrl addTarget:self action:@selector(saveOrShare) forControlEvents:UIControlEventTouchUpInside];
    
    //手势实验
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapWeb)];
//    [self.currentWebView addGestureRecognizer:tap];
    
}

- (void)tapWeb {
    
    
    
}

- (void)saveOrShare {
    
    
    

}



- (void)remve:(UIView *)v {
    
    [v removeFromSuperview];
}





#pragma mark- 截图相关代码
//根据一个View生成一个image
- (UIImage *)screenshotForView:(UIView *)view {
    UIImage *image = nil;
    //判断View类型（一般不是滚动视图或者其子类的话内容不会超过一屏，当然如果超过了也可以通过修改frame来实现绘制）
//    if ([view.class isSubclassOfClass:[UIScrollView class]]) {
//        UIScrollView *scrView = (UIScrollView *)view;
//
//        //记录
//        CGPoint tempContentOffset = scrView.contentOffset;
//        CGRect tempFrame = scrView.frame;
//
//        scrView.contentOffset = CGPointZero;
//        scrView.frame = CGRectMake(0, 0, scrView.contentSize.width, scrView.contentSize.height);
//
//        image = [self screenshotForView:scrView size:scrView.frame.size];
//        scrView.contentOffset = tempContentOffset;
//        scrView.frame = tempFrame;
//
//    } else {
    
        image = [self screenshotForView:view size:view.frame.size];
        
//    }
    
    return image;
}

- (UIImage *)screenshotForView:(UIView *)view size:(CGSize)size {
    
    UIImage *image = nil;

    //1. 第一种方法
//    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
//    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    //2. 第二种
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:false];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}





@end
