//
//  MakeCardApplyVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/2.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MakeCardApplyVC.h"
#import "MakeCardApplyTableView.h"
#import "JHAddressPickView.h"
@interface MakeCardApplyVC ()<RefreshDelegate,BaseModelDelegate>

@property (nonatomic , strong)MakeCardApplyTableView *tableView;
@property (nonatomic ,strong) JHAddressPickView * pickView;
@property (nonatomic , copy)NSString *province;
@property (nonatomic , copy)NSString *city;
@property (nonatomic , copy)NSString *area;
@property (nonatomic , strong)UILabel *addressLabel;
@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic,strong) NSMutableArray * RedCardArray;

//@property (nonatomic,strong) NSString * cardPostProvince;
//@property (nonatomic,strong) NSString *  cardPostCity;
//@property (nonatomic,strong) NSString * cardPostArea;
@end

@implementation MakeCardApplyVC
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
    if (self.selectInt == 0) {
        self.specialQuatoPic = data;
        self.tableView.specialQuatoPic = self.specialQuatoPic;
        [self.tableView reloadData];
    }
    else{
        [self.RedCardArray addObject:data];
        self.tableView.RedCardArray = self.RedCardArray;
        [self.tableView reloadData];
    }
    
}
- (JHAddressPickView *)pickView{
    if (!_pickView) {
        _pickView = [[JHAddressPickView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 350 , SCREEN_WIDTH, 350)];
        _pickView.columns = 3;
        // 关闭默认支持打开上次的结果
        MJWeakSelf;
        _pickView.pickBlock = ^(NSDictionary *dic) {
            weakSelf.province = dic[@"province"];
            weakSelf.city = dic[@"city"];
            weakSelf.area = dic[@"town"];
            
            weakSelf.addressLabel = [weakSelf.view viewWithTag:10000];
            weakSelf.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.province,weakSelf.city,weakSelf.area];
//            weakSelf.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",weakSelf.province1,weakSelf.city1,weakSelf.area1];
        };
        //        _pickerView.isAutoOpenLast = NO;
    }
    return _pickView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.RedCardArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632516";
    http.parameters[@"code"] = self.model.code;
    [http postWithSuccess:^(id responseObject) {
        self.model = [SurveyModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self initTableView];
    } failure:^(NSError *error) {
        
    }];
//    [self initTableView];

}



- (void)initTableView {
    self.tableView = [[MakeCardApplyTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    [self.view addSubview:self.tableView];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
    [self.RightButton setTitle:@"查看详情" forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)rightButtonClick
{
    AdmissionDetailsVC *vc = [AdmissionDetailsVC new];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3) {
        [self.pickView showInView:self.view];
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"]) {
        self.selectInt = index;
        [self.imagePicker picker];
        return;
    }
    else if ([state isEqualToString:@"addspecialQuatoPic"]){
        self.selectInt = index;
        [self.imagePicker picker];
        return;
    }
    else if ([state isEqualToString:@"DeletePhotos1"]){
        [self.RedCardArray removeObjectAtIndex:index-1000];
        self.tableView.RedCardArray = self.RedCardArray;
        [self.tableView reloadData];
        return;
    }
    else if ([state isEqualToString:@"DeletespecialQuatoPic"]){
        self.specialQuatoPic = @"";
        self.tableView.specialQuatoPic = self.specialQuatoPic;
        [self.tableView reloadData];
        return;
    }
    else{
        UITextField *textField = [self.view viewWithTag:10001];
        UITextField *textField1 = [self.view viewWithTag:10002];
        
//        if (self.RedCardArray.count == 0) {
//            [TLAlert alertWithInfo:@"请上传红卡照片"];
//            return;
//        }
//        if (self.specialQuatoPic.length == 0) {
//            [TLAlert alertWithInfo:@"请上传专项额度核定申请表"];
//            return;
//        }
        if ([self.addressLabel.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请选择地址"];
            return;
        }
        if ([textField.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入卡详细地址"];
            return;
        }
        if ([textField1.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入卡邮寄地址邮编"];
            return;
        }
        
        
        
        TLNetworking *http = [TLNetworking new];
        
        http.isShowMsg = NO;
        http.showView = self.view;
        http.code = @"632510";
        http.parameters[@"code"] = self.model.code;
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"cardPostProvince"] = self.province;
        http.parameters[@"cardPostCity"] = self.city;
        http.parameters[@"cardPostArea"] = self.area;
        http.parameters[@"cardPostAddress"] = textField.text;
        http.parameters[@"cardPostCode"] = textField1.text;
        
//        http.parameters[@"cardPostAddress"] = [NSString stringWithFormat:@"%@ %@",self.addressLabel.text,textField.text];
        
        http.parameters[@"redCardPic"] = [self.RedCardArray componentsJoinedByString:@"||"];
        http.parameters[@"specialQuatoPic"] = self.specialQuatoPic;
        [http postWithSuccess:^(id responseObject) {
            
            [TLAlert alertWithSucces:@"申请成功"];
            
            
            NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            
        }];
    }
    
}


@end
