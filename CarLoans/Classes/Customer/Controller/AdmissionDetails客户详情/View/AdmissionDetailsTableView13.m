//
//  AdmissionDetailsTableView13.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView13.h"

@interface AdmissionDetailsTableView13 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end
@implementation AdmissionDetailsTableView13
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.budgetOrderGps.count;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 8;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < self.model.budgetOrderGps.count; i ++) {
        if (indexPath.section == i) {
            if (indexPath.row == 5 || indexPath.row == 6 ) {
                static NSString *CellIdentifier = @"PhotoCell";
                PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
                if (cell == nil) {
                    cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                if (indexPath.row == 5) {
                    cell.collectDataArray = [self.model.budgetOrderGps[i][@"devPhotos"] componentsSeparatedByString:@"||"];
                    cell.selectStr = @"设备图片";
                }
                if (indexPath.row == 6) {
                    cell.collectDataArray = [self.model.budgetOrderGps[i][@"azPhotos"] componentsSeparatedByString:@"||"];
                    cell.selectStr = @"安装图片";
                }
                
                return cell;
                
            }
            
            static NSString *CellIdentifier = @"Cell";
            AdmissionInformationCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (cell == nil) {
                cell = [[AdmissionInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            _cell = cell;
            NSArray *topArray = @[@"GPS设备号",@"GPS类型",@"安装位置",@"安装时间",@"安装人员",@"",@"",@"备注"];
            cell.topLbl.text = topArray[indexPath.row];
            
            NSArray *bottomArray = @[[BaseModel convertNull:self.model.budgetOrderGps[i][@"gpsDevNo"]],
                                     [self.model.budgetOrderGps[i][@"gpsType"] isEqualToString:@"1"]?@"有线":@"无线",
                                     [BaseModel convertNull:self.model.budgetOrderGps[i][@"azLocation"]],
                                     [BaseModel convertNull:[self.model.budgetOrderGps[i][@"azDatetime"] convertDateWithFormat:@"yyyy-MM-dd HH-mm"]],
                                     [BaseModel convertNull:self.model.budgetOrderGps[i][@"azUser"]],
                                     @"",
                                     @"",
                                     [BaseModel convertNull:self.model.budgetOrderGps[i][@"remark"]]];
            cell.bottomLbl.frame = CGRectMake(15, 39, SCREEN_WIDTH - 137, 14);
            cell.bottomLbl.numberOfLines = 0;
            cell.bottomLbl.text = bottomArray[indexPath.row];
            [cell.bottomLbl sizeToFit];
            return cell;
        }
    }
    return nil;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.refreshDelegate respondsToSelector:@selector(refreshTableView:didSelectRowAtIndexPath:)]) {
        [self.refreshDelegate refreshTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -- 行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < self.model.budgetOrderGps.count; i ++) {
        if (indexPath.section == i) {
    if (indexPath.row == 5) {
        return [self returnheight:[self.model.budgetOrderGps[i][@"devPhotos"] componentsSeparatedByString:@"||"]];
    }
    if (indexPath.row == 6) {
        return [self returnheight:[self.model.budgetOrderGps[i][@"azPhotos"] componentsSeparatedByString:@"||"]];
    }
            
        }
    }
    return _cell.bottomLbl.yy ;
}
-(float)returnheight:(NSArray *)array{
    float numberToRound;
    int result;
    numberToRound = (array.count)/3.0;
    result = (int)ceilf(numberToRound);
    return  result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 58;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 23;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = kWhiteColor;
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 107 - 15, 58) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = @"GPS安装列表";
        [headView addSubview:nameLbl];
        
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 57, SCREEN_WIDTH - 107, 1)];
        lineView.backgroundColor = kLineColor;
        [headView addSubview:lineView];
        
        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    UIView *footView = [[UIView alloc]init];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 22, SCREEN_WIDTH - 107, 1)];
    lineView.backgroundColor = kLineColor;
    [footView addSubview:lineView];
    return footView;
}


@end
