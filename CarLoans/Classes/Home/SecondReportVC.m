//
//  SecondReportVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "SecondReportVC.h"

@interface SecondReportVC ()<UIScrollViewDelegate>
{
    int height;
}
@property (nonatomic,assign)  NSString *webViewHeight1;

@end

@implementation SecondReportVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二手车评估报告";
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    //注入
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    //配置对象
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
            
    self.detail = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) configuration:wkWebConfig];
    self.detail.scrollView.delegate = self;
    self.detail.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.detail loadHTMLString:self.web baseURL:nil];
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.web]];
    [self.detail loadRequest:request];
    self.detail.scrollView.contentOffset= CGPointMake(0, 0);
    
//    UIView * headview = [[UIView alloc]initWithFrame:CGRectMake(0, -200, SCREEN_WIDTH, 200)];
//    headview.backgroundColor = kWhiteColor;
//
//    UILabel * titlelab = [UILabel labelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:Font(20) textColor:kBlackColor];
//    titlelab.numberOfLines = 0;
//    titlelab.text = self.IntroduceTitle;
//    [headview addSubview:titlelab];
//
//    UILabel * timelab = [UILabel labelWithFrame:CGRectMake(0, 105, SCREEN_WIDTH, 50) textAligment:NSTextAlignmentCenter backgroundColor:kClearColor font:Font(20) textColor:kBlackColor];
//    timelab.text = self.time;
//    [headview addSubview:timelab];
//
//    [self.detail.scrollView addSubview:headview];
    
    
    
    [self.view addSubview:self.detail];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
