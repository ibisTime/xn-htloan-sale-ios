//
//  FaceSignMQVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "FaceSignMQVC.h"
#import "FaceSignMQTableView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <ILiveSDK/ILiveLoginManager.h>
#import "LiveRoomViewController.h"
#import <CoreMedia/CoreMedia.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CommonCrypto/CommonDigest.h>
#import <TILLiveSDK/TILLiveCommon.h>
#import <TILLiveSDK/TILLiveConfig.h>
#import <AFNetworking.h>
#import "NSString+MD5.h"
#import "JoinLiveController.h"
#import "FaceToFaceSignVC.h"
@interface FaceSignMQVC ()<RefreshDelegate>
{
    NSString *Str1;
    NSString *Str2;
    NSString *Str3;
    NSString *Str4;
    NSString *Str5;

    NSString *faceStr;
}
@property (nonatomic , strong)FaceSignMQTableView *tableView;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic , copy)NSString* roomId;
@property (nonatomic , copy) NSString *strid ;
@property (nonatomic, strong) UIAlertController *alertCtrl;

@property (nonatomic , copy) NSString *stremid ;

@property (nonatomic , copy) NSString *signPlayUrl ;

@property (nonatomic , assign) BOOL isJoin ;

@property (nonatomic , assign) BOOL isroomManger ;

@property (nonatomic , strong) NSNumber *num;
//银行视频
@property (nonatomic , strong)NSMutableArray *BankVideoArray;
//公司视频
@property (nonatomic , strong)NSMutableArray *CompanyVideoArray;
//其他视频
@property (nonatomic , strong)NSMutableArray *OtherVideoArray;

//银行视频
@property (nonatomic , strong)NSMutableArray *BankVideoDataArray;
//公司视频
@property (nonatomic , strong)NSMutableArray *CompanyVideoDataArray;
//其他视频
@property (nonatomic , strong)NSMutableArray *OtherVideoDataArray;

//银行面签照片
@property (nonatomic , strong)NSMutableArray *BankSignArray;
//银行合同照片
@property (nonatomic , strong)NSMutableArray *BankContractArray;
//公司合同照片
@property (nonatomic , strong)NSMutableArray *CompanyContractArray;
//资金划转授权书
@property (nonatomic , strong)NSMutableArray *MoneyArray;
//其他资料
@property (nonatomic , strong)NSMutableArray *otherArray;

@end

@implementation FaceSignMQVC

- (TLImagePicker *)imagePicker {

    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];

        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            NSLog(@"%@",info);
            if (self.selectInt < 3) {

                //2.文件的url
                NSURL *url1=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
                NSString *urlStr=[url1 path];

                [SVProgressHUD showWithStatus:@"上传中"];
                //进行上传
              
                
                
                AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:urlStr] options:nil];
                
                NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
                
                NSLog(@"%@",compatiblePresets);
                
                if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
                    
                    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
                    
                    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复
                    
                    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
                    
                    NSString * resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
                    
                    NSLog(@"resultPath = %@",resultPath);
                    exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
                    
                    exportSession.outputFileType = AVFileTypeMPEG4;
                    
                    exportSession.shouldOptimizeForNetworkUse = YES;
                    
                    [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
                     
                     {
                         
                         switch (exportSession.status) {
                                 
                             case AVAssetExportSessionStatusUnknown:
                                 
                                 NSLog(@"AVAssetExportSessionStatusUnknown");
                                 
                                 break;
                                 
                             case AVAssetExportSessionStatusWaiting:
                                 
                                 NSLog(@"AVAssetExportSessionStatusWaiting");
                                 
                                 break;
                                 
                             case AVAssetExportSessionStatusExporting:
                                 
                                 NSLog(@"AVAssetExportSessionStatusExporting");
                                 
                                 break;
                                 
                             case AVAssetExportSessionStatusCompleted:
                             {
                                 NSLog(@"AVAssetExportSessionStatusCompleted");
                                 TLUploadManager *manager = [TLUploadManager manager];
                                 
                                 manager.videoData = resultPath;
                                 [manager getTokenShowViewFile:weakSelf.view succes:^(NSString *key) {
                                     WGLog(@"%@",key);
                                     [weakSelf setVideoStr:urlStr setData:key];
                                     
                                 } failure:^(NSError *error) {
                                     
                                 }];
                                 break;
                             }
                             case AVAssetExportSessionStatusFailed:
                                 
                                 NSLog(@"AVAssetExportSessionStatusFailed");
                                 
                                 break;
                                 
                         }
                         
                     }];
                
                
                
                }
                
                
               

            }else
            {

                UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
                NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
                [SVProgressHUD showWithStatus:@"上传中"];
                //进行上传
                TLUploadManager *manager = [TLUploadManager manager];

                manager.imgData = imgData;
                manager.image = image;
                [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
                    WGLog(@"%@",key);
                    [weakSelf setImage:image setData:key];

                } failure:^(NSError *error) {

                }];
            }
        };
    }
    return _imagePicker;
}

-(void)setVideoStr:(NSString *)video setData:(NSString *)data
{
//    NSRange range = [video rangeOfString:@"tmp/"];
//   video = [video substringFromIndex:range.location+4];
    if ([data containsString:@"tmp/"]) {
        [TLAlert alertWithMsg:@"请重新上传视频"];
        return;
    }
    switch (self.selectInt) {
        case 0:
        {
            if (self.BankVideoArray.count == 0) {
                self.BankVideoArray = [NSMutableArray array];
            }
            if (self.BankVideoDataArray.count == 0) {
                self.BankVideoDataArray = [NSMutableArray array];
            }
            [self.BankVideoArray addObject:data];
            [self.BankVideoDataArray addObject:data];
            self.tableView.BankVideoArray = self.BankVideoArray;
        }
            break;
        case 1:
        {
            if (self.CompanyVideoArray.count ==0) {
                self.CompanyVideoArray = [NSMutableArray array];
            }
            if (self.CompanyVideoDataArray.count ==0) {
                self.CompanyVideoDataArray = [NSMutableArray array];
            }
            [self.CompanyVideoArray addObject:data];
            [self.CompanyVideoDataArray addObject:data];
            self.tableView.CompanyVideoArray = self.CompanyVideoArray;
        }
            break;
        case 2:
        {
            if (self.OtherVideoArray.count ==0) {
                self.OtherVideoArray = [NSMutableArray array];
            }
            if (self.OtherVideoDataArray.count ==0) {
                self.OtherVideoDataArray = [NSMutableArray array];
            }
            [self.OtherVideoArray addObject:data];
            self.tableView.OtherVideoArray = self.OtherVideoArray;
            [self.OtherVideoDataArray addObject:data];

        }
            break;

        default:
            break;

    }
    [self.tableView reloadData];
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{

//    if (self.selectInt > 2) {
//        UIButton *button = [self.view viewWithTag:self.selectInt];
//        [button setBackgroundImage:image forState:(UIControlStateNormal)];
//        [button setImage:HGImage(@"") forState:(UIControlStateNormal)];
//        [button setTitle:@"" forState:(UIControlStateNormal)];
//    }
    switch (_selectInt) {
        case 3:
        {
            if (self.BankSignArray.count == 0) {
                self.BankSignArray = [NSMutableArray array];
            }
            [self.BankSignArray addObject:data];
            self.tableView.BankSignArray = self.BankSignArray;
        }
            break;
        case 4:
        {
            if (self.BankContractArray.count == 0) {
                self.BankContractArray = [NSMutableArray array];
            }
            [self.BankContractArray addObject:data];
            self.tableView.BankContractArray = self.BankContractArray;

        }
            break;
        case 5:
        {
            if (self.CompanyContractArray.count == 0) {
                self.CompanyContractArray = [NSMutableArray array];
            }
            [self.CompanyContractArray addObject:data];
            self.tableView.CompanyContractArray = self.CompanyContractArray;

        }
            break;
        case 6:
        {
            if (self.MoneyArray.count == 0) {
                self.MoneyArray = [NSMutableArray array];
            }
            [self.MoneyArray addObject:data];
            self.tableView.MoneyArray = self.MoneyArray;

        }
            break;
        case 7:
        {
            if (self.otherArray.count == 0) {
                self.otherArray = [NSMutableArray array];
            }
            [self.otherArray addObject:data];
            self.tableView.otherArray = self.otherArray;

        }
            break;

        default:
            break;
    }
    [self.tableView reloadData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _BankVideoArray = [NSMutableArray array];
    _CompanyVideoArray = [NSMutableArray array];
    _OtherVideoArray = [NSMutableArray array];
    _BankVideoDataArray = [NSMutableArray array];
    _CompanyVideoDataArray = [NSMutableArray array];
    _OtherVideoDataArray = [NSMutableArray array];
    _BankSignArray = [NSMutableArray array];
    _BankContractArray = [NSMutableArray array];
    _CompanyContractArray = [NSMutableArray array];
    _MoneyArray = [NSMutableArray array];
    _otherArray = [NSMutableArray array];

    [self navigativeView];
    [self initTableView];
    [self loadHistoryList];
    faceStr = @"";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadEndMovieUrlOut) name:@"KsingOut" object:nil];
}

- (void)loadHistoryList
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"632146";
    http.parameters[@"code"] = _model.code;

    http.showView = self.view;
    //    [_interviewPicArray componentsJoinedByString:@"||"]
    [http postWithSuccess:^(id responseObject) {
        NSLog(@"%@",responseObject);
        http.parameters[@"bankVideo"] = [_BankVideoDataArray componentsJoinedByString:@"||"];
        http.parameters[@"companyVideo"] = [_CompanyVideoDataArray componentsJoinedByString:@"||"];
        
        http.parameters[@"otherVideo"] = [_OtherVideoDataArray componentsJoinedByString:@"||"];
        http.parameters[@"bankPhoto"] = Str1;
        http.parameters[@"bankContract"] = Str2;
        http.parameters[@"companyContract"] = Str3;
        http.parameters[@"advanceFundAmountPdf"] = Str4;
        http.parameters[@"interviewOtherPdf"] = Str5;
        self.BankVideoDataArray = [responseObject[@"data"][@"bankVideo"] componentsSeparatedByString:@"||"].mutableCopy;
        self.CompanyVideoDataArray = [responseObject[@"data"][@"companyVideo"] componentsSeparatedByString:@"||"].mutableCopy;
         self.OtherVideoDataArray = [responseObject[@"data"][@"otherVideo"] componentsSeparatedByString:@"||"].mutableCopy;
        self.BankSignArray = [responseObject[@"data"][@"bankPhoto"] componentsSeparatedByString:@"||"].mutableCopy;
        self.BankContractArray = [responseObject[@"data"][@"bankContract"] componentsSeparatedByString:@"||"].mutableCopy;
        self.CompanyContractArray = [responseObject[@"data"][@"companyContract"] componentsSeparatedByString:@"||"].mutableCopy;
        self.MoneyArray = [responseObject[@"data"][@"advanceFundAmountPdf"] componentsSeparatedByString:@"||"].mutableCopy;
        self.otherArray = [responseObject[@"data"][@"interviewOtherPdf"] componentsSeparatedByString:@"||"].mutableCopy;
        NSString *str = self.BankSignArray[0];
        if ([str isEqualToString:@""]) {
            self.BankSignArray = [NSMutableArray array];
        }
        NSString *str1 = self.BankContractArray[0];
        if ([str1 isEqualToString:@""]) {
            self.BankContractArray = [NSMutableArray array];
        }
        NSString *str2 = self.CompanyContractArray[0];
        if ([str2 isEqualToString:@""]) {
            self.CompanyContractArray = [NSMutableArray array];
        }
        NSString *str3 = self.otherArray[0];
        if ([str3 isEqualToString:@""]) {
            self.otherArray = [NSMutableArray array];
        }
        NSString *str4 = self.MoneyArray[0];
        if ([str4 isEqualToString:@""]) {
            self.MoneyArray = [NSMutableArray array];
        }
        
        NSString *str5 = self.BankVideoDataArray[0];
        if ([str5 isEqualToString:@""]) {
            self.BankVideoDataArray = [NSMutableArray array];
        }
        NSString *str6 = self.CompanyVideoDataArray[0];
        if ([str6 isEqualToString:@""]) {
            self.CompanyVideoDataArray = [NSMutableArray array];
        }
        NSString *str7 = self.OtherVideoDataArray[0];
        if ([str7 isEqualToString:@""]) {
            self.OtherVideoDataArray = [NSMutableArray array];
        }
        self.BankVideoArray = self.BankVideoDataArray.mutableCopy;
        self.CompanyVideoArray = self.CompanyVideoDataArray.mutableCopy;
        self.OtherVideoArray = self.OtherVideoDataArray.mutableCopy;

        self.tableView.BankVideoArray = self.BankVideoDataArray;
        self.tableView.CompanyVideoArray = self.CompanyVideoDataArray;
        self.tableView.OtherVideoArray = self.OtherVideoDataArray;
        self.tableView.BankSignArray = self.BankSignArray;
        self.tableView.BankContractArray = self.BankContractArray;
        self.tableView.CompanyContractArray = self.CompanyContractArray;
        self.tableView.MoneyArray = self.MoneyArray;
        self.tableView.otherArray = self.otherArray;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    self.selectInt = index;
    if ([state isEqualToString:@"add"]) {
        if (index < 3) {
            [self.imagePicker videoPicker];
        }else
        {
            [self.imagePicker picker];
        }
    }else
    {
        NSLog(@"删除 %ld",index);
        if (index == 0)
        {
            [self.BankVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.BankVideoDataArray.count > 0) {
                [self.BankVideoDataArray removeObjectAtIndex:sender.tag - 1000];

            }
        }
        else if (index == 1)
        {
            [self.CompanyVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.CompanyVideoDataArray.count > 0) {
                [self.CompanyVideoDataArray removeObjectAtIndex:sender.tag - 1000];

            }
        }
        else if (index == 2)
        {

            [self.OtherVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.OtherVideoDataArray.count > 0) {
                [self.OtherVideoDataArray removeObjectAtIndex:sender.tag - 1000];

            }
        }
        else if (index == 3)
        {
            
            if (self.BankSignArray.count > 0) {
                [self.BankSignArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 4)
        {
            
            if (self.BankContractArray.count > 0) {
                [self.BankContractArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 5)
        {
            
            if (self.CompanyContractArray.count > 0) {
                [self.CompanyContractArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 6)
        {
            
            if (self.MoneyArray.count > 0) {
                [self.MoneyArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 7)
        {
            
            if (self.otherArray.count > 0) {
                [self.otherArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        
        self.tableView.BankVideoArray = self.BankVideoArray;
        self.tableView.CompanyVideoArray = self.CompanyVideoArray;
        self.tableView.OtherVideoArray = self.OtherVideoArray;
        self.tableView.BankSignArray = self.BankSignArray;
        self.tableView.BankContractArray = self.BankContractArray;
        self.tableView.CompanyContractArray = self.CompanyContractArray;
        self.tableView.MoneyArray = self.MoneyArray;
        self.tableView.otherArray = self.otherArray;
        [self.tableView reloadData];
    }
}


-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    if (sender.tag == 10001) {
        
    }else{
        if (_BankVideoDataArray.count == 0) {
            [TLAlert alertWithInfo:@"请上传银行视频"];
            return;
        }
        if (_CompanyVideoDataArray.count == 0) {
            [TLAlert alertWithInfo:@"请上传公司视频"];
            return;
        }
        if (_BankSignArray.count == 0) {
            [TLAlert alertWithInfo:@"请上传银行面签照片"];
            return;
        }
        if (_MoneyArray.count == 0) {
            [TLAlert alertWithInfo:@"请上传资金划转授权书"];
            return;
        }
    }
   

    TLNetworking *http = [TLNetworking new];
    http.code = @"632123";
    http.showView = self.view;
    //    [_interviewPicArray componentsJoinedByString:@"||"]
    http.parameters[@"code"] = _model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"bankVideo"] = [_BankVideoDataArray componentsJoinedByString:@"||"];
    http.parameters[@"companyVideo"] = [_CompanyVideoDataArray componentsJoinedByString:@"||"];
    if (sender.tag == 10001) {
        http.parameters[@"isSend"] = @"0";

    }else{
        http.parameters[@"isSend"] = @"1";

    }

    http.parameters[@"otherVideo"] = [_OtherVideoDataArray componentsJoinedByString:@"||"];
    http.parameters[@"bankPhoto"] = [self.BankSignArray componentsJoinedByString:@"||"];
    http.parameters[@"bankContract"] = [self.BankContractArray componentsJoinedByString:@"||"];;
    http.parameters[@"companyContract"] = [self.CompanyContractArray componentsJoinedByString:@"||"];;
    http.parameters[@"advanceFundAmountPdf"] = [self.MoneyArray componentsJoinedByString:@"||"];;
    http.parameters[@"interviewOtherPdf"] = [self.otherArray componentsJoinedByString:@"||"];;

    [http postWithSuccess:^(id responseObject) {
        if (sender.tag == 10001) {
            [TLAlert alertWithSucces:@"保存成功"];

        }else{
            [TLAlert alertWithSucces:@"面签成功"];
            NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
        }
      
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}


- (void)initTableView {
    self.tableView = [[FaceSignMQTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}


-(void)navigativeView
{
    self.title = @"面签";
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"发起面签" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
}


- (void)sendPhoneCode
{
    TLNetworking *ht = [TLNetworking new];
    ht.code = @"632136";
    ht.parameters[@"roomId"] = self.strid;
    ht.parameters[@"code"] = self.model.code;

    ht.showView = self.view;
    [ht postWithSuccess:^(id responseObject) {
        if ([faceStr isEqualToString:@""]) {
            TLNetworking *http= [TLNetworking new];
            http.code = @"630800";
            http.showView = self.view;
            http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
            
            [http postWithSuccess:^(id responseObject) {
                
                [SVProgressHUD showWithStatus:@""];
//
                NSString *str =  [[ILiveLoginManager getInstance] getLoginId];
                if (!str) {
                
                [[ILiveSDK getInstance] initSdk:[responseObject[@"data"][@"txAppCode"] intValue] accountType:[responseObject[@"data"][@"accountType"] intValue]];
                
                [[ILiveLoginManager getInstance] iLiveLogin:[USERDEFAULTS objectForKey:USER_ID] sig:responseObject[@"data"][@"sign"] succ:^{
                    faceStr = responseObject[@"data"][@"sign"];
                    [SVProgressHUD dismiss];
                    // 1. 创建live房间页面
                    LiveRoomViewController *liveRoomVC = [[LiveRoomViewController alloc] init];
                    liveRoomVC.RightButton.hidden = NO;
                    self.isroomManger = YES;
                    self.stremid = nil;

                    liveRoomVC.curreryBlock = ^(NSString* roomID) {
                        self.stremid = roomID;
                    };
                    // 2. 创建房间配置对象
                    ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
                    //                option.imOption.imSupport = YES;
                    
                    // 设置房间内音视频监听
                    option.memberStatusListener = liveRoomVC;
                    // 设置房间中断事件监听
                    option.roomDisconnectListener = liveRoomVC;
                    
                    // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
                    option.controlRole = @"cd_room";
                    NSString *userID = [USERDEFAULTS objectForKey:USER_ID];;

                    [[ILiveRoomManager getInstance] createRoom:[self.strid intValue] option:option succ:^{
                        // 创建房间成功，跳转到房间页
                        [SVProgressHUD dismiss];

                        liveRoomVC.roomId = self.strid;

                        [self.navigationController pushViewController:liveRoomVC animated:YES];
                        
                    } failed:^(NSString *module, int errId, NSString *errMsg) {
                        // 创建房间失败
                        
                        [SVProgressHUD dismiss];
                        self.alertCtrl.title = @"创建房间失败";
                        self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
                        [self presentViewController:self.alertCtrl animated:YES completion:nil];
                    }];
                    
                    
                    // 登录成功，跳转到创建房间页
                    
                } failed:^(NSString *module, int errId, NSString *errMsg) {
                    NSLog(@"%@",errMsg);
                    [SVProgressHUD dismiss];

                    [TLAlert alertWithError:[NSString stringWithFormat:@"%@",errMsg]];
                }];
                NSLog(@"%@",responseObject);
                    
                    
                }else
                {
                    // 1. 创建live房间页面
                    LiveRoomViewController *liveRoomVC = [[LiveRoomViewController alloc] init];
                    //            liveRoomVC.RightButton.hidden = YES;
                    liveRoomVC.RightButton.hidden =NO;
                    liveRoomVC.num = self.num;
                    self.isroomManger = YES;
                    self.stremid = nil;

                    liveRoomVC.curreryBlock = ^(NSString* roomID) {
                        self.stremid = roomID;
                    };
                    // 2. 创建房间配置对象
                    ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
                    option.imOption.imSupport = YES;
                    // 设置房间内音视频监听
                    option.memberStatusListener = liveRoomVC;
                    // 设置房间中断事件监听
                    option.roomDisconnectListener = liveRoomVC;
                    
                    // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
                    option.controlRole = @"cd_room";
                    
                    // 3. 调用创建房间接口，传入房间ID和房间配置对象
                    //        [string substringFromIndex:string.length - 8 ];
                    liveRoomVC.roomId = self.strid;
                    self.roomId = self.strid;
                    [[ILiveRoomManager getInstance] createRoom:[self.strid intValue] option:option succ:^{
                        // 创建房间成功，跳转到房间页
                        //                [self requestWithRoomID:self.strid];
                        liveRoomVC.roomId = self.strid;
                        [SVProgressHUD dismiss];

                        [self.navigationController pushViewController:liveRoomVC animated:YES];
                        
                    } failed:^(NSString *module, int errId, NSString *errMsg) {
                        // 创建房间失败
                        
                        [SVProgressHUD dismiss];
                        self.alertCtrl.title = @"创建房间失败";
                        self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
                        [self presentViewController:self.alertCtrl animated:YES completion:nil];
                    }];
                    
                }
                
            } failure:^(NSError *error) {
                WGLog(@"%@",error);
            }];
        }else
        {
            [self joinWithNei];
            return ;
            NSString *str =  [[ILiveLoginManager getInstance] getLoginId];
            if (!str) {
                TLNetworking *htt = [TLNetworking new];
                htt.code = @"630800";
                htt.showView = self.view;
                htt.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
                
                [htt postWithSuccess:^(id responseObject) {
                    [[ILiveSDK getInstance] initSdk:[responseObject[@"data"][@"txAppCode"] intValue] accountType:[responseObject[@"data"][@"accountType"] intValue]];
                    
                    [[ILiveLoginManager getInstance] iLiveLogin:[USERDEFAULTS objectForKey:USER_ID] sig:responseObject[@"data"][@"sign"] succ:^{
                        faceStr = responseObject[@"data"][@"sign"];
                        [SVProgressHUD dismiss];
                        // 1. 创建live房间页面
                        LiveRoomViewController *liveRoomVC = [[LiveRoomViewController alloc] init];
                        //            liveRoomVC.RightButton.hidden = YES;
                        liveRoomVC.RightButton.hidden = YES;
                        liveRoomVC.num = self.num;
                        liveRoomVC.isjoin = YES;
                        liveRoomVC.curreryBlock = ^(NSString* roomID) {
                            self.stremid = roomID;
                        };
                        // 2. 创建房间配置对象
                        ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
                        option.imOption.imSupport = YES;
                        // 设置房间内音视频监听
                        option.memberStatusListener = liveRoomVC;
                        // 设置房间中断事件监听
                        option.roomDisconnectListener = liveRoomVC;
                        
                        // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
                        option.controlRole = @"cd_room";
                        
                        // 3. 调用创建房间接口，传入房间ID和房间配置对象
                        //        [string substringFromIndex:string.length - 8 ];
                        liveRoomVC.roomId = self.strid;
                        self.roomId = self.strid;
                        [[ILiveRoomManager getInstance] createRoom:[self.strid intValue] option:option succ:^{
                            // 创建房间成功，跳转到房间页
                            //                [self requestWithRoomID:self.strid]
                            liveRoomVC.roomId = self.strid;

                            ;
                            [self.navigationController pushViewController:liveRoomVC animated:YES];
                            
                        } failed:^(NSString *module, int errId, NSString *errMsg) {
                            // 创建房间失败
                            
                            [SVProgressHUD dismiss];
                            self.alertCtrl.title = @"创建房间失败";
                            self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
                            [self presentViewController:self.alertCtrl animated:YES completion:nil];
                        }];
                    } failed:^(NSString *module, int errId, NSString *errMsg) {
                        
                    }];
                } failure:^(NSError *error) {
                    
                }];
            }else
            {
                
                // 1. 创建live房间页面
                LiveRoomViewController *liveRoomVC = [[LiveRoomViewController alloc] init];
                //            liveRoomVC.RightButton.hidden = YES;
                liveRoomVC.RightButton.hidden =YES;
                liveRoomVC.num = self.num;
                liveRoomVC.isjoin = YES;

                liveRoomVC.curreryBlock = ^(NSString* roomID) {
                    self.stremid = roomID;
                };
                // 2. 创建房间配置对象
                ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
                option.imOption.imSupport = YES;
                // 设置房间内音视频监听
                option.memberStatusListener = liveRoomVC;
                // 设置房间中断事件监听
                option.roomDisconnectListener = liveRoomVC;
                
                // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
                option.controlRole = @"cd_room";
                
                // 3. 调用创建房间接口，传入房间ID和房间配置对象
                //        [string substringFromIndex:string.length - 8 ];
                liveRoomVC.roomId = self.strid;
                self.roomId = self.strid;
                [[ILiveRoomManager getInstance] createRoom:[self.strid intValue] option:option succ:^{
                    // 创建房间成功，跳转到房间页
                    //                [self requestWithRoomID:self.strid];
                    liveRoomVC.roomId = self.strid;

                    [self.navigationController pushViewController:liveRoomVC animated:YES];
                    
                } failed:^(NSString *module, int errId, NSString *errMsg) {
                    // 创建房间失败
                    
                    [SVProgressHUD dismiss];
                    self.alertCtrl.title = @"创建房间失败";
                    self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
                    [self presentViewController:self.alertCtrl animated:YES completion:nil];
                }];
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)joinWithNei
{
    
    NSString *str =  [[ILiveLoginManager getInstance] getLoginId];
    
    if (!str) {
        [SVProgressHUD showWithStatus:@""];
        TLNetworking *http = [TLNetworking new];
        http.code = @"630800";
        http.showView = self.view;
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        
        [http postWithSuccess:^(id responseObject) {
            
            [SVProgressHUD showWithStatus:@""];
            [[ILiveSDK getInstance] initSdk:[responseObject[@"data"][@"txAppCode"] intValue] accountType:[responseObject[@"data"][@"accountType"] intValue]];
            
            [[ILiveLoginManager getInstance] iLiveLogin:[USERDEFAULTS objectForKey:USER_ID] sig:responseObject[@"data"][@"sign"] succ:^{
                faceStr = responseObject[@"data"][@"txAppCode"];
                [SVProgressHUD dismiss];
                
                //提示框添加文本输入框
                //                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"面签" message:nil preferredStyle:UIAlertControllerStyleAlert];
                //
                //                UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                //                    for(UITextField *text in alert.textFields){
                //                        NSLog(@"text = %@", text.text);
                //
                // 1. 创建live房间页面
                FaceToFaceSignVC *liveRoomVC = [[FaceToFaceSignVC alloc] init];
                liveRoomVC.num = self.num;

                liveRoomVC.hidesBottomBarWhenPushed = YES;
                liveRoomVC.RightButton.hidden = YES;
                // 2. 创建房间配置对象
                ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
                option.imOption.imSupport = NO;
                // 不自动打开摄像头
                liveRoomVC.RightButton.hidden = YES;
                
                option.avOption.autoCamera = NO;
                // 不自动打开mic
                option.avOption.autoMic = NO;
                // 设置房间内音视频监听
                option.memberStatusListener = liveRoomVC;
                // 设置房间中断事件监听
                option.roomDisconnectListener = liveRoomVC;
                
                // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
                option.controlRole = @"cd_room";
                
                // 3. 调用创建房间接口，传入房间ID和房间配置对象
                [[ILiveRoomManager getInstance] joinRoom:[self.strid intValue] option:option succ:^{
                    // 加入房间成功，跳转到房间页
                    [self.navigationController pushViewController:liveRoomVC animated:YES];
                } failed:^(NSString *module, int errId, NSString *errMsg) {
                    // 加入房间失败
                    self.alertCtrl.title = @"加入房间失败";
                    self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
                    [self presentViewController:self.alertCtrl animated:YES completion:nil];
                }];
                
                
                //                    }
                //                }];
                //                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
                //                    NSLog(@"action = %@", alert.textFields);
                //                }];
                //                [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                //                    textField.placeholder = @"请输入面签房间号";
                //                    textField.borderStyle = UITextBorderStyleRoundedRect;
                //                    textField.frame = CGRectMake(0, 0, textField.frame.size.width, 50);
                //                }];
                //                [alert addAction:okAction];
                //                [alert addAction:cancelAction];
                //                [self presentViewController:alert animated:YES completion:nil];
                //
                // 登录成功，跳转到创建房间页
                
            } failed:^(NSString *module, int errId, NSString *errMsg) {
                NSLog(@"%@",errMsg);
                [SVProgressHUD dismiss];
                [TLAlert alertWithError:[NSString stringWithFormat:@"%@",errMsg]];
            }];
            NSLog(@"%@",responseObject);
            
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
            [SVProgressHUD dismiss];
        }];
    }else
    {
        //提示框添加文本输入框
        //        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"面签" message:nil preferredStyle:UIAlertControllerStyleAlert];
        //
        //        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //            for(UITextField *text in alert.textFields){
        //                NSLog(@"text = %@", text.text);
        //
        // 1. 创建live房间页面
        FaceToFaceSignVC *liveRoomVC = [[FaceToFaceSignVC alloc] init];
        liveRoomVC.RightButton.hidden = YES;
        liveRoomVC.num = self.num;

        liveRoomVC.hidesBottomBarWhenPushed = YES;
        // 2. 创建房间配置对象
        liveRoomVC.RightButton.hidden = YES;
        
        ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
        option.imOption.imSupport = NO;
        // 不自动打开摄像头
        option.avOption.autoCamera = NO;
        // 不自动打开mic
        option.avOption.autoMic = NO;
        // 设置房间内音视频监听
        option.memberStatusListener = liveRoomVC;
        // 设置房间中断事件监听
        option.roomDisconnectListener = liveRoomVC;
        
        // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
        option.controlRole = @"cd_room";
        
        // 3. 调用创建房间接口，传入房间ID和房间配置对象
        [[ILiveRoomManager getInstance] joinRoom:[self.strid intValue] option:option succ:^{
            // 加入房间成功，跳转到房间页
            [self.navigationController pushViewController:liveRoomVC animated:YES];
        } failed:^(NSString *module, int errId, NSString *errMsg) {
            // 加入房间失败
            self.alertCtrl.title = @"加入房间失败";
            self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
            [self presentViewController:self.alertCtrl animated:YES completion:nil];
        }];
        
        
        //            }
        //        }];
        //        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        //            NSLog(@"action = %@", alert.textFields);
        //        }];
        //        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        //            textField.placeholder = @"请输入面签房间号";
        //            textField.borderStyle = UITextBorderStyleRoundedRect;
        //            textField.frame = CGRectMake(0, 0, textField.frame.size.width, 50);
        //        }];
        //        [alert addAction:okAction];
        //        [alert addAction:cancelAction];
        //        [self presentViewController:alert animated:YES completion:nil];
    }
    
    //        }
    
    //    } failure:^(NSError *error) {
    //
    //    }];
}


- (void)checkCount
{
    
    TLNetworking *ht = [TLNetworking new];
    ht.code = @"632953";
    ht.parameters[@"roomId"] = self.strid;
    ht.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];

    ht.showView = self.view;
    [ht postWithSuccess:^(id responseObject) {
        NSNumber *num = responseObject[@"data"];
        
        if ([num longValue] >= 3) {
            [TLAlert alertWithMsg:@"房间已满"];
        }else{
            
            [self sendPhoneCode];
            
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)rightButtonClick
{
  
    TLNetworking *ht = [TLNetworking new];
    ht.code = @"632954";
    
    ht.parameters[@"budgetCode"] = self.model.code;

    ht.showView = self.view;
    [ht postWithSuccess:^(id responseObject) {
        NSDictionary *dic = responseObject[@"data"];;
        if ([dic count]) {
            //不为空
            if ([dic[@"status"] isEqualToString:@"0"]) {
//                [self joinFaceSign:dic[@"code"]];
                self.strid = dic[@"code"];;

                faceStr = @"1";
                [self checkCount];
//                [self requestIsEmpy];

            }else{
                faceStr = @"";

                [self requestIsEmpy];

            }
        }else{
            
            [self requestIsEmpy];

        }
    } failure:^(NSError *error) {
        
    }];
 

}

-(void)joinFaceSign:(NSString *)roomId
{
 
        TLNetworking *ht = [TLNetworking new];
        ht.code = @"632953";
        ht.parameters[@"roomId"] = roomId;
        ht.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];

        ht.showView = self.view;
        [ht postWithSuccess:^(id responseObject) {
            NSNumber *num = responseObject[@"data"];
            
            if ([num longValue] >= 3) {
                [TLAlert alertWithMsg:@"房间已满"];
            }else if ([num longValue] == 0)
            {
                
                [self requestIsEmpy];
                return ;
                
            }
            else
            {
                self.num = num;
//                [self sendPhoneCode];
                //加入房间
//                if (![faceStr isEqualToString:@""]) {
//                     [self requestIsEmpy];
//                }else{
                self.isJoin = YES;
//                    [self joinRoomWithID:roomId];
                [self requestIsEmpy];

//                }
                
            }
            
        } failure:^(NSError *error) {
            
        }];
 
    
}
- (void)joinRoomWith:(NSString *)idstr
{
    
        if ([faceStr isEqualToString:@""]) {
            TLNetworking *http = [TLNetworking new];
            http.code = @"630800";
            http.showView = self.view;
            http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
            
            [http postWithSuccess:^(id responseObject) {
                
                [SVProgressHUD showWithStatus:@""];
                
                [[ILiveSDK getInstance] initSdk:[responseObject[@"data"][@"txAppCode"] intValue] accountType:[responseObject[@"data"][@"accountType"] intValue]];
                
                [[ILiveLoginManager getInstance] iLiveLogin:[USERDEFAULTS objectForKey:USER_ID] sig:responseObject[@"data"][@"sign"] succ:^{
                    faceStr = responseObject[@"data"][@"sign"];
                    [SVProgressHUD dismiss];
                    // 1. 创建live房间页面
                    LiveRoomViewController *liveRoomVC = [[LiveRoomViewController alloc] init];
                    liveRoomVC.RightButton.hidden = self.isJoin;
                    liveRoomVC.curreryBlock = ^(NSString* roomID) {
                        self.stremid = roomID;
                    };
                    // 2. 创建房间配置对象
                    ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
                    //                option.imOption.imSupport = YES;
                    
                    // 设置房间内音视频监听
                    option.memberStatusListener = liveRoomVC;
                    // 设置房间中断事件监听
                    option.roomDisconnectListener = liveRoomVC;
                    
                    // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
                    option.controlRole = @"cd_room";
                    NSString *userID = [USERDEFAULTS objectForKey:USER_ID];;
                    //                    userID = [userID substringFromIndex:userID.length-7];
                    //                liveRoomVC.curreryBlock = ^(long long roomID) {
                    //                    NSString *current = [NSString getCurrentTimes];
                    //                     NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
                    //                    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
                    //                    theTime += 60*60*24*2;
                    //                    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
                    //
                    //                    NSString *md5 = [NSString stringWithFormat:@"%@_%@_main",userID,[USERDEFAULTS objectForKey:USER_ID]];
                    //                    md5 = [md5 md5String];
                    //                    NSString *newMd5 = [NSString stringWithFormat:@"32810_%@",md5];
                    //                    NSLog(@"%@",newMd5);//直播码
                    //
                    //
                    //                    NSString *newSign = [NSString stringWithFormat:@"152d1d67ad2dda121dc4ad95bc05b269%@",@"1471850187"];
                    //                    newSign = [newSign md5String]; //签名
                    //                    NSString *  URL =  [NSString stringWithFormat:@"http://fcgi.video.qcloud.com/common_access?appid=1257046543&interface=Live_Tape_GetFilelist&Param.s.channel_id=%@&t=%@&sign=%@&Param.s.start_time=%@",newMd5,curTime,newSign,current];
                    //                    URL = [URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    //                    AFHTTPSessionManager *afn = [AFHTTPSessionManager manager];
                    //
                    //                    afn.responseSerializer = [AFHTTPResponseSerializer serializer];
                    //
                    //                    [afn POST:URL parameters:Nil progress:Nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    //                        NSLog(@"%@",responseObject);
                    //                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    //                        NSLog(@"%@",error);
                    //                    }];
                    //
                    //                };
                    [[ILiveRoomManager getInstance] createRoom:[idstr intValue] option:option succ:^{
                        // 创建房间成功，跳转到房间页
                        
                        liveRoomVC.roomId = self.strid;
                        
                        [self.navigationController pushViewController:liveRoomVC animated:YES];
                        
                    } failed:^(NSString *module, int errId, NSString *errMsg) {
                        // 创建房间失败
                        
                        [SVProgressHUD dismiss];
                        self.alertCtrl.title = @"创建房间失败";
                        self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
                        [self presentViewController:self.alertCtrl animated:YES completion:nil];
                    }];
                    
                    
                    // 登录成功，跳转到创建房间页
                    
                } failed:^(NSString *module, int errId, NSString *errMsg) {
                    NSLog(@"%@",errMsg);
                    [TLAlert alertWithError:[NSString stringWithFormat:@"%@",errMsg]];
                }];
                NSLog(@"%@",responseObject);
                
            } failure:^(NSError *error) {
                WGLog(@"%@",error);
            }];
        }else
        {
            
           NSString *str =  [[ILiveLoginManager getInstance] getLoginId];
            if (!str) {
                TLNetworking *htt = [TLNetworking new];
                htt.code = @"630800";
                htt.showView = self.view;
                htt.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
                
                [htt postWithSuccess:^(id responseObject) {
                [[ILiveSDK getInstance] initSdk:[responseObject[@"data"][@"txAppCode"] intValue] accountType:[responseObject[@"data"][@"accountType"] intValue]];
                [[ILiveLoginManager getInstance] iLiveLogin:[USERDEFAULTS objectForKey:USER_ID] sig:responseObject[@"data"][@"sign"] succ:^{
                    faceStr = responseObject[@"data"][@"sign"];
                    [SVProgressHUD dismiss];
                    // 1. 创建live房间页面
                    LiveRoomViewController *liveRoomVC = [[LiveRoomViewController alloc] init];
                    //            liveRoomVC.RightButton.hidden = YES;
                    liveRoomVC.RightButton.hidden = self.isJoin;
                    
                    liveRoomVC.curreryBlock = ^(NSString* roomID) {
                        self.stremid = roomID;
                    };
                    // 2. 创建房间配置对象
                    ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
                    option.imOption.imSupport = YES;
                    // 设置房间内音视频监听
                    option.memberStatusListener = liveRoomVC;
                    // 设置房间中断事件监听
                    option.roomDisconnectListener = liveRoomVC;
                    
                    // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
                    option.controlRole = @"cd_room";
                    
                    // 3. 调用创建房间接口，传入房间ID和房间配置对象
                    //        [string substringFromIndex:string.length - 8 ];
                    liveRoomVC.roomId = self.strid;
                    self.roomId = self.strid;
                    [[ILiveRoomManager getInstance] createRoom:[idstr intValue] option:option succ:^{
                        // 创建房间成功，跳转到房间页
                        //                [self requestWithRoomID:self.strid];
                        [self.navigationController pushViewController:liveRoomVC animated:YES];
                        
                    } failed:^(NSString *module, int errId, NSString *errMsg) {
                        // 创建房间失败
                        
                        [SVProgressHUD dismiss];
                        self.alertCtrl.title = @"创建房间失败";
                        self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
                        [self presentViewController:self.alertCtrl animated:YES completion:nil];
                    }];
                } failed:^(NSString *module, int errId, NSString *errMsg) {
                    
                }];
                } failure:^(NSError *error) {
                    
                }];
            }else
            {
            
            // 1. 创建live房间页面
            LiveRoomViewController *liveRoomVC = [[LiveRoomViewController alloc] init];
//            liveRoomVC.RightButton.hidden = YES;
            liveRoomVC.RightButton.hidden = self.isJoin;

            liveRoomVC.curreryBlock = ^(NSString* roomID) {
                self.stremid = roomID;
            };
            // 2. 创建房间配置对象
            ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
            option.imOption.imSupport = YES;
            // 设置房间内音视频监听
            option.memberStatusListener = liveRoomVC;
            // 设置房间中断事件监听
            option.roomDisconnectListener = liveRoomVC;
            
            // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
            option.controlRole = @"cd_room";
            
            // 3. 调用创建房间接口，传入房间ID和房间配置对象
            //        [string substringFromIndex:string.length - 8 ];
            liveRoomVC.roomId = self.strid;
            self.roomId = self.strid;
            [[ILiveRoomManager getInstance] createRoom:[idstr intValue] option:option succ:^{
                // 创建房间成功，跳转到房间页
                //                [self requestWithRoomID:self.strid];
                [self.navigationController pushViewController:liveRoomVC animated:YES];
                
            } failed:^(NSString *module, int errId, NSString *errMsg) {
                // 创建房间失败
                
                [SVProgressHUD dismiss];
                self.alertCtrl.title = @"创建房间失败";
                self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
                [self presentViewController:self.alertCtrl animated:YES completion:nil];
            }];
            }
        }
    
}

//- (void)joinRoomWithID:(NSString *)idstr
//{
//
//    if ([faceStr isEqualToString:@""]) {
//        [SVProgressHUD showWithStatus:@""];
//        TLNetworking *http = [TLNetworking new];
//        http.code = @"630800";
//        http.showView = self.view;
//        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
//
//        [http postWithSuccess:^(id responseObject) {
//
//            [SVProgressHUD showWithStatus:@""];
//            [[ILiveSDK getInstance] initSdk:[responseObject[@"data"][@"txAppCode"] intValue] accountType:[responseObject[@"data"][@"accountType"] intValue]];
//
//            [[ILiveLoginManager getInstance] iLiveLogin:[USERDEFAULTS objectForKey:USER_ID] sig:responseObject[@"data"][@"sign"] succ:^{
//                faceStr = responseObject[@"data"][@"txAppCode"];
//                [SVProgressHUD dismiss];
//                //提示框添加文本输入框
////                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"面签" message:nil preferredStyle:UIAlertControllerStyleAlert];
//
////                UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
////                    for(UITextField *text in alert.textFields){
////                        NSLog(@"text = %@", text.text);
//
//                        // 1. 创建live房间页面
//                        FaceToFaceSignVC *liveRoomVC = [[FaceToFaceSignVC alloc] init];
//                        liveRoomVC.curreryBlock = ^(NSString* roomID) {
//                            self.stremid = roomID;
//                        };
//                        liveRoomVC.hidesBottomBarWhenPushed = YES;
//                        // 2. 创建房间配置对象
//                        liveRoomVC.isJoin = NO;
//
//                        ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
//                        option.imOption.imSupport = NO;
//                        // 不自动打开摄像头
//                        option.avOption.autoCamera = NO;
//                        // 不自动打开mic
//                        option.avOption.autoMic = NO;
//                        // 设置房间内音视频监听
//                        option.memberStatusListener = liveRoomVC;
//                        // 设置房间中断事件监听
//                        option.roomDisconnectListener = liveRoomVC;
//
//                        // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
//                        option.controlRole = @"cd_room";
//
//                        // 3. 调用创建房间接口，传入房间ID和房间配置对象
//                        [[ILiveRoomManager getInstance] joinRoom:[idstr intValue] option:option succ:^{
//                            // 加入房间成功，跳转到房间页
//                            [self.navigationController pushViewController:liveRoomVC animated:YES];
//                        } failed:^(NSString *module, int errId, NSString *errMsg) {
//                            // 加入房间失败
//                            self.alertCtrl.title = @"加入房间失败";
//                            self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
//                            [self presentViewController:self.alertCtrl animated:YES completion:nil];
//                        }];
//
////
////                    }
////                }];
////                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
////                    NSLog(@"action = %@", alert.textFields);
////                }];
////                [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
////                    textField.text = idstr;
////                    textField.borderStyle = UITextBorderStyleRoundedRect;
////                    textField.frame = CGRectMake(0, 0, textField.frame.size.width, 50);
////                }];
////                [alert addAction:okAction];
////                [alert addAction:cancelAction];
////                [self presentViewController:alert animated:YES completion:nil];
//
//                // 登录成功，跳转到创建房间页
//
//            } failed:^(NSString *module, int errId, NSString *errMsg) {
//                NSLog(@"%@",errMsg);
//                [SVProgressHUD dismiss];
//                [TLAlert alertWithError:[NSString stringWithFormat:@"%@",errMsg]];
//            }];
//            NSLog(@"%@",responseObject);
//
//        } failure:^(NSError *error) {
//            WGLog(@"%@",error);
//            [SVProgressHUD dismiss];
//        }];
//    }else
//    {
//        //提示框添加文本输入框
////        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"面签" message:nil preferredStyle:UIAlertControllerStyleAlert];
////
////        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
////            for(UITextField *text in alert.textFields){
////                NSLog(@"text = %@", text.text);
//
//                // 1. 创建live房间页面
//                FaceToFaceSignVC *liveRoomVC = [[FaceToFaceSignVC alloc] init];
//                liveRoomVC.isJoin = NO;
//                liveRoomVC.curreryBlock = ^(NSString* roomID) {
//                    self.stremid = roomID;
//                };
//                liveRoomVC.hidesBottomBarWhenPushed = YES;
//                // 2. 创建房间配置对象
//                ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
//                option.imOption.imSupport = NO;
//                // 不自动打开摄像头
//                option.avOption.autoCamera = NO;
//                // 不自动打开mic
//                option.avOption.autoMic = NO;
//                // 设置房间内音视频监听
//                option.memberStatusListener = liveRoomVC;
//                // 设置房间中断事件监听
//                option.roomDisconnectListener = liveRoomVC;
//
//                // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
//                option.controlRole = @"cd_room";
//
//                // 3. 调用创建房间接口，传入房间ID和房间配置对象
//                [[ILiveRoomManager getInstance] joinRoom:[idstr intValue] option:option succ:^{
//                    // 加入房间成功，跳转到房间页
//                    [self.navigationController pushViewController:liveRoomVC animated:YES];
//                } failed:^(NSString *module, int errId, NSString *errMsg) {
//                    // 加入房间失败
//                    self.alertCtrl.title = @"加入房间失败";
//                    self.alertCtrl.message = [NSString stringWithFormat:@"errId:%d errMsg:%@",errId, errMsg];
//                    [self presentViewController:self.alertCtrl animated:YES completion:nil];
//                }];
//
//
////            }
////        }];
////        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
////            NSLog(@"action = %@", alert.textFields);
////        }];
////        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
////            textField.text = idstr;
////            textField.borderStyle = UITextBorderStyleRoundedRect;
////            textField.frame = CGRectMake(0, 0, textField.frame.size.width, 50);
////        }];
////        [alert addAction:okAction];
////        [alert addAction:cancelAction];
////        [self presentViewController:alert animated:YES completion:nil];
//    }
//
//
//}

- (void)requestIsEmpy
{
   
    TLNetworking *ht = [TLNetworking new];
    ht.code = @"632950";
    ht.parameters[@"budgetCode"] = self.model.code;
    ht.parameters[@"homeOwnerId"] =[USERDEFAULTS objectForKey:USER_ID];

    ht.showView = self.view;
    [ht postWithSuccess:^(id responseObject) {
        self.strid = responseObject[@"data"];;
        NSLog(@"strid%@",self.strid);
        [self checkCount];
    } failure:^(NSError *error) {
        
    }];
}

- (void)loginOutRoom
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"632955";
    http.showView = self.view;
    http.parameters[@"code"] = self.strid;
    [http postWithSuccess:^(id responseObject) {
        NSLog(@"%@",responseObject);
          faceStr = @"";
        [TLAlert alertWithInfo:@"已退出房间"];

    } failure:^(NSError *error) {
        
    }];
}

- (void)loadEndMovieUrlOut
{
    
    if (self.isroomManger == YES) {
        [TLAlert alertWithTitle:@"提示" msg:@"是否保存录制" confirmMsg:@"取消" cancleMsg:@"确认" cancle:^(UIAlertAction *action) {
            //取消
            [self loginOutRoom];
        } confirm:^(UIAlertAction *action) {
            //确认
            [self loginOutRoom];
            
        }];
    }else{
        return;
    }

    if (self.stremid != nil) {
        [TLAlert alertWithInfo:@"正在获取录制视频"];
        TLNetworking *http = [TLNetworking new];
        http.code = @"632952";
        http.showView = self.view;
        http.parameters[@"streamId"] = self.stremid;
        [NSThread sleepForTimeInterval:3];
        [http postWithSuccess:^(id responseObject) {
            
            NSString *strUrl = [responseObject[@"data"] stringByReplacingOccurrencesOfString:@"\%" withString:@""];
            //        NSString * jsonString = @"";
            NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = dic[@"output"][@"file_list"];
            if (arr.count > 0) {
                NSDictionary *url = dic[@"output"][@"file_list"][0];
                self.signPlayUrl = url[@"record_file_url"];
                NSLog(@"%@",url);
                if (self.BankVideoArray.count == 0) {
                    self.BankVideoArray = [NSMutableArray array];
                }
                if (self.BankVideoDataArray.count == 0) {
                    self.BankVideoDataArray = [NSMutableArray array];
                }
                [self.BankVideoArray addObject:self.signPlayUrl];
                [self.BankVideoDataArray addObject:self.signPlayUrl];
                self.tableView.BankVideoArray = self.BankVideoArray;
                [self.tableView reloadData];
                self.isroomManger = NO;
            }
       
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}

- (void)loadEndMovieUrl:(NSString *)str
{
    
    
}


//- (void)requestWithRoomID : (NSString *)roomid
//{

//
//}

#pragma mark - Accessor
- (UIAlertController *)alertCtrl {
    if (!_alertCtrl) {
        _alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }] ;
        [_alertCtrl addAction:action];
    }
    return _alertCtrl;
}



@end