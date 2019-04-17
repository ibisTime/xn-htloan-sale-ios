//
//  AttachmentPoolVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AttachmentPoolVC.h"
#import "AttachmentPoolTableView.h"
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
        [self.view addSubview:bottomBtn];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
