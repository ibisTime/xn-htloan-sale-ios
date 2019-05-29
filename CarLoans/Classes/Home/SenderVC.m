//
//  SenderVC.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SenderVC.h"
#import "SenderTableView.h"
#import "SelectedListView.h"
#import "WSDatePickerView.h"
#import "CadListModel.h"
#import "SelectedListModel.h"
#import "TLTextField.h"
@interface SenderVC ()<RefreshDelegate,BaseModelDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *select;
    NSString *dkey;
}
@property (nonatomic , strong)SenderTableView *tableView;

@property (nonatomic , strong)NSMutableArray <CadListModel *>*models;

@property (nonatomic , strong) UIView *mengView;
@property (nonatomic , strong) NSMutableArray *cadList;

@property (nonatomic , strong) UIImageView *rightImg;

@property (nonatomic , strong) UIImageView *bottomImg;

@property (nonatomic , strong) UILabel *secondLab;

@property (nonatomic , strong) UILabel *threeLab;

@property (nonatomic , strong) UIView *centerView;

@property (nonatomic , strong)UITableView *selectTableView;


@property (nonatomic , strong) NSMutableArray *fileIdList;


@property (nonatomic , assign) BOOL isDetail;

@end

@implementation SenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.t
    self.title = @"发件";
    self.cadList = [NSMutableArray array];
    self.fileIdList = [NSMutableArray array];
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632156";
    if (self.code.length > 0) {
        http.parameters[@"code"] = self.code;
    }else{
        http.parameters[@"code"] = self.model.code;
    }
    [http postWithSuccess:^(id responseObject) {
        self.model = [DataTransferModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self loadCadList];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}

- (void)loadCadList
{

    TLNetworking *http = [TLNetworking new];
    http.code = @"632217";
    http.parameters[@"category"] =@"node_file_list";
    http.showView = self.view;
    
    [http postWithSuccess:^(id responseObject) {
        self.models = [CadListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self initTableView];
    } failure:^(NSError *error) {
        
    }];
}

- (void)initTableView {
    self.tableView = [[SenderTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.cardStr = [NSMutableString string];

    self.tableView.backgroundColor = kBackgroundColor;
    self.tableView.model = self.model;
    if ([self.model.status isEqualToString:@"3"]) {
        self.tableView.distributionStr = [self.model.sendType isEqualToString:@"2"]?@"快递":@"线下";
        self.tableView.CourierCompanyStr =[BaseModel convertNull: self.model.logisticsCompany];
        self.tableView.tempdan = [BaseModel convertNull: self.model.logisticsCode];
        self.tableView.tempRemark = [BaseModel convertNull: self.model.sendNote];
        self.tableView.date = [self.model.sendDatetime convertDateWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSArray * dataarr = [self.model.filelist componentsSeparatedByString:@","];
//        BaseModel *model = [BaseModel new];
//        model.ModelDelegate = self;
        NSMutableArray *array = [NSMutableArray array];
        for (CadListModel *model in self.models) {
            for (int i = 0; i < dataarr.count; i ++) {
                if ([model.ID isEqualToString:dataarr[i]]) {
                    [self.cadList addObject:model.ID];
                    [self.fileIdList addObject:model.ID];
                    [array addObject:[NSString stringWithFormat:@"%@-%@份",model.vname,model.number]];
                }
            }
        }
        
        self.tableView.cardList = array;
    }
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([self.tableView.distributionStr isEqualToString:@"快递"]) {

        if (indexPath.section == 1) {
            self.tableView.cardList = [NSMutableArray array];
            NSString *data1 = self.tableView.distributionStr;
            NSString *data2 = self.tableView.CourierCompanyStr;
            NSString *data3 = self.tableView.kuaidField.text;
            NSString *data4 = self.tableView.remarkKuaiField.text;
            NSString *data5 = self.tableView.date;

            [self initTableView];
            
            self.tableView.distributionStr = data1;
            self.tableView.CourierCompanyStr = data2;
            self.tableView.tempdan = data3;
            self.tableView.tempRemark = data4;
            self.tableView.tempDate = data5;
            [self.tableView reloadData];
            BaseModel *model = [BaseModel new];
            model.ModelDelegate = self;
            NSMutableArray *array = [NSMutableArray array];
            for (CadListModel *model in self.models) {
                [array addObject:[NSString stringWithFormat:@"%@-%@份",model.vname,model.number]];
            }
            [model CustomBounced:array setState:@"100" isSign:NO];

            return;
        }
        if (indexPath.section == 2) {

            if (indexPath.row == 0) {

                select = @"0";
                BaseModel *model = [BaseModel new];
                model.ModelDelegate = self;
                [model ReturnsParentKeyAnArray:@"send_type"];

            }else
            {
                select = @"1";
                BaseModel *model = [BaseModel new];
                model.ModelDelegate = self;
                [model ReturnsParentKeyAnArray:@"kd_company"];
            }

        }
        if (indexPath.section == 4)
        {
            [self selectTime];
        }

    }
    else{
        
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                
                select = @"0";
                BaseModel *model = [BaseModel new];
                model.ModelDelegate = self;
                [model ReturnsParentKeyAnArray:@"send_type"];
                
            }else
            {
                [self selectTime];
            }
        }else{
            
            if (indexPath.section == 1) {
                self.tableView.cardList = [NSMutableArray array];
                [self initTableView];
                BaseModel *model = [BaseModel new];
                model.ModelDelegate = self;
                NSMutableArray *array = [NSMutableArray array];
                for (CadListModel *model in self.models) {
                    [array addObject:[NSString stringWithFormat:@"%@-%@份",model.vname,model.number]];
                }
//                [NSThread sleepForTimeInterval:1];
                [model CustomBounced:array setState:@"100" isSign:NO];
//                [model CustomBouncedView:array setState:@"100"];
                return;
                
                
                UIView *mengView = [UIView new];
                self.mengView = mengView;
                mengView.backgroundColor = [UIColor blackColor];
                mengView.frame = self.view.bounds;
                mengView.alpha = 0.85;
                [self.view addSubview:mengView];
                self.selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 50, SCREEN_WIDTH-100, self.models.count *40) style:(UITableViewStylePlain)];
                self.selectTableView.dataSource = self;
                self.selectTableView.delegate = self;

                self.selectTableView.contentInset = UIEdgeInsetsMake(0, 0, -kTabBarHeight, 0);
                self.selectTableView.backgroundColor = kBackgroundColor;
                [self.mengView addSubview:self.selectTableView];
                
                return;
                
                UIView *view = [[UIView alloc]init];
                self.centerView = view;
                view.frame = CGRectMake(50, 100, SCREEN_WIDTH-100, self.models.count *30);
                view.backgroundColor = kWhiteColor;
                view.layer.borderWidth = 1.0;
                view.layer.borderColor = kLineColor.CGColor;
//                [mengView addSubview:view];
                view.layer.cornerRadius = 5;
                view.clipsToBounds = YES;
                UILabel* firstLabl = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:16];
                firstLabl.frame = CGRectMake(50, 20, 100, 40);
                firstLabl.text = @"选择";
                [view addSubview:firstLabl];

                for (int i = 0; i < self.models.count; i++) {
                    UIImageView *rightImg = [[UIImageView alloc] init];
                    rightImg.tag = 1000+i;
                    //                rightImg.contentMode = UIViewContentModeScaleToFill;
                    rightImg.frame = CGRectMake(120, 0+i*30, 14, 12);
                    rightImg.image = kImage(@"打勾");
                    rightImg.hidden = YES;
                   
                    UILabel* secondLabl = [UILabel labelWithBackgroundColor:kWhiteColor textColor:kBlackColor font:16];
                    secondLabl.userInteractionEnabled = YES;
                    secondLabl.tag = 10000+i;
                   
                    UITapGestureRecognizer *t = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseCad:)];
                    [secondLabl addGestureRecognizer:t];
                    secondLabl.frame = CGRectMake(50, 80+i*30, 200, 30);
                    secondLabl.text =self.models[i].vname;
                    [secondLabl addSubview:rightImg];
                    
                    [view addSubview:secondLabl];
                }
            }
        }
        
    }
    
}


-(void)TheReturnValuearr:(NSArray *)arr
{
    self.fileIdList = [NSMutableArray array];
    NSMutableArray *arr1 = [NSMutableArray array];
    for (SelectedListModel *model in arr) {
//        for (CadListModel *m in self.models) {
//            if ([model.title isEqualToString:[NSString stringWithFormat:@"%@-%@份",m.name,m.number]]) {
                [self.fileIdList addObject:self.models[model.sid].ID];
                [arr1 addObject:[NSString stringWithFormat:@"%@",model.title]];
//
//            }
//        }
    }
    self.cadList = arr1;
    self.tableView.cardList = arr1;
    self.tableView.cardStr = [NSString stringWithFormat:@"%@",[self.cadList componentsJoinedByString:@","]];
    [self.tableView reloadData];
}
- (void)chooseCad: (UITapGestureRecognizer *)ge
{
    
    NSLog(@"second");
    UIImageView *image = [self.mengView viewWithTag:ge.view.tag-10000+1000];
    image.hidden = !image.hidden;
    NSInteger inde = ge.view.tag - 10000;
    [self.cadList addObject:self.models[inde]];
    self.tableView.cardStr = [NSString stringWithFormat:@"%@ %@",self.tableView.cardStr,self.models[inde].name];
    [self.tableView reloadData];

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
     point = [self.centerView.layer convertPoint:point fromLayer:self.view.layer];
    if ([self.centerView.layer containsPoint:point] || [self.centerView.layer containsPoint:point] ) {
        return;
    }
    self.mengView.hidden = YES;

    self.selectTableView.hidden = YES;
    for (int i = 0; i < self.cadList.count; i++) {

    }


}
-(void)selectTime
{
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        self.tableView.date = [selectDate stringWithFormat:@"yyyy-MM-dd HH:mm:00"];
        NSLog(@"%@",self.tableView.date);
        [self.tableView reloadData];

    }];
    datepicker.dateLabelColor = MainColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = MainColor;//确定按钮的颜色
    [datepicker show];
}

-(void)TheReturnValueStr:(NSString *)Str selectDic:(NSDictionary *)dic selectSid:(NSInteger)sid
{
    if ([select isEqualToString:@"0"]) {
        self.tableView.distributionStr = Str;
        dkey = dic[@"dkey"];
        [self.tableView reloadData];
    }else
    {
        NSLog(@"%@",dic);
        self.tableView.CourierCompanyStr = Str;
        dkey = dic[@"dkey"];
        [self.tableView reloadData];
    }

}



-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    UITextField *textFid1 = [self.view viewWithTag:100];
    UITextField *textFid2 = [self.view viewWithTag:1001];
    TLTextField *textFid3 = [self.tableView viewWithTag:10001];
    TLTextField *textFid4 = [self.tableView viewWithTag:10002];
    
    if ([self.tableView.date isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择发货时间"];
        return;
    }
    if ([self.tableView.distributionStr isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选择寄送方式"];
        return;
    }

    if ([self.tableView.distributionStr isEqualToString:@"快递"]) {
        if ([self.tableView.CourierCompanyStr isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请选择快递公司"];
            return;
        }

        if ([textFid1.text isEqualToString:@""]) {
            [TLAlert alertWithInfo:@"请输入快递单号"];
            return;
        }
    }
    if (self.cadList.count == 0) {
        [TLAlert alertWithInfo:@"请选择材料清单"];
        return;

    }

    TLNetworking *http = [TLNetworking new];
    http.code = @"632150";
    http.showView = self.view;
    http.parameters[@"code"] = _model.code;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"updater"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"sendDatetime"] = self.tableView.date;
    if (self.cadList.count >1) {
        http.parameters[@"filelist"] = [self.fileIdList componentsJoinedByString:@","];

    }else{
        http.parameters[@"filelist"] = [self.fileIdList componentsJoinedByString:@","];

    }
    http.parameters[@"sendFileList"] = @"0";
    http.parameters[@"sender"] = [USERDEFAULTS objectForKey:USER_ID];

    http.parameters[@"typeList"] = @[@"1",@"3"];

    if ([self.tableView.distributionStr isEqualToString:@"快递"]) {
        http.parameters[@"sendType"] = @"2";
    }else
    {
        http.parameters[@"sendType"] = @"1";
    }
     if ([self.tableView.distributionStr isEqualToString:@"快递"])
     {
         if (![self.tableView.remarkKuaiField.text isEqualToString:@""]) {
             http.parameters[@"sendNote"] = self.tableView.remarkKuaiField.text;
             http.parameters[@"remark"] = self.tableView.remarkKuaiField.text;
             
         }
         if (textFid3.text.length>0) {
             http.parameters[@"remark"] = self.tableView.remarkKuaiField.text;
             http.parameters[@"sendNote"] = self.tableView.remarkKuaiField.text;

         }
     }else{
         
         if (![self.tableView.remarkField.text isEqualToString:@""]) {
             http.parameters[@"sendNote"] = self.tableView.remarkField.text;
             http.parameters[@"remark"] = self.tableView.remarkField.text;
             
         }
         if (textFid4.text.length>0) {
             http.parameters[@"remark"] = self.tableView.remarkField.text;
             http.parameters[@"remark"] = self.tableView.remarkField.text;

         }
     }
    
    if ([self.tableView.distributionStr isEqualToString:@"快递"]) {
        http.parameters[@"logisticsCompany"] = dkey;
        http.parameters[@"logisticsCode"] = self.tableView.kuaidField.text;
    }
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"发件成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];

    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}

#pragma mark tableView


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse"];
    }
    UIImageView *rightImg = [[UIImageView alloc] init];
    rightImg.tag = indexPath.row+100;
    //                rightImg.contentMode = UIViewContentModeScaleToFill;
    rightImg.frame = CGRectMake(120, 0+indexPath.row*30, 14, 12);
    rightImg.image = kImage(@"打勾");
    rightImg.hidden = YES;
    [cell.contentView addSubview:rightImg];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.models[indexPath.row].name];
    return cell;
}


-(void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([self.cadList containsObject:self.models[indexPath.row].name]) {
        return;
    }
    [self.cadList addObject:self.models[indexPath.row].name];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UIImageView *image  = [cell viewWithTag:indexPath.row+100];
    image.hidden = NO;
    self.tableView.cardStr = [NSString stringWithFormat:@"%@,%@",self.tableView.cardStr, self.models[indexPath.row].name];
    [self.tableView reloadData];
    //
    if ([self.fileIdList containsObject:self.models[indexPath.row].ID]) {
        return;
    }else{
        [self.fileIdList addObject:self.models[indexPath.row].ID];

    }
    
}

@end
