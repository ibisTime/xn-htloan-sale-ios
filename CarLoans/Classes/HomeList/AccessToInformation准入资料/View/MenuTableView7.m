//
//  MenuTableView7.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MenuTableView7.h"

#import "UploadMultiplePicturesCell.h"
#import "MaterialsUploadedCell.h"
@interface MenuTableView7 ()<UITableViewDataSource,UITableViewDelegate>
{
    UploadMultiplePicturesCell *_cell;
}


@end
@implementation MenuTableView7

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
//        _gpsAry = [NSMutableArray array];
//        [_gpsAry addObjectsFromArray:@[]];
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 6;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if (indexPath.section == 0) {
        
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MaterialsUploadedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MaterialsUploadedCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataUploadBlock = ^(NSString * _Nonnull driveCard, NSString * _Nonnull marryPdf, NSString * _Nonnull divorcePdf, NSString * _Nonnull singleProve, NSString * _Nonnull incomeProve, NSString * _Nonnull liveProvePdf, NSString * _Nonnull housePropertyCardPdf) {
            self.dataUploadBlock(driveCard, marryPdf, divorcePdf, singleProve, incomeProve, liveProvePdf, housePropertyCardPdf);
        };
        cell.isDetails = self.isDetails;
        cell.driveCard = self.driveCard;
        cell.marryPdf = self.marryPdf;
        cell.divorcePdf = self.divorcePdf;
        cell.singleProve = self.singleProve;
        cell.incomeProve = self.incomeProve;
        cell.liveProvePdf = self.liveProvePdf;
        cell.housePropertyCardPdf = self.housePropertyCardPdf;
        
        return cell;
    }
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    UploadMultiplePicturesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UploadMultiplePicturesCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"户口本（多选）",@"银行流水（多选）",@"支付宝流水（多选）",@"微信流水（多选）",@"其他（多选）",@"合同签约视频"];
    cell.name = nameArray[indexPath.row];
    
    cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
        self.returnAryBlock(imgAry, name, section);
    };
    cell.isDetails = self.isDetails;
    if (indexPath.row == 0) {
        cell.collectDataArray = self.hkBookFirstPage;
    }
    if (indexPath.row == 1) {
        cell.collectDataArray = self.bankJourFirstPage;
    }
    if (indexPath.row == 2) {
        cell.collectDataArray = self.zfbJour;
    }
    if (indexPath.row == 3) {
        cell.collectDataArray = self.wxJour;
    }
    if (indexPath.row == 4) {
        cell.collectDataArray = self.otherPdf;
    }
    if (indexPath.row == 5) {
        cell.collectDataArray = self.contractAwardVideo;
    }
    _cell = cell;
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
    if (indexPath.section == 0) {
        return 410;
    }
    return _cell.collectionView.yy;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 0.01;
}
#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return nil;
}
@end
