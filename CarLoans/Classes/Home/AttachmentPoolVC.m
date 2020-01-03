//
//  AttachmentPoolVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AttachmentPoolVC.h"
#import "AttachmentPoolTableView.h"
#import "AddingAssociatedVC.h"
#import "LocalUploadVC.h"
@interface AttachmentPoolVC ()<RefreshDelegate>
@property (nonatomic , strong)AttachmentPoolTableView *tableView;


@end


@implementation AttachmentPoolVC


- (void)viewDidLoad {
    self.title = @"附件池";
    [self initTableView];
    [self initNavigationController];
    NSArray *array = @[@"添加关联",@"本地上传"];
    for (int i = 0; i < 2; i ++) {
        UIButton *bottomBtn = [UIButton buttonWithTitle:array[i] titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16];
        bottomBtn.frame = CGRectMake(15 + i % 2 * ((SCREEN_WIDTH - 45)/2 + 15), SCREEN_HEIGHT - kNavigationBarHeight - 80 + 17.5, (SCREEN_WIDTH - 45)/2, 45);
        kViewRadius(bottomBtn, 2);
        bottomBtn.tag = 100 + i;
        [bottomBtn addTarget:self action:@selector(bottomBtnClcik:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:bottomBtn];
    }
    
}

-(void)bottomBtnClcik:(UIButton *)sender
{
    if (sender.tag == 100) {
        AddingAssociatedVC *vc = [AddingAssociatedVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        LocalUploadVC *vc = [LocalUploadVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)initTableView
{
    self.tableView = [[AttachmentPoolTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - 80) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end
