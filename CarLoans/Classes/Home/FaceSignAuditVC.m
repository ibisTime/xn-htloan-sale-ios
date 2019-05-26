//
//  FaceSignAuditVC.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/25.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "FaceSignAuditVC.h"
#import "FaceSignAuditTableView.h"
@interface FaceSignAuditVC ()<RefreshDelegate>

@property (nonatomic ,strong )FaceSignAuditTableView *tableView;

@end

@implementation FaceSignAuditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title = @"面签审核";
    [self FaceToFaceContent];
}

-(void)FaceToFaceContent{
    for (int i = 0; i < self.model.attachments.count; i ++) {
        NSDictionary *dic = self.model.attachments[i];
        //        银行视频
        if ([dic[@"kname"] isEqualToString:@"bank_video"]) {
            
            self.tableView.BankVideoArray = [NSMutableArray arrayWithArray:[dic[@"url"] componentsSeparatedByString:@"||"]];
        }
        //        公司视频
        if ([dic[@"kname"] isEqualToString:@"company_video"]) {
            self.tableView.CompanyVideoArray = [NSMutableArray arrayWithArray:[dic[@"url"] componentsSeparatedByString:@"||"]];
        }
        //        其他视频
        if ([dic[@"kname"] isEqualToString:@"other_video"]) {
            self.tableView.OtherVideoArray = [NSMutableArray arrayWithArray:[dic[@"url"] componentsSeparatedByString:@"||"]];
        }
        //        银行面签图片
        if ([dic[@"kname"] isEqualToString:@"bank_photo"]) {
            self.tableView.BankSignArray = [dic[@"url"] componentsSeparatedByString:@"||"].mutableCopy;
        }
        //        银行合同
        if ([dic[@"kname"] isEqualToString:@"bank_contract"]) {
            self.tableView.BankContractArray = [dic[@"url"] componentsSeparatedByString:@"||"].mutableCopy;
        }
        //        公司合同
        if ([dic[@"kname"] isEqualToString:@"company_contract"]) {
            self.tableView.CompanyContractArray = [dic[@"url"] componentsSeparatedByString:@"||"].mutableCopy;
        }
        //        资金划转授权书
        if ([dic[@"kname"] isEqualToString:@"advance_fund_amount_pdf"]) {
            self.tableView.MoneyArray = [dic[@"url"] componentsSeparatedByString:@"||"].mutableCopy;
        }
        //        面签其他资料
        if ([dic[@"kname"] isEqualToString:@"interview_other_pdf"]) {
            self.tableView.otherArray = [dic[@"url"] componentsSeparatedByString:@"||"].mutableCopy;
        }

        [self.tableView reloadData];
    }
}


- (void)initTableView {
    self.tableView = [[FaceSignAuditTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
    UITextField *textField = [self.view viewWithTag:3000];
    if ([textField.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入审核意见"];
        return;
    }
    
    NSString *approveResult;
    if (index == 10000) {
        approveResult = @"1";
    }else
    {
        approveResult = @"0";
    }
    TLNetworking *http = [TLNetworking new];
    http.code = @"632137";
    http.showView = self.view;
    http.parameters[@"approveNote"] = textField.text;
    http.parameters[@"operator"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"code"] = _model.code;
    http.parameters[@"approveResult"] = approveResult;
    [http postWithSuccess:^(id responseObject) {
        [TLAlert alertWithSucces:@"审核成功"];
        NSNotification *notification =[NSNotification notificationWithName:LOADDATAPAGE object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
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
