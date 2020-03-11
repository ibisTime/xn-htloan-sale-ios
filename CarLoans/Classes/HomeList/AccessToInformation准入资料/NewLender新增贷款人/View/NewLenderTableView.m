//
//  NewLenderTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "NewLenderTableView.h"
#import "MenuInputCell.h"
#import "NewLenderCell.h"
@interface NewLenderTableView ()<UITableViewDataSource,UITableViewDelegate>

@end
@implementation NewLenderTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[MenuInputCell class] forCellReuseIdentifier:@"MenuInputCell"];
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
    return [MenuModel new].newLenderArray.count;
}
#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 1) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        NewLenderCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[NewLenderCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.isDetails = self.isDetails;
        cell.idFrontDic = self.idFrontDic;
        cell.idReverse = [BaseModel convertNull:self.idReverse];
        cell.idFront = [BaseModel convertNull:self.idFront];
        cell.holdIdCardPdf = [BaseModel convertNull:self.holdIdCardPdf];
        cell.idReverseDic = self.idReverseDic;
        
        cell.returnAryBlock1 = ^(NSString * _Nonnull idFront, NSDictionary * _Nonnull idFrontDic, NSString * _Nonnull idReverse, NSDictionary * _Nonnull idReverseDic, NSString * _Nonnull holdIdCardPdf) {
         
            self.returnAryBlock(idFront, idFrontDic, idReverse, idReverseDic, holdIdCardPdf);
            
        };
        return cell;
    }else
    {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = [MenuModel new].newLenderArray;
        
        if (indexPath.row == 6) {
            cell.leftStr = [NSString stringWithFormat:@"完善%@信息",_dataDic[@"dvalue"]];
        }else
        {
            cell.leftStr = nameArray[indexPath.row];
        }
        
        
        if (indexPath.row == 0) {
            
            cell.type = MenuShowType;
            cell.rightStr = _dataDic[@"dvalue"];
            
        }else if (indexPath.row == 2) {
//            身份证信息
            cell.type = MenuPushType;
            
            cell.rightStr = _idNo;
            
        }else if (indexPath.row == 4) {
            if (self.isDetails == YES) {
                cell.type = MenuShowType;
            }else
            {
                cell.type = MenuChooseType;
            }
            
            if ([BaseModel isBlankString:self.bankCreditResult] == NO) {
                if ([self.bankCreditResult isEqualToString:@"1"]) {
                    cell.rightStr = @"通过";
                }else
                {
                    cell.rightStr = @"不通过";
                }
            }
            
        }else if (indexPath.row == 6) {
            cell.type = MenuPushType;
        }else
        {
            if (self.isDetails == YES) {
                cell.type = MenuShowType;
                cell.rightLbl.tag = 200 + indexPath.row;
            }else
            {
                cell.type = MenuInputType;
                cell.rightTF.tag = 200 + indexPath.row;
            }
            cell.placStr = [NSString stringWithFormat:@"请输入%@",nameArray[indexPath.row]];
        }
        return cell;
    }
    
    
    
    
    
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
    if (indexPath.row == 1) {
        return 162;
    }
    return 55;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }
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
