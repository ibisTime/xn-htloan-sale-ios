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
@interface ADPeopleVC ()<RefreshDelegate,AccessCameraPhotoAlbumDelegate,BaseModelDelegate,SelectButtonDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    NSInteger isSelect;
    NSArray *_phostsArr;
}

@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic,strong) IdCardFrontModel * idcardfrontmodel;
@property (nonatomic,strong) IdCradReverseModel * idcradreversemodel;
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

@property (nonatomic , assign)NSInteger count;

@end

@implementation ADPeopleVC

- (TLImagePicker *)imagePicker {

    if (!_imagePicker) {
        CarLoansWeakSelf;
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];

        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData =UIImageJPEGRepresentation(image, 1.0);
            
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
    NSData *imgData =UIImageJPEGRepresentation(image, 1.0);
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
    NSData *imgData =UIImageJPEGRepresentation(image, 1.0);
    
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
    }];
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    if (self.selectInt == 104)
    {
//        征信授权书
        [self.authPdfArray addObject:data];
        self.tableView.certificateArray = self.authPdfArray;
        [SVProgressHUD dismiss];

    }
    else if (self.selectInt == 105)
    {
//        面签照片
        [self.interviewPicArray addObject:data];
        self.tableView.faceToFaceArray = self.interviewPicArray;
        [SVProgressHUD dismiss];
    }
    else if (self.selectInt == 50)
    {

        self.idNoFront = data;
        [self getDataFromPicWithUrl:data WithCode:@"630092"];
    }else if (self.selectInt == 51)
    {
        self.idNoReverse = data;
        [self getDataFromPicWithUrl:data WithCode:@"630093"];
    }
    [self.tableView reloadData];
}
-(void)getDataFromPicWithUrl:(NSString *)picurl WithCode :(NSString *)code{
    NSString * url = [picurl convertImageUrl];
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = code;
    http.parameters[@"picUrl"] = url;
    [http postWithSuccess:^(id responseObject) {
        if ([code isEqualToString:@"630092"]) {
            self.idcardfrontmodel = [IdCardFrontModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.tableView.idNoFront = picurl;
            self.tableView.idcardfrontmodel = self.idcardfrontmodel;
        }
        else if ([code isEqualToString:@"630093"]) {
            self.idcradreversemodel = [IdCradReverseModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.tableView.idNoReverse = picurl;
            self.tableView.idcardreversemodel = self.idcradreversemodel;
        }
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        
    }];
    
}
//删除身份证图片
-(void)selectButtonClick:(UIButton *)sender
{
    if (sender.tag == 5000) {
        _idNoFront = @"";
        self.tableView.idNoFront = _idNoFront;
        self.idcardfrontmodel = nil;
        self.tableView.idcardfrontmodel = self.idcardfrontmodel;
        self.tableView.dataDic = nil;
    }else
    {
        _idNoReverse = @"";
        self.tableView.idNoReverse = _idNoReverse;
        self.idcradreversemodel = nil;
        self.tableView.idcardreversemodel = self.idcradreversemodel;
        self.tableView.dataDic1 = nil;
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

//    if (self.selectRow > 1000) {
        [self TheValueOf];
//    }

//    [self.view addSubview:self.imagePicker];
}

-(void)TheValueOf
{
    self.tableView.selectRow = _selectRow;
    self.tableView.dataDic = _dataDic;
    self.tableView.dataDic1 = _dataDic;

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
        [self addButClick];
//        if (index == 104) {
//            [self addButClick];
//        }else
//            [self.imagePicker picker];
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
    UITextField *textField2 = [self.view viewWithTag:21000];
    UITextField *textField3 = [self.view viewWithTag:21001];
    UITextField *textField4 = [self.view viewWithTag:21002];
    UITextField *textField5 = [self.view viewWithTag:21003];
    UITextField *textField6 = [self.view viewWithTag:21004];
    UITextField *textField7 = [self.view viewWithTag:21005];
    UITextField *textField8 = [self.view viewWithTag:21006];
    
    if ([textField1.text isEqualToString:@""]) {
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
    if (textField3.text.length != 18) {
        [TLAlert alertWithInfo:@"身份证号格式不正确，请重新输入"];
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
    NSDictionary * idCardInfo;
    if (_idcardfrontmodel && _idcradreversemodel) {
        idCardInfo = @{@"userName":textField2.text,
                                      @"nation":textField5.text,
                                      @"gender":textField6.text ,
                                      @"customerBirth":textField4.text ,
                                      @"idNo":textField3.text,
                                      @"birthAddress":textField7.text,
                                      @"authref":textField8.text,
                                      @"statdate":_idcradreversemodel.statdate
                                      };
    }else{
        idCardInfo = @{@"userName":textField2.text,
                       @"nation":textField5.text,
                       @"gender":textField6.text ,
                       @"customerBirth":textField4.text ,
                       @"idNo":textField3.text,
                       @"birthAddress":textField7.text,
                       @"authref":textField8.text,
                       @"statdate":_dataDic[@"idCardInfo"][@"statdate"]
                       };
    }
    
    NSString *authPdf = [_authPdfArray componentsJoinedByString:@"||"];
    NSString *interviewPic = [_interviewPicArray componentsJoinedByString:@"||"];
    NSDictionary *dataDic  = @{
                                      @"userName":[BaseModel convertNull:textField2.text],
                                      @"mobile":[BaseModel convertNull:textField1.text],
                                      @"loanRole":_loanRole,
                                      @"relation":_relation,
                                      @"idNo":[BaseModel convertNull:textField3.text],
                                      @"idFront":_idNoFront,
                                      @"idReverse":_idNoReverse,
                                      @"authPdf":authPdf,
                                      @"interviewPic":interviewPic,
                                      @"idCardInfo":idCardInfo
                                      };

    NSNotification *notification =[NSNotification notificationWithName:ADDADPEOPLENOTICE object:nil userInfo:dataDic];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        isSelect = indexPath.row;
        BaseModel *model = [BaseModel new];
        model.ModelDelegate = self;
        if (indexPath.row == 1) {
            [model ReturnsParentKeyAnArray:@"credit_user_loan_role"];
        }else if(indexPath.row == 2)
        {
            [model ReturnsParentKeyAnArray:@"credit_user_relation"];
        }
    }
}

//弹框响应代理方法
-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    NSLog(@"%@",dic);
    if (isSelect == 1) {
        _loanRole = dic[@"dkey"];
        self.tableView.loanRole = _loanRole;
    }else if(isSelect == 2)
    {
        _relation = dic[@"dkey"];
        self.tableView.relation = _relation;
    }
    [self.tableView reloadData];
}


@end
