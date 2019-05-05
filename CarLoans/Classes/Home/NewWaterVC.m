//
//  NewWaterVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/5/2.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "NewWaterVC.h"
#import "NewWaterTableView.h"
@interface NewWaterVC ()<RefreshDelegate,BaseModelDelegate>
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , strong)NewWaterTableView *tableView;
@property (nonatomic , assign)NSInteger SelectTag;
@property (nonatomic , strong)NSMutableArray *picArray;
@property (nonatomic , assign)NSInteger selectInt;
@end

@implementation NewWaterVC

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
    [_picArray addObject:data];
    _tableView.picArray = _picArray;
    [_tableView reloadData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.picArray = [NSMutableArray array];
    self.title = @"流水";
}

-(void)initTableView
{
    self.tableView = [[NewWaterTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.model = self.model;
    self.tableView.waterDic = self.waterDic;
    [self.view addSubview:self.tableView];
    
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self TheAssignment];
        [SVProgressHUD dismiss];
    });
}

-(void)TheAssignment
{
    if ([BaseModel isBlankString:self.waterDic[@"code"]] == NO) {
        
        _tableView.picArray = [self.waterDic[@"pic"] componentsSeparatedByString:@"||"];
        self.picArray = [NSMutableArray arrayWithArray:[self.waterDic[@"pic"] componentsSeparatedByString:@"||"]];
    }
    [self.tableView reloadData];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _SelectTag = indexPath.row + 10000;
    if (indexPath.row == 0) {
        NSMutableArray *  array = [NSMutableArray array];
        for (int i = 0;i < self.model.creditUserList.count ; i ++) {
            [array addObject:self.model.creditUserList[0][@"userName"]];
        }
        BaseModel *baseModel = [BaseModel user];
        baseModel.ModelDelegate = self;
        [baseModel CustomBouncedView:array setState:@"100"];
    }
    if (indexPath.row == 1) {
        BaseModel *baseModel = [BaseModel user];
        baseModel.ModelDelegate = self;
        [baseModel CustomBouncedView:[NSMutableArray arrayWithArray:@[@"微信",@"支付宝",@"银行"]] setState:@"100"];
    }
    if (indexPath.row == 2 || indexPath.row == 3) {
        //开始时间
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
            
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            UILabel *right1Label1 = [self.view viewWithTag:10000 + indexPath.row];
            right1Label1.text = date;
            
        }];
        datepicker.dateLabelColor = kAppCustomMainColor;//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = kAppCustomMainColor;//确定按钮的颜色
        [datepicker show];
    }
    
    if (indexPath.row == 4 || indexPath.row == 5) {
        BaseModel *baseModel = [BaseModel user];
        baseModel.ModelDelegate = self;
        [baseModel ReturnsParentKeyAnArray:@"interest"];
    }
 
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"confirm"])
    {
        
        UITextField *textField1 = [self.view viewWithTag:10001];
        UITextField *textField2 = [self.view viewWithTag:10002];
        UITextField *textField3 = [self.view viewWithTag:10003];
        UITextField *textField4 = [self.view viewWithTag:10004];
        UITextField *textField5 = [self.view viewWithTag:10005];
        UITextField *textField6 = [self.view viewWithTag:10006];
        UITextField *textField7 = [self.view viewWithTag:10007];
        UITextField *textField8 = [self.view viewWithTag:10008];
        UITextField *textField9 = [self.view viewWithTag:10009];
        UITextField *textField10 = [self.view viewWithTag:10010];
        UITextField *textField11 = [self.view viewWithTag:10011];
        UITextField *textField12 = [self.view viewWithTag:10012];
        UITextField *textField13 = [self.view viewWithTag:10013];
        
        
        
        for (int i = 0; i < [TopModel user].ary4.count; i ++) {
            NSString *name = [self WarningContent:[TopModel user].newWaterAry[i] CurrentTag:10000 + i];
            if (![name isEqualToString:@""]) {
                [TLAlert alertWithInfo:name];
                return;
            }
        }
        
        TLNetworking *http = [TLNetworking new];
        http.isShowMsg = YES;
        http.showView = self.view;
        
        if ([BaseModel isBlankString:self.waterDic[@"code"]] == YES) {
            http.code = @"632490";
            http.parameters[@"bizCode"] = self.model.code;
            http.parameters[@"creditUserCode"] = self.model.creditUserList[0][@"code"];
        }else
        {
            http.code = @"632492";
            http.parameters[@"code"] = self.waterDic[@"code"];
        }
       
        if ([textField1.text isEqualToString:@"微信"]) {
            http.parameters[@"type"] = @"1";
        }else if ([textField1.text isEqualToString:@"支付宝"])
        {
            http.parameters[@"type"] = @"2";
        }else
        {
            http.parameters[@"type"] = @"3";
        }

        http.parameters[@"datetimeStart"] = textField2.text;
        http.parameters[@"datetimeEnd"] = textField3.text;
        http.parameters[@"jourInterest1"] = [[BaseModel user] setParentKey:@"interest" setDvalue:textField4.text];
        http.parameters[@"jourInterest2"] = [[BaseModel user] setParentKey:@"interest" setDvalue:textField5.text];
        http.parameters[@"interest1"] = @([textField6.text floatValue]*1000);
        http.parameters[@"interest2"] = @([textField7.text floatValue]*1000);
        http.parameters[@"income"] = @([textField8.text floatValue]*1000);
        http.parameters[@"expend"] = @([textField9.text floatValue]*1000);
        http.parameters[@"monthIncome"] = @([textField10.text floatValue]*1000);
        http.parameters[@"monthExpend"] = @([textField11.text floatValue]*1000);
        http.parameters[@"balance"] = @([textField12.text floatValue]*1000);
        http.parameters[@"remark"] = textField13.text;
        http.parameters[@"pic"] = [_picArray componentsJoinedByString:@"||"];
        [http postWithSuccess:^(id responseObject) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSError *error) {
            
        }];
    }
    else if ([state isEqualToString:@"add"])
    {
        self.selectInt = index;
        [self.imagePicker picker];
    }
    else
    {
        [_picArray removeObjectAtIndex:index - 10000];
        _tableView.picArray = _picArray;
        [self.tableView reloadData];
    }
}


-(NSString *)WarningContent:(NSString *)name CurrentTag:(NSInteger)tag
{
    UILabel *label = [self.view viewWithTag:tag];
    NSString *str = [name stringByReplacingOccurrencesOfString:@"*" withString:@""];
    if([label.text isEqualToString:@""]) {
        return [NSString stringWithFormat:@"请输入%@",str];
    }else if ([label.text isEqualToString:@"请选择"]) {
        return [NSString stringWithFormat:@"请选择%@",str];
    }else{
        return @"";
    }
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    UILabel *label = [self.view viewWithTag:_SelectTag];
    label.text = Str;
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
