//
//  MenuTableView8.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MenuTableView8.h"

#import "UploadMultiplePicturesCell.h"
#import "MaterialsUploadedCell.h"
@interface MenuTableView8 ()<UITableViewDataSource,UITableViewDelegate>
{
    UploadMultiplePicturesCell *_cell;
}


@end
@implementation MenuTableView8

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
    
    return 1;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    UploadMultiplePicturesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UploadMultiplePicturesCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *nameArray = @[@"上门照片（多选）",@"合照（多选）",@"家访视频",@"公司视频"];
    cell.name = nameArray[indexPath.row];
    cell.isDetails = self.isDetails;
    cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
        self.returnAryBlock(imgAry, name, section);
    };
    if (indexPath.row == 0) {
        cell.collectDataArray = self.doorPdf;
    }
    if (indexPath.row == 1) {
        cell.collectDataArray = self.groupPhoto;
    }
    if (indexPath.row == 2) {
        cell.collectDataArray = self.houseVideo;
    }
    if (indexPath.row == 3) {
        cell.collectDataArray = self.companyVideo;
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
