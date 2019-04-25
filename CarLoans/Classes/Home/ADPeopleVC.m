//
//  ADPeopleVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ADPeopleVC.h"
#import "ADPeopleTableView.h"
//#import "UploadImagesCell.h"
@interface ADPeopleVC ()<RefreshDelegate,AccessCameraPhotoAlbumDelegate,BaseModelDelegate,SelectButtonDelegate>
{
    NSInteger isSelect;
}

@property (nonatomic , assign)NSInteger selectInt;

//@property (nonatomic , strong)NSMutableArray *array1;
//@property (nonatomic , strong)NSMutableArray *array2;

@property (nonatomic , strong)ADPeopleTableView *tableView;

@property (nonatomic , strong)TLImagePicker *imagePicker;
//    征信查询授权书
@property (nonatomic , strong)NSMutableArray *authPdfArray;
//    身份证正面
@property (nonatomic , copy)NSString *idNoFront;
//    身份证反面
@property (nonatomic , copy)NSString *idNoReverse;
//    面签照片
@property (nonatomic , strong)NSMutableArray *interviewPicArray;
//    贷款角色
@property (nonatomic , copy)NSString *loanRole;
//    与借款人关系
@property (nonatomic , copy)NSString *relation;

@end

@implementation ADPeopleVC

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
    if (self.selectInt == 104)
    {
//        征信授权书
        [self.authPdfArray addObject:data];
        self.tableView.certificateArray = self.authPdfArray;


    }
    else if (self.selectInt == 105)
    {
//        面签照片
        [self.interviewPicArray addObject:data];
        self.tableView.faceToFaceArray = self.interviewPicArray;

    }
    else if (self.selectInt == 50)
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

//删除身份证图片
-(void)selectButtonClick:(UIButton *)sender
{
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"征信人";
    _authPdfArray = [NSMutableArray array];
    _interviewPicArray = [NSMutableArray array];
    _idNoFront = @"";
    _idNoReverse = @"";
    _loanRole = @"";
    _relation = @"";
    [self initTableView];

    if (self.selectRow > 1000) {
        [self TheValueOf];
    }

//    [self.view addSubview:self.imagePicker];
}

-(void)TheValueOf
{
    self.tableView.selectRow = _selectRow;
    self.tableView.dataDic = _dataDic;

    _loanRole = _dataDic[@"loanRole"];
    _relation = _dataDic[@"relation"];
    self.tableView.loanRole = _dataDic[@"loanRole"];
    self.tableView.relation = _dataDic[@"relation"];
    WGLog(@"%@",_dataDic);
    NSArray *authPdf = [_dataDic[@"authPdf"] componentsSeparatedByString:@"||"];
    NSArray *interviewPic = [_dataDic[@"interviewPic"] componentsSeparatedByString:@"||"];
    self.tableView.certificateArray = authPdf;
    self.tableView.faceToFaceArray = interviewPic;

    for (int i = 0; i < authPdf.count ; i ++) {
        [self.authPdfArray addObject:authPdf[i]];
    }
    for (int j = 0; j < interviewPic.count ; j ++) {
        [self.interviewPicArray addObject:interviewPic[j]];
    }
    self.idNoFront = _dataDic[@"idFront"];
    self.tableView.idNoFront = self.idNoFront;
    self.idNoReverse = _dataDic[@"idReverse"];
    self.tableView.idNoReverse = self.idNoReverse;

    [self.tableView reloadData];
}

- (void)initTableView {
    self.tableView = [[ADPeopleTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.ButtonDelegate = self;
    if (self.isFirstEntry == YES) {
        _loanRole = @"1";
        _tableView.loanRole = @"1";
        _relation = @"1";
        self.tableView.relation = @"1";
    }
    [self.view addSubview:self.tableView];
}

//
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"add"])
    {
        self.selectInt = index;
        [self.imagePicker picker];
    }
    else if([state isEqualToString:@"DeletePhotos1"])
    {
//        [_array1 removeObjectAtIndex:index - 1000];
        [_authPdfArray removeObjectAtIndex:index - 1000];
        _tableView.certificateArray = _authPdfArray;

    }
    else if([state isEqualToString:@"DeletePhotos2"])
    {
        [_interviewPicArray removeObjectAtIndex:index - 1000];
        _tableView.faceToFaceArray = _interviewPicArray;
    }
    else if([state isEqualToString:@"confirm"])
    {
        [self confirmButtonClick];
    }
    else if ([state isEqualToString:@"IDCard"])
    {
        self.selectInt = index;
        [self.imagePicker picker];
    }
    [self.tableView reloadData];
}

-(void)confirmButtonClick
{
    UITextField *textField1 = [self.view viewWithTag:20000];
    UITextField *textField2 = [self.view viewWithTag:20001];
    UITextField *textField3 = [self.view viewWithTag:20002];
    if ([textField1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入姓名"];
        return;
    }
    if ([textField2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机号"];
        return;
    }
    if ([_loanRole isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"选择贷款角色"];
        return;
    }
    if ([_relation isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择与借款人关系"];
        return;
    }
    if ([textField3.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入身份证号"];
        return;
    }
    if ([_idNoFront isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请上传身份证正面图片"];
        return;
    }
    if ([_idNoReverse isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请上传身份证反面图片"];
        return;
    }
    if (_authPdfArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传征信查询授权书"];
        return;
    }
    if (_interviewPicArray.count == 0) {
        [TLAlert alertWithInfo:@"请上传面签照片"];
        return;
    }

    NSString *authPdf = [_authPdfArray componentsJoinedByString:@"||"];
    NSString *interviewPic = [_interviewPicArray componentsJoinedByString:@"||"];
    NSDictionary *dataDic = @{
        @"userName":[BaseModel convertNull:textField1.text],
        @"mobile":[BaseModel convertNull:textField2.text],
        @"loanRole":_loanRole,
        @"relation":_relation,
        @"idNo":[BaseModel convertNull:textField3.text],
        @"idNoFront":_idNoFront,
        @"idNoReverse":_idNoReverse,
        @"authPdf":authPdf,
        @"interviewPic":interviewPic
        };

    NSNotification *notification =[NSNotification notificationWithName:ADDADPEOPLENOTICE object:nil userInfo:dataDic];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        isSelect = indexPath.row;
        BaseModel *model = [BaseModel new];
        model.ModelDelegate = self;
        if (indexPath.row == 0) {
            if (self.isFirstEntry == YES) {
                return;
            }
            [model ReturnsParentKeyAnArray:@"credit_user_loan_role"];
        }else
        {
            if (self.isFirstEntry == YES) {
                return;
            }
            [model ReturnsParentKeyAnArray:@"credit_user_relation"];
        }
    }
}

//弹框响应代理方法
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    NSLog(@"%@",dic);
    if (isSelect == 0) {
        _loanRole = dic[@"dkey"];
        self.tableView.loanRole = _loanRole;
    }else
    {
        _relation = dic[@"dkey"];
        self.tableView.relation = _relation;
    }
    [self.tableView reloadData];
}


@end
