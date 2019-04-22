//
//  ReferenceInputDetailsVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/19.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ReferenceInputDetailsVC.h"
#import "ReferenceInputDetailsTableView.h"
@interface ReferenceInputDetailsVC ()<RefreshDelegate,BaseModelDelegate>
@property (nonatomic , strong)ReferenceInputDetailsTableView *tableView;
//@property (nonatomic , strong)SurveyDetailsModel *surveyDetailsModel;
@property (nonatomic , strong)NSMutableArray *bankCreditReport;
@property (nonatomic , strong)NSMutableArray *dataCreditReport;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , assign)NSInteger selectInt;

@property (nonatomic , copy)NSString *bankResult;

@end

@implementation ReferenceInputDetailsVC


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
    if (self.selectInt == 100)
    {
        //        征信授权书
        [self.bankCreditReport addObject:data];
        self.tableView.bankCreditReport = self.bankCreditReport;
        
        
    }
    else if (self.selectInt == 101)
    {
        //        面签照片
        [self.dataCreditReport addObject:data];
        self.tableView.dataCreditReport = self.dataCreditReport;
        
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"录入征信结果";
    [self initTableView];
    //    [self loadData];
    _bankCreditReport = [NSMutableArray array];
    _dataCreditReport = [NSMutableArray array];

    if ([BaseModel isBlankDictionary:self.creditListDic] == NO) {
        if ([self.creditListDic[@"bankResult"] isEqualToString:@"1"])
        {
            _bankResult = @"通过";
        }
        else
        {
            _bankResult = @"不通过";
        }
        self.tableView.bankResult = _bankResult;
        self.tableView.creditNote = self.creditListDic[@"creditNote"];
        self.bankCreditReport = [NSMutableArray arrayWithArray:[self.creditListDic[@"bankCreditReport"] componentsSeparatedByString:@"||"]];
        self.tableView.bankCreditReport = self.bankCreditReport;
        self.dataCreditReport = [NSMutableArray arrayWithArray:[self.creditListDic[@"dataCreditReport"] componentsSeparatedByString:@"||"]];
        self.tableView.dataCreditReport = self.dataCreditReport;
        [self.tableView reloadData];
    }
}

- (void)initTableView {
    self.tableView = [[ReferenceInputDetailsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.dataDic = self.dataDic;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        BaseModel *model = [BaseModel new];
        model.ModelDelegate = self;
        NSMutableArray *array = [NSMutableArray array];
        [array addObjectsFromArray:@[@"通过",@"不通过"]];
        [model CustomBouncedView:array setState:@"100"];
    }
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    _bankResult = Str;
    self.tableView.bankResult = _bankResult;
    [self.tableView reloadData];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"])
    {
        if (index == 100) {
            if (_bankCreditReport.count > 0) {
                return;
            }
        }
        self.selectInt = index;
        [self.imagePicker picker];
    }
    else if([state isEqualToString:@"DeletePhotos1"])
    {
        [_bankCreditReport removeObjectAtIndex:index - 1000];
        _tableView.bankCreditReport = _bankCreditReport;
        
    }
    else if([state isEqualToString:@"DeletePhotos2"])
    {
        [_dataCreditReport removeObjectAtIndex:index - 1000];
        _tableView.dataCreditReport = _dataCreditReport;
    }else if ([state isEqualToString:@"confirm"])
    {
        
        if ([_bankResult isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请选择征信结果"];
            return;
        }
        
        if (self.bankCreditReport.count == 0) {
            [TLAlert alertWithInfo:@"请上传银行征信报告"];
            return;
        }
        if (self.dataCreditReport.count == 0) {
            [TLAlert alertWithInfo:@"请上传大数据征信报告"];
            return;
        }
        UITextField *textField = [self.view viewWithTag:3000];
        if ([textField.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入说明"];
            return;
        }
        
        NSString *bankResult;
        if ([_bankResult isEqualToString:@"通过"]) {
            bankResult = @"1";
        }else
        {
            bankResult = @"0";
        }
        
        NSDictionary *dic = @{@"bankCreditReport":[_bankCreditReport componentsJoinedByString:@"||"],
                              @"creditNote":textField.text,
                              @"bankResult":bankResult,
                              @"creditUserCode":_dataDic[@"code"],
                              @"dataCreditReport":[_dataCreditReport componentsJoinedByString:@"||"]
                              };
        
        _creditListBlock(dic, _row);
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    [self.tableView reloadData];
}



@end
