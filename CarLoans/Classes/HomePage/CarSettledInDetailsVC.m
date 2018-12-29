//
//  CarSettledInDetailsVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CarSettledInDetailsVC.h"
#import "CarSettledInDetailsTableView.h"
#import "WSDatePickerView.h"
@interface CarSettledInDetailsVC ()
<RefreshDelegate>
{
    NSInteger isSelect;
    NSString *date;
    NSString *date1;
    NSString *date2;
    NSString *date3;

}

//发票
//@property (nonatomic , strong)NSMutableArray *invoiceArray;
////合格证
//@property (nonatomic , strong)NSMutableArray *CertificateArray;
////交强险
//@property (nonatomic , strong)NSMutableArray *insuranceArray;
////商业险
//@property (nonatomic , strong)NSMutableArray *BusinessRisksArray;
////其他
//@property (nonatomic , strong)NSMutableArray *otherArray;

//发票
@property (nonatomic , strong)NSMutableArray *invoiceDataArray;

//交强险
@property (nonatomic , strong)NSMutableArray *insuranceDataArray;
//商业险
@property (nonatomic , strong)NSMutableArray *BusinessRisksDataArray;
//其他
@property (nonatomic , strong)NSMutableArray *otherDataArray;
//绿大本
@property (nonatomic , strong)NSMutableArray *greenDataArray;


@property (nonatomic , assign)NSInteger selectInt;

@property (nonatomic , strong)TLImagePicker *imagePicker;

@property (nonatomic , strong)CarSettledInDetailsTableView *tableView;

@end

@implementation CarSettledInDetailsVC

- (TLImagePicker *)imagePicker {

    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];

        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){

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
        };
    }

    return _imagePicker;
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{

    switch (_selectInt) {
        case 1:
        {

//            [self.invoiceArray addObject:image];
            [self.invoiceDataArray addObject:data];
            self.tableView.invoiceArray = self.invoiceDataArray;
            [self.tableView reloadData];
        }
            break;

        case 2:
        {
//            [self.insuranceArray addObject:image];
            [self.insuranceDataArray addObject:data];
            self.tableView.insuranceArray = self.insuranceDataArray;
            [self.tableView reloadData];
        }
            break;
        case 3:
        {
//            [self.BusinessRisksArray addObject:image];
            [self.BusinessRisksDataArray addObject:data];
            self.tableView.BusinessRisksArray = self.BusinessRisksDataArray;
            [self.tableView reloadData];
        }
            break;
        case 4:
        {
//            [self.otherArray addObject:image];
            [self.otherDataArray addObject:data];
            self.tableView.otherArray = self.otherDataArray;
            [self.tableView reloadData];
        }
            break;
        case 5:
        {
            //            [self.otherArray addObject:image];
            [self.greenDataArray addObject:data];
            self.tableView.greenDataArray = self.greenDataArray;
            [self.tableView reloadData];
        }
            break;

        default:
            break;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"录入";
    date = @"";
    date1 = @"";
    date2 = @"";
    _invoiceDataArray = [NSMutableArray array];
    _insuranceDataArray  = [NSMutableArray array];
    _BusinessRisksDataArray  = [NSMutableArray array];
    _otherDataArray = [NSMutableArray array];
    _greenDataArray = [NSMutableArray array];

    [self initTableView];
}

- (void)initTableView {
    self.tableView = [[CarSettledInDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;

    [self.view addSubview:self.tableView];
}

//
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"])
    {
        self.selectInt = index;
        [self.imagePicker picker];
    }else if([state isEqualToString:@"DeletePhotos1"])
    {

        [_invoiceDataArray removeObjectAtIndex:index - 1000];
        _tableView.invoiceArray = _invoiceDataArray;

        [self.tableView reloadData];
    }
    else if([state isEqualToString:@"DeletePhotos2"])
    {

        [_insuranceDataArray removeObjectAtIndex:index - 1000];
        _tableView.insuranceArray = _insuranceDataArray;
//
        [self.tableView reloadData];

    }else if([state isEqualToString:@"DeletePhotos3"])
    {

        [_BusinessRisksDataArray removeObjectAtIndex:index - 1000];
        _tableView.BusinessRisksArray = _BusinessRisksDataArray;

        [self.tableView reloadData];

    }else if([state isEqualToString:@"DeletePhotos4"])
    {

        [_otherDataArray removeObjectAtIndex:index - 1000];
        _tableView.otherArray = _otherDataArray;

        [self.tableView reloadData];
    }else if([state isEqualToString:@"DeletePhotos5"])
    {
        
        [_greenDataArray removeObjectAtIndex:index - 1000];
        _tableView.greenDataArray = _greenDataArray;
        
        [self.tableView reloadData];
    }else if([state isEqualToString:@"confirm"])
    {
        [self confirmButtonClick];
    }
}

-(void)confirmButtonClick
{

    if ([date isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择保单日期"];
        return;
    }
    if ([date1 isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择保单到期日"];
        return;
    }
    if ([date2 isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择落户日期"];
        return;
    }
    if ([date3 isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择抵押日期"];
        return;
    }
    if (_invoiceDataArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传发票图片"];
        return;
    }

    if (_insuranceDataArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传交强险图片"];
        return;
    }
    if (_BusinessRisksDataArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传商业险图片"];
        return;
    }
    if (_otherDataArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传其他资料图片"];
        return;
    }
    if (_greenDataArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传绿大本扫描件图片"];
        return;
    }
//
    NSString *invoiceData = [_invoiceDataArray componentsJoinedByString:@"||"];
    NSString *insuranceData = [_insuranceDataArray componentsJoinedByString:@"||"];
    NSString *BusinessRisksData = [_BusinessRisksDataArray componentsJoinedByString:@"||"];
    NSString *otherData = [_otherDataArray componentsJoinedByString:@"||"];
    NSString *carBigSmj = [_greenDataArray componentsJoinedByString:@"||"];


    TLNetworking *http = [TLNetworking new];
    http.code = @"632131";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"policyDatetime"] = date;
    http.parameters[@"policyDueDate"] = date1;
    http.parameters[@"carSettleDatetime"] = date2;
    http.parameters[@"carInvoice"] = invoiceData;
    http.parameters[@"carHgz"] = @"";
    http.parameters[@"carJqx"] = insuranceData;
    http.parameters[@"carSyx"] = BusinessRisksData;
    http.parameters[@"carBigSmj"] = carBigSmj;
    http.parameters[@"carSettleOtherPdf"] = otherData;
    http.parameters[@"pledgeDatetime"] = date3;

    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"录入成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
//    NSNotification *notification =[NSNotification notificationWithName:ADDADPEOPLENOTICE object:nil userInfo:dic];
//    [[NSNotificationCenter defaultCenter] postNotification:notification];
//    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
            if (indexPath.row == 0) {
                date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                self.tableView.date = date;

            }else if (indexPath.row == 1)
            {
                date1 = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                self.tableView.date1 = date1;

            }else if (indexPath.row == 2)
            {
                date2 = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                self.tableView.date2 = date2;
                
            }else
            {
                date3 = [selectDate stringWithFormat:@"yyyy-MM-dd"];
                self.tableView.date3 = date3;

            }
            [self.tableView reloadData];

        }];
        datepicker.dateLabelColor = MainColor;//年-月-日-时-分 颜色
        datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
        datepicker.doneButtonColor = MainColor;//确定按钮的颜色
        [datepicker show];
    }
}

@end
