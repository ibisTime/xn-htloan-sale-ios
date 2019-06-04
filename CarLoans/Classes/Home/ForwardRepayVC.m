//
//  ForwardRepayVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ForwardRepayVC.h"
#import "ForwardRepayTableView.h"
@interface ForwardRepayVC ()
@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic,strong) ForwardRepayTableView * tableView;
@property (nonatomic,strong) NSMutableArray * picarray;
@end

@implementation ForwardRepayVC
- (TLImagePicker *)imagePicker {
    
    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];
        
        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
            
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
    if (self.selectInt == 100)
    {
        [self.picarray addObject:data];
        self.tableView.picarr = self.picarray;
        
    }
    
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提前还款";
    self.picarray = [NSMutableArray array];
    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[ForwardRepayTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"])
    {
        
        switch (index) {
                case 100:{
                    self.selectInt = index;
                    [self.imagePicker picker];
                }
            break;}
        
    }
    if ([state isEqualToString:@"Confirm"]) {
        NSLog(@"----%s---",__func__);
        UITextField * text = [self.view viewWithTag:100002];
        if (self.picarray.count == 0) {
            [TLAlert alertWithInfo:@"请上传纸质申请照片"];
            return;
        }
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630515";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"remark"] = text.text;
        http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"paperPhoto"] = [self.picarray componentsJoinedByString:@"||"];
        [http postWithSuccess:^(id responseObject) {
            NSNotification *notification =[NSNotification notificationWithName:ADDADPEOPLENOTICE object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            
        }];
        
    }
    if([state isEqualToString:@"DeletePhotos1"])
    {
        [_picarray removeObjectAtIndex:index - 1000];
        _tableView.picarr = _picarray;
        [self.tableView reloadData];
    }
}

@end
