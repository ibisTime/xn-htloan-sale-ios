//
//  DataDetailsVC.m
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/29.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DataDetailsVC.h"
#import "DataDetailsTableView.h"
#import "DataTransferModel.h"
#import "CadListModel.h"
@interface DataDetailsVC ()<RefreshDelegate>{
    NSMutableArray * filearray;
}
@property (nonatomic , strong)DataTransferModel *model;
@property (nonatomic,strong) DataDetailsTableView * tableView;
@property (nonatomic , strong)NSMutableArray <CadListModel *>*models;
@end

@implementation DataDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资料寄送详情";
    filearray = [NSMutableArray array];
    [self loaddata];
}
- (void)loadCadList
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"632217";
    http.parameters[@"category"] =@"node_file_list";
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        self.models = [CadListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSArray * dataarr = [self.model.filelist componentsSeparatedByString:@","];
        NSMutableArray *array = [NSMutableArray array];
        for (CadListModel *model in self.models) {
            for (int i = 0; i < dataarr.count; i ++) {
                if ([model.ID isEqualToString:dataarr[i]]) {
                    [array addObject:[NSString stringWithFormat:@"%@-%@份",model.vname,model.number]];
                }
            }
        }
        filearray = array;
        [self inittable];
    } failure:^(NSError *error) {
    }];
}

-(void)loaddata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"632156";
    http.parameters[@"code"] = self.code;
    http.showView = self.view;
    [http postWithSuccess:^(id responseObject) {
        self.model = [DataTransferModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self loadCadList];
    } failure:^(NSError *error) {
        
    }];
}

-(void)inittable{
    self.tableView = [[DataDetailsTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.backgroundColor = kWhiteColor;
    self.tableView.refreshDelegate = self;
    self.tableView.model = self.model;
    self.tableView.filearray =filearray;
    [self.view addSubview:self.tableView];
}

@end
