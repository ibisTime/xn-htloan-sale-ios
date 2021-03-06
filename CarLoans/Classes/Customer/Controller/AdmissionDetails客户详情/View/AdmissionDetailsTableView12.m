//
//  AdmissionDetailsTableView12.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView12.h"

@interface AdmissionDetailsTableView12 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end
@implementation AdmissionDetailsTableView12
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[AdmissionInformationCell class] forCellReuseIdentifier:@"AdmissionInformationCell"];
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4 ||  indexPath.row == 5) {
        static NSString *CellIdentifier = @"PhotoCell";
        PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (indexPath.row == 2) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_invoice"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"发票";
        }
        if (indexPath.row == 3) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_jqx"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"交强险";
        }
        if (indexPath.row == 4) {
            cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_syx"] componentsSeparatedByString:@"||"];
            cell.selectStr = @"商业险";
        }
        if (indexPath.row == 5) {
            if ([self.model.bizType isEqualToString:@"1"]) {
                cell.selectStr = @"绿大本";
                cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"green_big_smj"] componentsSeparatedByString:@"||"];
            }
            if ([self.model.bizType isEqualToString:@"0"]) {
                cell.selectStr = @"合格证";
                cell.collectDataArray = [[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_hgz_pic"] componentsSeparatedByString:@"||"];
            }
            
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
    NSArray *topArray = @[@"保单日期",
                          @"保单到期日",
                          @"",@"",@"",@""];
    cell.topLbl.text = topArray[indexPath.row];
    
    NSArray *bottomArray = @[
                             [BaseModel convertNull:[self.model.carInfoRes[@"policyDatetime"] convertDateWithFormat:@"yyyy-MM-dd"]],
                             [BaseModel convertNull:[self.model.carInfoRes[@"policyDueDate"] convertDateWithFormat:@"yyyy-MM-dd"]],
                             @"",@"",@"",@"",
                             @""];
    cell.bottomLbl.frame = CGRectMake(15, 39, SCREEN_WIDTH - 137, 14);
    cell.bottomLbl.numberOfLines = 0;
    cell.bottomLbl.text = bottomArray[indexPath.row];
    [cell.bottomLbl sizeToFit];
    return cell;
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
    switch (indexPath.row) {
        case 2:
            return [self returnheight:[[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_invoice"] componentsSeparatedByString:@"||"]];
            break;
        case 3:
            return [self returnheight:[[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_jqx"] componentsSeparatedByString:@"||"]];
            break;
        case 4:
            return [self returnheight:[[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_syx"] componentsSeparatedByString:@"||"]];
            break;
        case 5:{
            if ([self.model.bizType isEqualToString:@"1"]) {
                return [self returnheight:[[[BaseModel user]FindUrlWithModel:self.model ByKname:@"green_big_smj"] componentsSeparatedByString:@"||"]];
            }
            if ([self.model.bizType isEqualToString:@"0"]) {
                return [self returnheight:[[[BaseModel user]FindUrlWithModel:self.model ByKname:@"car_hgz_pic"] componentsSeparatedByString:@"||"]];
            }
        }
            
            break;
        default:
            break;
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
        nameLbl.text = @"保单信息";
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
    return nil;
}



@end
