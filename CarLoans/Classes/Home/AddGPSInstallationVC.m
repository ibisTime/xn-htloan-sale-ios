//
//  AddGPSInstallationVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AddGPSInstallationVC.h"
#import "AddGPSInstallationTableView.h"
#import "WSDatePickerView.h"
@interface AddGPSInstallationVC ()<RefreshDelegate,BaseModelDelegate>
{
    NSString *date;
    NSString *code;
    NSString *gpsDevNo;
}
@property (nonatomic , strong)AddGPSInstallationTableView *tableView;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic , strong)NSArray *dataArray;
@property (nonatomic , copy)NSString * str1;
@property (nonatomic , copy)NSString * str2;
@property (nonatomic , strong)NSMutableArray *bankPicArray;

@property (nonatomic , strong)NSMutableArray *CompanyPicArray;

@end

@implementation AddGPSInstallationVC
- (TLImagePicker *)imagePicker {
    
    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];
        
        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            NSLog(@"%@",info);
          
                
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
                    
                }];
           
        };
    }
    return _imagePicker;
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
            self.tableView.Str1 = data;
        }
            break;
        case 4:
        {
            self.tableView.Str2 = data;
        }
            break;
        case 6:
        {
            [self.bankPicArray addObject:data];
            self.tableView.otherPicArray = self.bankPicArray;
//            self.tableView.Str1 = data;
//            self.str1 = data;
        }
            break;
        case 7:
        {
            [self.CompanyPicArray addObject:data];
            self.tableView.azPicArray = self.CompanyPicArray;

        }
            break;
        case 8:
        {
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
    self.title = @"添加GPS";
    date = @"";
    code = @"";
    [self initTableView];
    self.bankPicArray = [NSMutableArray array];
    self.CompanyPicArray = [NSMutableArray array];

    NSLog(@"%@",_dataDic);
    if (self.isSelect >= 100) {
        date = _dataDic[@"dic"][@"azDatetime"];
        code = _dataDic[@"dic"][@"code"];
        gpsDevNo = _dataDic[@"gpsDevNo"];
        self.tableView.GPS = _dataDic[@"gpsDevNo"];
        self.tableView.date = _dataDic[@"dic"][@"azDatetime"];
        self.tableView.isSelect = self.isSelect;
        self.tableView.Str1 = _dataDic[@"dic"][@"azLocation"];
        self.tableView.Str2 = _dataDic[@"dic"][@"azUser"];
        self.tableView.Str3 = _dataDic[@"dic"][@"remark"];
        self.tableView.azPicArray = [_dataDic[@"azPhotos"] componentsSeparatedByString:@"||"];
        self.CompanyPicArray = [NSMutableArray arrayWithArray:  [_dataDic[@"azPhotos"] componentsSeparatedByString:@"||"]];
        self.bankPicArray = [NSMutableArray arrayWithArray: [_dataDic[@"devPhotos"] componentsSeparatedByString:@"||"]];
        self.tableView.otherPicArray = [_dataDic[@"devPhotos"] componentsSeparatedByString:@"||"];
        self.tableView.gpsType = _dataDic[@"gpsType"];
        
        [self.tableView reloadData];
//        UITextField * text = [self.view viewWithTag:1080];
//        text.text = _dataDic[@"gpsType"];
    }
}

- (void)initTableView {
    self.tableView = [[AddGPSInstallationTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    self.selectInt = index;
    if ([state isEqualToString:@"add"]) {
       
            [self.imagePicker picker];
      
    }else
    {
        if (index == 6) {
            NSLog(@"%ld",sender.tag);
            [self.bankPicArray removeObjectAtIndex:sender.tag-1000];
            [self.tableView reloadData];
        }else if(index == 7){
            NSLog(@"%ld",sender.tag);
            [self.CompanyPicArray removeObjectAtIndex:sender.tag-1000];
            [self.tableView reloadData];


        }
        
    }
 
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textField1 = [self.view viewWithTag:100];
    UITextField *textField2 = [self.view viewWithTag:101];
    UITextField *textField3 = [self.view viewWithTag:102];
   


    if ([code isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择GPS设备"];
        return;
    }
    if ([textField1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入安装位置"];
        return;
    }
    if ([date isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择安装时间"];
        return;
    }
    if ([textField2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入安装人员"];
        return;
    }
    
    NSString *devPhotos = [self.bankPicArray componentsJoinedByString:@"||"];
    NSString *azPhotos = [self.CompanyPicArray componentsJoinedByString:@"||"];
    if (devPhotos.length == 0) {
        [TLAlert alertWithInfo:@"请选择设备图片"];
        return;
    }
    if (azPhotos.length == 0) {
        [TLAlert alertWithInfo:@"请选择安装图片"];
        return;
    }
    NSDictionary *data = @{@"code":code,
                           @"azLocation":textField1.text,
                           @"azDatetime":date,
                           @"azUser":textField2.text,
                           @"devPhotos":devPhotos,
                           @"azPhotos":azPhotos,
                           @"remark":textField3.text};
    UITextField * text = [self.view viewWithTag:1080];
    NSDictionary *dic = @{
                          @"dic":data,
                          @"gpsDevNo":gpsDevNo,
                          @"gpsType":text.text,
                          @"devPhotos":devPhotos,
                          @"azPhotos":azPhotos,
                        };
    NSNotification *notification =[NSNotification notificationWithName:ADDGPS object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLNetworking *http = [TLNetworking new];
        http.code = @"632707";
        http.showView = self.view;
        http.parameters[@"applyUser"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"applyStatus"] = @"1";
        http.parameters[@"useStatus"] = @"0";
        http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];

        [http postWithSuccess:^(id responseObject) {
            self.dataArray = responseObject[@"data"];
            if (self.dataArray.count == 0) {
                [TLAlert alertWithInfo:@"暂无设备"];
            }
            [self boundData];
        } failure:^(NSError *error) {
            WGLog(@"%@",error);
        }];
    }
    if (indexPath.section == 3) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
            date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            self.tableView.date = date;
            [self.tableView reloadData];

        }];
        datepicker.dateLabelColor = MainColor;//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = MainColor;//确定按钮的颜色
        [datepicker show];
    }
}

-(void)boundData
{
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in self.dataArray) {
        [array addObject:dic[@"gpsDevNo"]];
        BaseModel *model = [BaseModel new];
        model.ModelDelegate = self;
        [model CustomBouncedView:array setState:@"100"];
    }
}

//弹框代理方法
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    for (int i = 0; i < self.gpsArray.count; i ++) {
        if (self.isSelect >= 100) {
            if ([_dataDic[@"dic"][@"code"] isEqualToString:self.gpsArray[i][@"code"]]) {


            }else
            {
                if ([self.gpsArray[i][@"code"] isEqualToString:_dataArray[sid][@"code"]]) {
                    [TLAlert alertWithInfo:@"已添加过该GPS设备"];
                    return;
                }
            }
        }else
        {
            if ([self.gpsArray[i][@"code"] isEqualToString:_dataArray[sid][@"code"]]) {
                [TLAlert alertWithInfo:@"已添加过该GPS设备"];
                return;
            }
        }

    }
    code = _dataArray[sid][@"code"];
    gpsDevNo = _dataArray[sid][@"gpsDevNo"];
    self.tableView.GPS = _dataArray[sid][@"gpsDevNo"];
    UITextField * text = [self.view viewWithTag:1080];
    text.text = [_dataArray[sid][@"gpsType"] isEqualToString:@"1"]?@"有线":@"无线";
    [self.tableView reloadData];
}

@end
