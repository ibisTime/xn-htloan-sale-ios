//
//  MatEndowmentRecordTableView.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MatEndowmentRecordTableView.h"

#import "MenuInputCell.h"
#import "InstructionsCell.h"
#import "UploadMultiplePicturesCell.h"
@interface MatEndowmentRecordTableView ()<UITableViewDataSource,UITableViewDelegate>
{
    UploadMultiplePicturesCell *_cell;
}


@end
@implementation MatEndowmentRecordTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [MenuModel new].detailsInfoArray.count;
    }
    if (section == 1) {
        return 2;
    }
    return 1;
    
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
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = [MenuModel new].detailsInfoArray;
        cell.leftStr = nameArray[indexPath.row];
        if (indexPath.row == 0) {
            cell.type = MenuCheckDetailsType;
            cell.rightLbl.text = self.model.code;
        }else
        {
            cell.type = MenuShowType;
            NSString *bizType;
            if ([self.model.bizType isEqualToString:@"0"]) {
                bizType = @"新车";
            }else
            {
                bizType = @"二手车";
            }
            NSArray *ary = @[@"",
                             [BaseModel convertNull:self.model.creditUser[@"userName"]],
                             [BaseModel convertNull:self.model.loanBankName],
                             bizType,
                             [BaseModel Chu1000:self.model.loanAmount],
                             [[BaseModel user]note:self.model.curNodeCode],
                             [self.model.applyDatetime convertToDetailDate],
                             [NSString stringWithFormat:@"%@（%@）",self.model.saleUserName,self.model.teamName]
                             ];
            cell.rightLbl.text = ary[indexPath.row];
        }
        return cell;
    }
    if (indexPath.section == 1)
    {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        MenuInputCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[MenuInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *nameArray = @[@"垫资日期",@"垫资金额"];
        if (indexPath.row == 0) {
            cell.type = MenuChooseType;
//            cell.rightStr = self.advanceFundDatetime;
        }else
        {
            cell.type = MenuInputType;
            
        }
        
        
        NSArray *ary = @[self.advanceFundDatetime,
                         [BaseModel Chu1000:self.model.loanAmount]];
        cell.rightStr = ary[indexPath.row];
        cell.rightTF.tag = 100 + indexPath.row;
        cell.leftStr = nameArray[indexPath.row];
        cell.placStr = [NSString stringWithFormat:@"请输入%@",nameArray[indexPath.row]];
        return cell;
    }
    
    if (indexPath.section == 2) {
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
        UploadMultiplePicturesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UploadMultiplePicturesCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = @"水单上传";
        cell.imagePicker.count = 1;
        cell.returnAryBlock = ^(NSArray * _Nonnull imgAry, NSString * _Nonnull name, NSInteger section) {
            self.returnAryBlock(imgAry, name, section);
            [self reloadData];
        };
        
        _cell = cell;
        return cell;
    }
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell1%ld%ld",indexPath.section,indexPath.row];
    InstructionsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[InstructionsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.placeHolderLabel.text = @"请输入垫资说明";
    cell.textView.tag = 1000;
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
    if (indexPath.section == 2) {
        return _cell.collectionView.yy;
    }
    if (indexPath.section == 3) {
        return 125;
    }
    return 55;
}

#pragma mark -- 区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
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
    if (section == 1) {
        UIView *headView = [[UIView alloc]init];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        lineView.backgroundColor = kHexColor(@"#F5F5F5");
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
