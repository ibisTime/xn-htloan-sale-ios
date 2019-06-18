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
@interface FaceSignMQVC ()<RefreshDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSString *Str1;
    NSString *Str2;
    NSString *Str3;
    NSString *Str4;
    NSString *Str5;

    NSString *faceStr;
    NSArray *_phostsArr;
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
@property (nonatomic , assign)NSInteger count;
@end

@implementation FaceSignMQVC

- (TLImagePicker *)imagePicker {

    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];

        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            NSLog(@"%@",info);
            if (self.selectInt <  4 && self.selectInt > 0) {

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
                NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
                [SVProgressHUD showWithStatus:@"上传中"];
                //进行上传
                TLUploadManager *manager = [TLUploadManager manager];

                manager.imgData = imgData;
                manager.image = image;
                [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
                    WGLog(@"%@",key);
                    [weakSelf setImage:image setData:key];

                } failure:^(NSError *error) {
                    [TLAlert alertWithInfo:@"上传失败"];
                }];
            }
        };
    }
    return _imagePicker;
}
-(void)addButClick
{
    
    UIImagePickerController *pickCtrl = [[UIImagePickerController alloc] init];
    pickCtrl.delegate = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        [action setValue:HGColor(138, 138, 138) forKey:@"titleTextColor"];
    }];
    UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {
        
        pickCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pickCtrl animated:YES completion:nil];
        
    }];
    UIAlertAction* fromPhotoAction1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {
        
        pickCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        WPhotoViewController *WphotoVC = [[WPhotoViewController alloc] init];
        //选择图片的最大数
        WphotoVC.selectPhotoOfMax = 9;
        [WphotoVC setSelectPhotosBack:^(NSMutableArray *phostsArr) {
            _phostsArr = phostsArr;
            self.count = phostsArr.count - 1;
            [self updataphoto];
        }];
        [self presentViewController:WphotoVC animated:YES completion:nil];
        
    }];
    [cancelAction setValue:GaryTextColor forKey:@"_titleTextColor"];
    [fromPhotoAction setValue:MainColor forKey:@"_titleTextColor"];
    [fromPhotoAction1 setValue:MainColor forKey:@"_titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:fromPhotoAction];
    [alertController addAction:fromPhotoAction1];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)updataphoto
{
    CarLoansWeakSelf;
    UIImage *image = _phostsArr[self.count][@"image"];
    NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
    //进行上传
    TLUploadManager *manager = [TLUploadManager manager];
    manager.imgData = imgData;
    manager.image = image;
    manager.isdissmiss = NO;
    [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
        WGLog(@"%@",key);
        self.count --;
        [weakSelf setImage:image setData:key];
        if (self.count >= 0) {
            [self updataphoto];
        }
    } failure:^(NSError *error) {
        [TLAlert alertWithInfo:@"上传失败"];
    }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    CarLoansWeakSelf;
    UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
    NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
    
    //进行上传
    TLUploadManager *manager = [TLUploadManager manager];
    
    manager.imgData = imgData;
    manager.image = image;
    [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
        WGLog(@"%@",key);
        [weakSelf setImage:image setData:key];
        [picker dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
        [TLAlert alertWithInfo:@"上传失败"];
        [picker dismissViewControllerAnimated:YES completion:nil];
    }];
}
-(void)setVideoStr:(NSString *)video setData:(NSString *)data
{

    if ([data containsString:@"tmp/"]) {
        [TLAlert alertWithMsg:@"请重新上传视频"];
        return;
    }
    switch (self.selectInt) {
        case 1:
        {
//            if (self.BankVideoArray.count == 0) {
//                self.BankVideoArray = [NSMutableArray array];
//            }
            [self.BankVideoArray addObject:data];

            self.tableView.BankVideoArray = self.BankVideoArray;
        }
            break;
        case 2:
        {
//            if (self.CompanyVideoArray.count ==0) {
//                self.CompanyVideoArray = [NSMutableArray array];
//            }

            [self.CompanyVideoArray addObject:data];

            self.tableView.CompanyVideoArray = self.CompanyVideoArray;
        }
            break;
        case 3:
        {
//            if (self.OtherVideoArray.count ==0) {
//                self.OtherVideoArray = [NSMutableArray array];
//            }

            [self.OtherVideoArray addObject:data];
            self.tableView.OtherVideoArray = self.OtherVideoArray;


        }
            break;

        default:
            break;

    }
    [self.tableView reloadData];
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{

    switch (_selectInt) {
        case 4:
        {
//            if (self.BankSignArray.count == 0) {
//                self.BankSignArray = [NSMutableArray array];
//            }
            [self.BankSignArray addObject:data];
            self.tableView.BankSignArray = self.BankSignArray;
        }
            break;
        case 5:
        {
//            if (self.BankContractArray.count == 0) {
//                self.BankContractArray = [NSMutableArray array];
//            }
            [self.BankContractArray addObject:data];
            self.tableView.BankContractArray = self.BankContractArray;

        }
            break;
        case 6:
        {
//            if (self.CompanyContractArray.count == 0) {
//                self.CompanyContractArray = [NSMutableArray array];
//            }
            [self.CompanyContractArray addObject:data];
            self.tableView.CompanyContractArray = self.CompanyContractArray;

        }
            break;
        case 7:
        {
//            if (self.MoneyArray.count == 0) {
//                self.MoneyArray = [NSMutableArray array];
//            }
            [self.MoneyArray addObject:data];
            self.tableView.MoneyArray = self.MoneyArray;

        }
            break;
        case 8:
        {
//            if (self.otherArray.count == 0) {
//                self.otherArray = [NSMutableArray array];
//            }
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

    _BankSignArray = [NSMutableArray array];
    _BankContractArray = [NSMutableArray array];
    _CompanyContractArray = [NSMutableArray array];
    _MoneyArray = [NSMutableArray array];
    _otherArray = [NSMutableArray array];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    http.showView = self.view;
    http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
        [self FaceToFaceContent];
    } failure:^(NSError *error) {
        
    }];

    [self navigativeView];
//    [self initTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadEndMovieUrlOut) name:@"KsingOut" object:nil];
}

-(void)FaceToFaceContent
{
    
    for (int i = 0; i < self.model.attachments.count; i ++) {
        NSDictionary *dic = self.model.attachments[i];
//        银行视频
        if ([dic[@"kname"] isEqualToString:@"bank_video"]) {
            if (![dic[@"url"] isEqualToString:@""]) {
            [self.BankVideoArray addObjectsFromArray:[dic[@"url"] componentsSeparatedByString:@"||"]];
            self.tableView.BankVideoArray = self.BankVideoArray;
            }
        }
//        公司视频
        if ([dic[@"kname"] isEqualToString:@"company_video"]) {
            if (![dic[@"url"] isEqualToString:@""]) {
            [self.CompanyVideoArray addObjectsFromArray:[dic[@"url"] componentsSeparatedByString:@"||"]];
            self.tableView.CompanyVideoArray = self.CompanyVideoArray;
            }
        }
//        其他视频
        if ([dic[@"kname"] isEqualToString:@"other_video"]) {
            if (![dic[@"url"] isEqualToString:@""]) {
                [self.OtherVideoArray addObjectsFromArray:[dic[@"url"] componentsSeparatedByString:@"||"]];
                self.tableView.OtherVideoArray = self.OtherVideoArray;
            }
            
        }
//        银行面签图片
        if ([dic[@"kname"] isEqualToString:@"bank_photo"]) {
            if (![dic[@"url"] isEqualToString:@""]) {
            [self.BankSignArray addObjectsFromArray:[dic[@"url"] componentsSeparatedByString:@"||"]];
            self.tableView.BankSignArray = self.BankSignArray;
            }
        }
//        银行合同
        if ([dic[@"kname"] isEqualToString:@"bank_contract"]) {
            if (![dic[@"url"] isEqualToString:@""]) {
            [self.BankContractArray addObjectsFromArray:[dic[@"url"] componentsSeparatedByString:@"||"]];
            self.tableView.BankContractArray = self.BankContractArray;
            }
        }
//        公司合同
        if ([dic[@"kname"] isEqualToString:@"company_contract"]) {
            if (![dic[@"url"] isEqualToString:@""]) {
            [self.CompanyContractArray addObjectsFromArray:[dic[@"url"] componentsSeparatedByString:@"||"]];
            self.tableView.CompanyContractArray = self.CompanyContractArray;
            }
        }
        
//        资金划转授权书
        if ([dic[@"kname"] isEqualToString:@"advance_fund_amount_pdf"]) {
            if (![dic[@"url"] isEqualToString:@""]) {
            [self.MoneyArray addObjectsFromArray:[dic[@"url"] componentsSeparatedByString:@"||"]];
            self.tableView.MoneyArray = self.MoneyArray;
            }
        }
        
//        面签其他资料
        if ([dic[@"kname"] isEqualToString:@"interview_other_pdf"]) {
            if (![dic[@"url"] isEqualToString:@""]) {
            [self.otherArray addObjectsFromArray:[dic[@"url"] componentsSeparatedByString:@"||"]];
             self.tableView.otherArray = self.otherArray;
            }
        }
    }
    [self.tableView reloadData];
}


//上传图片   视频
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    self.selectInt = index;
    if ([state isEqualToString:@"add"]) {
        if (index < 4 && index > 0) {
            [self.imagePicker videoPicker];
        }else
        {
//            [self.imagePicker picker];
            [self addButClick];
        }
    }else
    {
        NSLog(@"删除 %ld",index);
        if (index == 1)
        {
//            [self.BankVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.BankVideoArray.count > 0) {
                [self.BankVideoArray removeObjectAtIndex:sender.tag - 1000];

            }
        }
        else if (index == 2)
        {
//            [self.CompanyVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.CompanyVideoArray.count > 0) {
                [self.CompanyVideoArray removeObjectAtIndex:sender.tag - 1000];

            }
        }
        else if (index == 3)
        {

//            [self.OtherVideoArray removeObjectAtIndex:sender.tag - 1000];
            if (self.OtherVideoArray.count > 0) {
                [self.OtherVideoArray removeObjectAtIndex:sender.tag - 1000];

            }
        }
        else if (index == 4)
        {
            
            if (self.BankSignArray.count > 0) {
                [self.BankSignArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 5)
        {
            
            if (self.BankContractArray.count > 0) {
                [self.BankContractArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 6)
        {
            
            if (self.CompanyContractArray.count > 0) {
                [self.CompanyContractArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 7)
        {
            
            if (self.MoneyArray.count > 0) {
                [self.MoneyArray removeObjectAtIndex:sender.tag - 1000];
                
            }
        }
        else if (index == 8)
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
        if (_BankVideoArray.count == 0) {
            [TLAlert alertWithInfo:@"请上传银行视频"];
            return;
        }
        if (_CompanyVideoArray.count == 0) {
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
    http.parameters[@"bankVideo"] = [_BankVideoArray componentsJoinedByString:@"||"];
    http.parameters[@"companyVideo"] = [_CompanyVideoArray componentsJoinedByString:@"||"];
    if (sender.tag == 10001) {
        http.parameters[@"isSend"] = @"0";

    }else{
        http.parameters[@"isSend"] = @"1";

    }

    http.parameters[@"otherVideo"] = [_OtherVideoArray componentsJoinedByString:@"||"];
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
            
        }
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}


- (void)initTableView {
    self.tableView = [[FaceSignMQTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
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


-(void)rightButtonClick
{
    
    TLNetworking *ht = [TLNetworking new];
    ht.code = @"632954";
    ht.parameters[@"budgetCode"] = self.model.code;
    ht.showView = self.view;
    [ht postWithSuccess:^(id responseObject) {
        NSDictionary *dic = responseObject[@"data"];;
        if ([dic[@"status"] isEqualToString:@"0"]) {
            self.strid = dic[@"code"];;
            //            房间已经存在
            //                faceStr = @"1";
            self.isJoin = YES;
            
            [self checkCount];
            
        }else{
            //            房间不存在
            //                faceStr = @"";
            
            self.isJoin = NO;
            [self requestIsEmpy];
            
            
            
            
            
        }

    } failure:^(NSError *error) {

    }];

}

///获取房间人数
- (void)checkCount
{
    
    TLNetworking *ht = [TLNetworking new];
    ht.code = @"632953";
    ht.showView = self.view;
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

-(void)join
{
    
}
//
- (void)requestIsEmpy
{
    TLNetworking *ht = [TLNetworking new];
    ht.code = @"632950";
    ht.showView = self.view;
    ht.parameters[@"budgetCode"] = self.model.code;
    ht.parameters[@"homeOwnerId"] =[USERDEFAULTS objectForKey:USER_ID];
    
    ht.showView = self.view;
    [ht postWithSuccess:^(id responseObject) {
        self.strid = responseObject[@"data"];;
        NSLog(@"strid%@",self.strid);
        
//        发送短信
        TLNetworking *ht = [TLNetworking new];
        ht.code = @"632136";
        ht.parameters[@"roomId"] = self.strid;
        ht.parameters[@"code"] = self.model.code;
        
        ht.showView = self.view;
        [ht postWithSuccess:^(id responseObject) {
            
            [self checkCount];
            
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];
        
    } failure:^(NSError *error) {
        
    }];
}


//退出房间
//- (void)loginOutRoom
//{
//    TLNetworking *http = [TLNetworking new];
//    http.code = @"632955";
//    http.showView = self.view;
//    http.parameters[@"code"] = self.strid;
//    [http postWithSuccess:^(id responseObject) {
//        NSLog(@"%@",responseObject);
//
//        [TLAlert alertWithSucces:@"已退出房间"];
//
//    } failure:^(NSError *error) {
//
//    }];
//}

//发起面签
- (void)sendPhoneCode
{
    
        
    TLNetworking *http= [TLNetworking new];
    http.code = @"630800";
    http.showView = self.view;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    
    [http postWithSuccess:^(id responseObject) {
        
        [SVProgressHUD showWithStatus:@""];
        NSString *str =  [[ILiveLoginManager getInstance] getLoginId];
        if (!str) {
            [[ILiveSDK getInstance] initSdk:[responseObject[@"data"][@"txAppCode"] intValue] accountType:[responseObject[@"data"][@"accountType"] intValue]];
            
            [[ILiveLoginManager getInstance] iLiveLogin:[USERDEFAULTS objectForKey:USER_ID] sig:responseObject[@"data"][@"sign"] succ:^{
                //                    faceStr = responseObject[@"data"][@"sign"];
                [SVProgressHUD dismiss];
                
                if (self.isJoin == YES) {
                    // 1. 创建live房间页面
                    
                    
                    
                    
                    
                    FaceToFaceSignVC *liveRoomVC = [[FaceToFaceSignVC alloc] init];
                    liveRoomVC.hidesBottomBarWhenPushed = YES;
                    // 2. 创建房间配置对象
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
                }else
                {
                    // 1. 创建live房间页面
                    LiveRoomViewController *liveRoomVC = [[LiveRoomViewController alloc] init];
                    liveRoomVC.isjoin = self.isJoin;
                    liveRoomVC.roomId = self.strid;
                    liveRoomVC.curreryBlock = ^(NSString* roomID) {
                        self.stremid = roomID;
//                        [self loadEndMovieUrlOut];
                    };
                    // 2. 创建房间配置对象
                    ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
                    //                option.imOption.imSupport = YES;
                    
                    // 设置房间内音视频监听
                    option.memberStatusListener = liveRoomVC;
                    // 设置房间中断事件监听
                    option.roomDisconnectListener = liveRoomVC;
                    
                    // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
                    option.controlRole = @"user";
                    
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
                }
                
                
                
                
                // 登录成功，跳转到创建房间页
                
            } failed:^(NSString *module, int errId, NSString *errMsg) {
                NSLog(@"%@",errMsg);
                [SVProgressHUD dismiss];
                
                [TLAlert alertWithError:[NSString stringWithFormat:@"%@",errMsg]];
            }];
            NSLog(@"%@",responseObject);
            
            
        }else
        {
            
            if (self.isJoin == YES) {
                // 1. 创建live房间页面
                FaceToFaceSignVC *liveRoomVC = [[FaceToFaceSignVC alloc] init];
                liveRoomVC.hidesBottomBarWhenPushed = YES;
                // 2. 创建房间配置对象
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
            }else
            {
                // 1. 创建live房间页面
                LiveRoomViewController *liveRoomVC = [[LiveRoomViewController alloc] init];
                liveRoomVC.isjoin = self.isJoin;
                liveRoomVC.roomId = self.strid;
                //                    self.isroomManger = YES;
                //                    self.stremid = nil;
                //                    liveRoomVC.faceStr = faceStr;
                liveRoomVC.curreryBlock = ^(NSString* roomID) {
                    self.stremid = roomID;
//                    [self loadEndMovieUrlOut];
                };
                // 2. 创建房间配置对象
                ILiveRoomOption *option = [ILiveRoomOption defaultHostLiveOption];
                //                option.imOption.imSupport = YES;
                
                // 设置房间内音视频监听
                option.memberStatusListener = liveRoomVC;
                // 设置房间中断事件监听
                option.roomDisconnectListener = liveRoomVC;
                
                // 该参数代表进房之后使用什么规格音视频参数，参数具体值为客户在腾讯云实时音视频控制台画面设定中配置的角色名（例如：默认角色名为user, 可设置controlRole = @"user"）
                option.controlRole = @"user";
                
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
            }
        }
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];

}



//录制通知
- (void)loadEndMovieUrlOut
{
    
    if ([BaseModel isBlankString:self.stremid] == NO) {
    
        [TLAlert alertWithTitle:@"提示" msg:@"是否获取视频" confirmMsg:@"确认" cancleMsg:@"取消" maker:self cancle:^(UIAlertAction *action) {
            
        } confirm:^(UIAlertAction *action) {
            [SVProgressHUD showWithStatus:@"正在获取录制视频"];
            [self video];
        }];
    }
}

-(void)video
{
    if ([BaseModel isBlankString:self.stremid] == NO) {
        TLNetworking *http = [TLNetworking new];
        http.code = @"632952";
        http.showView = self.view;
        http.parameters[@"streamId"] = self.stremid;
        [NSThread sleepForTimeInterval:3];
        [http postWithSuccess:^(id responseObject) {
            
            self.signPlayUrl = responseObject[@"data"];
            if ([BaseModel isBlankString:self.signPlayUrl] == YES) {
                [TLAlert alertWithTitle:@"提示" msg:@"获取失败，是否重新获取" confirmMsg:@"确认" cancleMsg:@"取消" maker:self cancle:^(UIAlertAction *action) {
                    
                } confirm:^(UIAlertAction *action) {
                    [self loadEndMovieUrlOut];
                }];
            }else
            {
                [self.BankVideoArray addObject:self.signPlayUrl];
                self.tableView.BankVideoArray = self.BankVideoArray;
                [self.tableView reloadData];
            }
            
            
        } failure:^(NSError *error) {
            [TLAlert alertWithTitle:@"提示" msg:@"获取失败，是否重新获取" confirmMsg:@"确认" cancleMsg:@"取消" maker:self cancle:^(UIAlertAction *action) {
                
           
            } confirm:^(UIAlertAction *action) {
                [self loadEndMovieUrlOut];
            }];
        }];
    }else
    {
        [TLAlert alertWithTitle:@"提示" msg:@"获取失败，是否重新获取" confirmMsg:@"确认" cancleMsg:@"取消" maker:self cancle:^(UIAlertAction *action) {
            
        } confirm:^(UIAlertAction *action) {
            [self loadEndMovieUrlOut];
        }];
    }
}


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
