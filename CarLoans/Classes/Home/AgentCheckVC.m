//
//  AgentCheckVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "AgentCheckVC.h"
#import "AgentTableView.h"
@interface AgentCheckVC ()<RefreshDelegate,SelectButtonDelegate>
@property (nonatomic,strong) AgentTableView * tableView;
@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic,strong) AccessSingleModel * singmodel;
@end

@implementation AgentCheckVC
#pragma mark - 选择图片
- (TLImagePicker *)imagePicker {
    
    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];
        
        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
            
            //进行上传
            TLUploadManager *manager = [TLUploadManager manager];
            
            manager.imgData = imgData;
            manager.image = image;
            [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
                WGLog(@"%@",key);
                [weakSelf setImage:image setData:key];
                
            } failure:^(NSError *error) {
                
            }];
        };
    }
    
    return _imagePicker;
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    if (self.selectInt == 50)
    {
        self.idNoFront = data;
        self.tableView.idNoFront = self.idNoFront;
    }else if (self.selectInt == 51)
    {
        self.idNoReverse = data;
        self.tableView.idNoReverse = self.idNoReverse;
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内勤确认";
    [self inittableview];
}
-(void)inittableview{
    self.tableView = [[AgentTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
//    self.tableView.model = self.model;
    [self loaddetails];
    self.tableView.AgentDelegate = self;
//    [self.view addSubview:self.tableView];
}
-(void)loaddetails{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        NSLog(@"%@",[AccessSingleModel mj_objectWithKeyValues:responseObject[@"data"]]);
        self.model = [AccessSingleModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.tableView.model = self.model;
        for (int i = 0; i < self.model.attachments.count; i ++) {
            if ([self.model.attachments[i][@"kname"] isEqualToString:@"pledge_user_id_card_front"]) {
                self.idNoFront = self.model.attachments[i][@"url"];
                self.tableView.idNoFront = self.model.attachments[i][@"url"];
            }
            if ([self.model.attachments[i][@"kname"] isEqualToString:@"pledge_user_id_card_reverse"]) {
                self.idNoReverse = self.model.attachments[i][@"url"];
                self.tableView.idNoReverse = self.model.attachments[i][@"url"];
            }
        }
        [self.view addSubview:self.tableView];
//        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)selectButtonClick:(UIButton *)sender{
    if (sender.tag == 5000) {
        
        
        _idNoFront = @"";
        self.tableView.idNoFront = _idNoFront;
    }else
    {
        _idNoReverse = @"";
        self.tableView.idNoReverse = _idNoReverse;
    }
    [self.tableView reloadData];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
    if ([state isEqualToString:@"IDCard"])
    {
        self.selectInt = index;
        [self.imagePicker picker];
        [self.tableView reloadData];
    }
    if ([state isEqualToString:@"confirm"]) {
        [self confirm];
    }
   
}
-(void)confirm{
    UITextField * text1 = [self.view viewWithTag:10000];
    UITextField * text2 = [self.view viewWithTag:10001];
    if (text1.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入代理人姓名"];
        return;
    }
    if (text2.text.length == 0) {
        [TLAlert alertWithInfo:@"请输入代理人身份证号码"];
        return;
    }
    if (self.idNoFront.length == 0) {
        [TLAlert alertWithInfo:@"请选择代理人身份证正面"];
        return;
    }
    if (self.idNoReverse.length == 0) {
        [TLAlert alertWithInfo:@"请选择代理人身份证反面"];
        return;
    }
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632124";
    http.parameters[@"code"] = self.model.code;
    http.parameters[@"pledgeUser"] = text1.text;
    http.parameters[@"pledgeUserIdCard"] = text2.text;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"pledgeUserIdCardFront"] = self.idNoFront;
    http.parameters[@"pledgeUserIdCardReverse"] = self.idNoReverse;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithInfo:@"确认成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
}
@end
