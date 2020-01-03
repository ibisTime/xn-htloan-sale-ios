//
//  MenuTableView6.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MenuTableView6.h"
#import "MenuInputCell.h"
#import "UploadMultiplePicturesCell.h"
@interface MenuTableView6 ()<UITableViewDataSource,UITableViewDelegate>
{
    UploadMultiplePicturesCell *_cell;
}


@end
@implementation MenuTableView6

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        _gpsAry = [NSMutableArray array];
        _gpsPhotoAry = [NSMutableArray array];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.model.gpsAzList.count == 0) {
        if ([_isAzGps isEqualToString:@"1"]) {
            if (_gpsAry.count == 0) {
                NSDictionary *dic = @{};
                [_gpsAry addObject:dic];
                [_gpsPhotoAry addObject:@[]];
            }
        }
    }
    return 2 + _gpsAry.count;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    if (section > 1) {
        return 2;
    }
    return [MenuModel new].menuArray6.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = [MenuModel new].menuArray6;
        cell.leftStr = nameArray[indexPath.row];
        if (indexPath.row == 7 || indexPath.row == 8 || indexPath.row == 9) {
            if (self.isDetails == YES) {
                cell.type = MenuShowType;
            }else
            {
                cell.type = MenuChooseType;
            }
            if (indexPath.row == 7) {
                cell.rightLbl.text = self.regDate;
            }
            if (indexPath.row == 8) {
                cell.rightLbl.text = [BaseModel convertNull:self.regAddress];
            }
            if (indexPath.row == 9) {
                NSString *isPublicCard;
                if ([self.isPublicCard isEqualToString:@"1"]) {
                    isPublicCard = @"是";
                }else if ([self.isPublicCard isEqualToString:@"0"])
                {
                    isPublicCard = @"否";
                }else
                {
                    isPublicCard = @"";
                }
                cell.rightLbl.text = isPublicCard;
            }
        }else
        {

            NSArray *ary = @[[BaseModel convertNull:self.model.carInfo[@"model"]],
                             [BaseModel Chu1000:self.model.carInfo[@"carPrice"]],
                             [BaseModel convertNull:self.model.carInfo[@"carFrameNo"]],
                             [BaseModel convertNull:self.model.carInfo[@"carEngineNo"]],
                             [BaseModel convertNull:self.model.carInfo[@"carNumber"]],
                             [BaseModel convertNull:self.model.carInfo[@"mile"]],
                             [BaseModel Chu1000:self.model.carInfo[@"evalPrice"]]
                             ];
            
            cell.rightTF.tag = 6000 + indexPath.row;
            if (self.isDetails == YES) {
                cell.type = MenuShowType;
                cell.rightLbl.text = ary[indexPath.row];
            }else
            {
                cell.type = MenuInputType;
                if ([cell.rightTF.text isEqualToString:@""]) {
                    cell.rightTF.text = ary[indexPath.row];
                }
            }
            
            cell.placStr = [NSString stringWithFormat:@"请输入%@",nameArray[indexPath.row]];
        }
        return cell;
    }
    if (indexPath.section == 1) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"是否加装GPS"];
        cell.leftStr = nameArray[indexPath.row];
        if (self.isDetails == YES) {
            cell.type = MenuShowType;
        }else
        {
            cell.type = MenuChooseType;
        }
        
        if (indexPath.row == 0) {
            NSString *isAzGps;
            if ([self.isAzGps isEqualToString:@"1"]) {
                isAzGps = @"是";
            }else if ([self.isAzGps isEqualToString:@"0"])
            {
                isAzGps = @"否";
            }else
            {
                isAzGps = @"";
            }
            cell.rightLbl.text = isAzGps;
        }
        return cell;
    }
    
    if (indexPath.row == 0) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"GPS"];
        cell.leftStr = nameArray[indexPath.row];
        if (self.isDetails == YES) {
            cell.type = MenuShowType;
        }else
        {
            cell.type = MenuChooseType;
        }
        
        if ([BaseModel isBlankString:self.gpsAry[indexPath.section - 2][@"gpsDevNo"]] == NO) {
            cell.rightStr = [BaseModel convertNull:self.gpsAry[indexPath.section - 2][@"gpsDevNo"]];
        }
        return cell;
    }
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    UploadMultiplePicturesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UploadMultiplePicturesCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = @"GPS图片";
    cell.selectSection = indexPath.section - 2;

    MJWeakSelf;
    cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
        [weakSelf.gpsPhotoAry replaceObjectAtIndex:section withObject:imgAry];
        [weakSelf reloadData];
    };
    cell.collectDataArray = weakSelf.gpsPhotoAry[indexPath.section - 2];
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
    if (indexPath.section >= 2) {
        if (indexPath.row == 1) {
            return _cell.collectionView.yy;
        }
        return 55;
    }
    return 55;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0 || section != 2) {
        return 10;
    }
    return 0.01;
}

#pragma mark -- 区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    if ([self.isAzGps isEqualToString:@"1"]) {
        if (section == self.gpsAry.count + 1) {
            if (self.isDetails == YES) {
                return 0.01;
            }
            return 50;
        }
    }
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 0 || section != 2) {
        UIView *headView = [[UIView alloc]init];
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        backView.backgroundColor = kHexColor(@"#F5F5F5");
        [headView addSubview:backView];
        return headView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.isAzGps isEqualToString:@"1"]) {
        if (section == self.gpsAry.count + 1) {
            if (self.isDetails == YES) {
                return nil;
            }
            UIView *headView = [[UIView alloc]init];
            UIButton *addGPSBtn = [UIButton buttonWithTitle:@"+ 添加GPS" titleColor:kAppCustomMainColor backgroundColor:RGB(232, 243, 254) titleFont:12 cornerRadius:14.5];
            addGPSBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 97/2, 20, 97, 29);
            [addGPSBtn addTarget:self action:@selector(addGPSBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
            [headView addSubview:addGPSBtn];
            return headView;
        }
    }
    return nil;
}

-(void)addGPSBtnClick
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:nil selectRowAtIndex:100];
}
@end
