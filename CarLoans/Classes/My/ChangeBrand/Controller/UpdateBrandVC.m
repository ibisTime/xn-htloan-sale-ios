//
//  UpdateBrandVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/6/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "UpdateBrandVC.h"
#import "UpdateBrandTableView.h"
@interface UpdateBrandVC()<RefreshDelegate>
@property (nonatomic,strong) UpdateBrandTableView * tableView;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic,strong) NSString * brandlogo;
@end

@implementation UpdateBrandVC
- (TLImagePicker *)imagePicker {
    
    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];
        
        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0);
            
            //进行上传
            TLUploadManager *manager = [TLUploadManager manager];
            
            manager.imgData = imgData;
            manager.image = image;
            manager.isdissmiss = YES;
            [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
                WGLog(@"%@",key);
                [weakSelf setImage:image setData:key];
                
            } failure:^(NSError *error) {
                [TLAlert alertWithInfo:@"上传失败"];
            }];
        };
    }
    
    return _imagePicker;
}
-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    [SVProgressHUD dismiss];
    self.brandlogo = data;
    NSMutableArray * array = [NSMutableArray array];
    [array addObject:data];
    self.tableView.brandlogo = array;
    [self.tableView reloadData];
}
-(UpdateBrandTableView *)tableView{
    if (!_tableView) {
        _tableView = [[UpdateBrandTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
        _tableView.refreshDelegate = self;
    }
    return _tableView;
}
-(void)viewDidLoad{
    self.title = @"上传图片";
    [self.view addSubview:self.tableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
    if ([state isEqualToString:@"add"]) {
        [self.imagePicker picker];
    }
    if ([state isEqualToString:@"confirm"]) {
        TLNetworking * http = [TLNetworking new];
        http.code = @"630482";
        http.parameters[@"brandLogo"] = self.brandlogo;
        http.parameters[@"brandName"] = self.model.brandName;
        http.parameters[@"code"] = self.model.code;
        [http postWithSuccess:^(id responseObject) {
            [TLAlert alertWithSucces:@"上传成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSError *error) {
            [TLAlert alertWithSucces:@"上传失败"];
        }];
    }
}

@end
