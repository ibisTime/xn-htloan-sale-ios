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
#import "VehicleLicenseCell.h"
@interface MenuTableView6 ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UploadMultiplePicturesCell *_cell;
    NSMutableArray *_writeArray;
    NSInteger lastIndex;
}


@end
@implementation MenuTableView6

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        _gpsAry = [NSMutableArray array];
        _gpsPhotoAry = [NSMutableArray array];
        _writeArray = [NSMutableArray array];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.model.gpsAzList.count == 0) {
        if ([_isAzGps isEqualToString:@"1"]) {
            if (_gpsAry.count == 0) {
                SurveyModel *dic = [SurveyModel mj_objectWithKeyValues:@{}];
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
    if ([self.bizType isEqualToString:@"1"]) {
        return [MenuModel new].usedCarMenuArray6.count;
    }
    return [MenuModel new].menuArray6.count;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if ([self.bizType isEqualToString:@"1"]) {
            if (indexPath.row == 2) {
                NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
                VehicleLicenseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (!cell) {
                    cell = [[VehicleLicenseCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.isDetails = self.isDetails;
                cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
                    self.returnAryBlock(imgAry, name, section);
                };
                cell.collectDataArray = self.driveLicense;
//                _cell = cell;
                return cell;
            }
        }
        
        NSString *CellIdentifier = [NSString stringWithFormat:@"0cell%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray;
        
        cell.rightTF.delegate = self;
        
        NSInteger row = 0;
        
        if ([self.bizType isEqualToString:@"1"]) {
            
            row = 4;
            nameArray = [MenuModel new].usedCarMenuArray6;

        }else
        {
            row = 0;
            nameArray = [MenuModel new].menuArray6;
            
        }
        
        if (indexPath.row >= 6 + row && indexPath.row <= 10 + row) {
            
            
            if (indexPath.row == 6 + row) {
                cell.type = MenuChooseType;
                cell.rightLbl.text = [BaseModel convertNull:self.regAddress];
            }
            if (indexPath.row == 7 + row) {
                cell.type = MenuChooseType;
                NSString *isPublicCard;
                if ([self.isPublicCard isEqualToString:@"1"]) {
                    isPublicCard = @"是";
                }else if ([self.isPublicCard isEqualToString:@"0"])
                {
                    isPublicCard = @"否";
                }
                else
                {
                    isPublicCard = @"";
                }
                if (self.isDetails == YES) {
                    cell.type = MenuShowType;
                }
                cell.rightLbl.text = isPublicCard;
            }
            if (indexPath.row == 8 + row) {
                cell.type = MenuPushType;
                cell.rightStr = [BaseModel convertNull:self.carBrand];
            }else if (indexPath.row == 9 + row || indexPath.row == 10 + row) {
                cell.type = MenuShowType;
                NSArray *ary = @[[BaseModel convertNull:self.carSeries],
                                 [BaseModel convertNull:self.carModel]];
                cell.rightStr = ary[indexPath.row - 9 - row];
            }
            
        }else
        {
            
            cell.rightTF.tag = 6000 + indexPath.row;
            if (self.isDetails == YES) {
                cell.type = MenuShowType;
                if (_writeArray.count > 0) {
                    if (indexPath.row < _writeArray.count) {
                        cell.rightStr = _writeArray[indexPath.row];
                    }
                }
                
            }
            else
            {
                cell.type = MenuInputType;
                if (_writeArray.count > 0) {
                    if (indexPath.row < _writeArray.count) {
                        cell.rightStr = _writeArray[indexPath.row];
                    }
                }
            }
            cell.placStr = [NSString stringWithFormat:@"请输入%@",nameArray[indexPath.row]];
        }
        cell.leftStr = nameArray[indexPath.row];
        if ([self.bizType isEqualToString:@"1"]) {
            
            
            if (indexPath.row >= 0 && indexPath.row <= 4) {
                if (indexPath.row == 3) {
                    cell.type = MenuShowType;
                    cell.rightLbl.textColor = kAppCustomMainColor;
                }else
                {
                    cell.rightLbl.textColor = kHexColor(@"#333333");
                }
                if (_writeArray.count > 0) {
                    cell.rightStr = _writeArray[indexPath.row];
                }
                if (indexPath.row == 3) {
                    if (self.isDetails == YES) {
                        cell.type = MenuShowType;
                    }else
                    {
                        cell.type = MenuCheckDetailsType1;
                    }
//                    cell.type = MenuCheckDetailsType1;
                    if ([BaseModel isBlankString:self.secondCarReport] == YES) {
                        cell.rightStr = @"点击获取报告";
//                        cell.checkDetailsBtn1.hidden = YES;
                        
                    }else
                    {
                        if ([self.secondCarReport isEqualToString:@""]) {
                            cell.rightStr = @"点击获取报告";
//                            cell.checkDetailsBtn1.hidden = YES;
                        }else
                        {
//                            cell.checkDetailsBtn1.hidden = NO;
                            cell.rightStr = self.secondCarReport;
                            [cell.checkDetailsBtn1 addTarget:self action:@selector(checkDetailsBtn1Click:) forControlEvents:(UIControlEventTouchUpInside)];
                            
                        }
                    }
                }
                if (indexPath.row == 0) {
                    cell.type = MenuChooseType;
                    
                    if (_writeArray.count > 0) {
                        cell.rightStr = _writeArray[indexPath.row];
                    }
                }
            }
        }
//        cell.leftStr = nameArray[indexPath.row];
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

        if (self.gpsAry.count > 0) {
            if ([BaseModel isBlankString:self.gpsAry[indexPath.section - 2].gpsDevNo] == NO) {
                cell.rightStr = [BaseModel convertNull:self.gpsAry[indexPath.section - 2].gpsDevNo];
            }
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
    cell.isDetails = self.isDetails;
    MJWeakSelf;
    cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
//        self.returnAryBlock(imgAry, name, section);
        [weakSelf.gpsPhotoAry replaceObjectAtIndex:section withObject:imgAry];
        [weakSelf reloadData];
    };
    cell.collectDataArray = weakSelf.gpsPhotoAry[indexPath.section - 2];
    _cell = cell;
    return cell;
}

-(void)checkDetailsBtn1Click:(UIButton *)sender
{
    [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:0 selectRowState:@"评估报告"];
}


-(void)setRegDate:(NSString *)regDate
{
    _regDate = regDate;
    if ([_model.bizType isEqualToString:@"1"]) {
         [_writeArray replaceObjectAtIndex:0 withObject:regDate];
    }
    [self reloadData];
}

-(void)setOriginalPrice:(NSString *)originalPrice
{
    if ([_model.bizType isEqualToString:@"1"]) {
        [_writeArray replaceObjectAtIndex:5 withObject:[BaseModel Chu1000:originalPrice]];
    }else
    {
        [_writeArray replaceObjectAtIndex:1 withObject:[BaseModel Chu1000:originalPrice]];
    }
    [self reloadData];
}


-(void)setCarFrameNo:(NSString *)carFrameNo
{
    if ([_model.bizType isEqualToString:@"1"]) {
        [_writeArray replaceObjectAtIndex:6 withObject:carFrameNo];
    }else
    {
        [_writeArray replaceObjectAtIndex:2 withObject:carFrameNo];
    }
    [self reloadData];
}

-(void)setCarEngineNo:(NSString *)carEngineNo
{
    if ([_model.bizType isEqualToString:@"1"]) {
        [_writeArray replaceObjectAtIndex:7 withObject:carEngineNo];
    }else
    {
        [_writeArray replaceObjectAtIndex:3 withObject:carEngineNo];
    }
    [self reloadData];
}

-(void)setCarNumber:(NSString *)carNumber
{
    if ([_model.bizType isEqualToString:@"1"]) {
        [_writeArray replaceObjectAtIndex:8 withObject:carNumber];
    }else
    {
        [_writeArray replaceObjectAtIndex:4 withObject:carNumber];
    }
    [self reloadData];
}

-(void)setEvalPrice:(NSString *)evalPrice
{
    if ([_model.bizType isEqualToString:@"1"]) {
        [_writeArray replaceObjectAtIndex:9 withObject:[BaseModel Chu1000:evalPrice]];
    }
    else
    {
        [_writeArray replaceObjectAtIndex:5 withObject:[BaseModel Chu1000:evalPrice]];
    }
    [self reloadData];
}

-(void)setModelNumber:(NSString *)modelNumber
{
    if ([_model.bizType isEqualToString:@"1"]) {
        [_writeArray replaceObjectAtIndex:4 withObject:modelNumber];
    }else
    {
        [_writeArray replaceObjectAtIndex:0 withObject:modelNumber];
    }
    [self reloadData];
}

-(void)setModel:(SurveyModel *)model
{

    _model = model;
    
    if ([model.bizType isEqualToString:@"1"]) {
        _writeArray = [NSMutableArray arrayWithArray:
                       @[
                         [BaseModel convertNull:self.regDate],
                         [BaseModel convertNull:self.model.carInfo[@"mile"]],
                         @"",
                         @"",
                         [BaseModel convertNull:self.model.carInfo[@"model"]],
                         [BaseModel Chu1000:self.model.carInfo[@"carPrice"]],
                         [BaseModel convertNull:self.model.carInfo[@"carFrameNo"]],
                         [BaseModel convertNull:self.model.carInfo[@"carEngineNo"]],
                         [BaseModel convertNull:self.model.carInfo[@"carNumber"]],
                         [BaseModel Chu1000:self.model.carInfo[@"evalPrice"]]
                         ]];
    }else{
        _writeArray = [NSMutableArray arrayWithArray:
                       @[[BaseModel convertNull:self.model.carInfo[@"model"]],
                         [BaseModel Chu1000:self.model.carInfo[@"carPrice"]],
                         [BaseModel convertNull:self.model.carInfo[@"carFrameNo"]],
                         [BaseModel convertNull:self.model.carInfo[@"carEngineNo"]],
                         [BaseModel convertNull:self.model.carInfo[@"carNumber"]],
                         [BaseModel Chu1000:self.model.carInfo[@"evalPrice"]]
                         ]];
    }
    
    [self reloadData];
}


//3.对输入的文本插入到数组中
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [_writeArray replaceObjectAtIndex:textField.tag - 6000 withObject:textField.text];
}

//4.获取lastIndex
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    lastIndex = textField.tag;
    return YES;
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
    if (indexPath.section == 0) {
        if ([self.bizType isEqualToString:@"1"]) {
            if (indexPath.row == 2) {
                return 41 + 82.5 + 10;
            }
        }
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
