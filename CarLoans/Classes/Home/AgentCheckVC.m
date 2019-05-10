//
//  AgentCheckVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/10.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "AgentCheckVC.h"
#import "AgentTableView.h"
@interface AgentCheckVC ()<RefreshDelegate,SelectButtonDelegate>
@property (nonatomic,strong) AgentTableView * tableView;
@property (nonatomic , assign)NSInteger selectInt;
@property (nonatomic , strong)TLImagePicker *imagePicker;
@end

@implementation AgentCheckVC
#pragma mark - 选择图片
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
    if (self.selectInt == 50)
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"内勤确认";
    [self inittableview];
}
-(void)inittableview{
    self.tableView = [[AgentTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.AgentDelegate = self;
    [self.view addSubview:self.tableView];
}
-(void)selectButtonClick:(UIButton *)sender{
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
-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state{
    if ([state isEqualToString:@"IDCard"])
    {
        self.selectInt = index;
        [self.imagePicker picker];
    }
    [self.tableView reloadData];
}
@end
