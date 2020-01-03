//
//  AdmissionDetailsTableView2.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/16.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AdmissionDetailsTableView2.h"

#import "AdmissionInformationCell.h"
#import "AdmiissionDetailsIDCardCellCell.h"
#import "PhotoCell.h"
@interface AdmissionDetailsTableView2 ()<UITableViewDataSource,UITableViewDelegate>
{
    AdmissionInformationCell *_cell;
}
@end
@implementation AdmissionDetailsTableView2
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.creditUserList.count;
}

#pragma mark -- 行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 12;
}

#pragma mark -- tableView
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataDic = self.model.creditUserList[indexPath.section];
    if (indexPath.row == 5) {
        static NSString *CellIdentifier = @"AdmiissionDetailsIDCardCellCell";
        AdmiissionDetailsIDCardCellCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[AdmiissionDetailsIDCardCellCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if ([dataDic[@"loanRole"] isEqualToString:@"1"]) {
            [cell.button1 sd_setImageWithURL:[NSURL URLWithString:[self.id_no_front_apply convertImageUrl]] forState:UIControlStateNormal];
            [cell.button2 sd_setImageWithURL:[NSURL URLWithString:[self.id_no_reverse_apply convertImageUrl]] forState:UIControlStateNormal];
            cell.button1.tag = 100;
            cell.button2.tag = 101;
        }
        if ([dataDic[@"loanRole"] isEqualToString:@"2"]) {
            [cell.button1 sd_setImageWithURL:[NSURL URLWithString:[self.id_no_front_gh convertImageUrl]] forState:UIControlStateNormal];
            [cell.button2 sd_setImageWithURL:[NSURL URLWithString:[self.id_no_reverse_gh convertImageUrl]] forState:UIControlStateNormal];
            cell.button1.tag = 102;
            cell.button2.tag = 103;
        }
        if ([dataDic[@"loanRole"] isEqualToString:@"3"]) {
            
            
            [cell.button1 sd_setImageWithURL:[NSURL URLWithString:[self.id_no_front_gua convertImageUrl]] forState:UIControlStateNormal];
            [cell.button2 sd_setImageWithURL:[NSURL URLWithString:[self.id_no_reverse_gua convertImageUrl]] forState:UIControlStateNormal];
            cell.button1.tag = 104;
            cell.button2.tag = 105;
            if (indexPath.section > 0) {
                for (int i = 0; i < indexPath.section - 1; i ++) {
                    if ([self.model.creditUserList[indexPath.section][@"loanRole"] isEqualToString:@"3"]) {
                        [cell.button1 sd_setImageWithURL:[NSURL URLWithString:[self.id_no_front_gua1 convertImageUrl]] forState:UIControlStateNormal];
                        [cell.button2 sd_setImageWithURL:[NSURL URLWithString:[self.id_no_reverse_gua1 convertImageUrl]] forState:UIControlStateNormal];
                        cell.button1.tag = 106;
                        cell.button2.tag = 107;
                    }
                }
            }
            
            
//            if (indexPath.section == 2) {
//
//            }
//            if (indexPath.section == 3) {
//
//            }
            
        }
        
        [cell.button1 addTarget:self action:@selector(buttonclick:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.button2 addTarget:self action:@selector(buttonclick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        return cell;
    }
    if (indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 9 || indexPath.row == 10) {
        static NSString *CellIdentifier = @"PhotoCell";
        PhotoCell *cell = [tableView cellForRowAtIndexPath:indexPath]; //根据indexPath准确地取出一行，而不是从cell重用队列中取出
        if (cell == nil) {
            cell = [[PhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        if ([dataDic[@"loanRole"] isEqualToString:@"1"]) {
            if (indexPath.row == 6) {
                if (![self.auth_pdf_apply[0] isEqualToString:@""]) {
                    cell.collectDataArray = self.auth_pdf_apply;
                    
                }
                cell.selectStr = @"征信查询授权书";
            }
            if (indexPath.row == 7) {
                if (![self.interview_pic_apply[0] isEqualToString:@""]) {
                cell.collectDataArray = self.interview_pic_apply;
                }
                 cell.selectStr = @"手持授权书照片";
            }
            if (indexPath.row == 9) {
                if (![self.bank_report_apply[0] isEqualToString:@""]) {
                cell.collectDataArray = self.bank_report_apply;
                }
                cell.selectStr = @"征信报告";
            }
            if (indexPath.row == 10) {
                if (![self.data_report_apply[0] isEqualToString:@""]) {
                cell.collectDataArray = self.data_report_apply;
                }
                cell.selectStr = @"申请人大数据报告";
            }
        }
        if ([dataDic[@"loanRole"] isEqualToString:@"2"]) {
            if (indexPath.row == 6) {
                if (![self.auth_pdf_gh[0] isEqualToString:@""]) {
                cell.collectDataArray = self.auth_pdf_gh;
                }
                cell.selectStr = @"征信查询授权书";
            }
            if (indexPath.row == 7) {
                if (![self.interview_pic_gh[0] isEqualToString:@""]) {
                cell.collectDataArray = self.interview_pic_gh;
                }
                cell.selectStr = @"手持授权书照片";
            }
            if (indexPath.row == 9) {
                if (![self.bank_report_gh[0] isEqualToString:@""]) {
                cell.collectDataArray = self.bank_report_gh;
                }
                cell.selectStr = @"征信报告";
            }
            if (indexPath.row == 10) {
                if (![self.data_report_gh[0] isEqualToString:@""]) {
                cell.collectDataArray = self.data_report_gh;
                }
                cell.selectStr = @"共还人大数据报告";
            }
        }
        if ([dataDic[@"loanRole"] isEqualToString:@"3"]) {
            if ([dataDic[@"isFirstGua"] isEqualToString:@"1"]) {
                if (indexPath.row == 6) {
                    if (![self.auth_pdf_gua[0] isEqualToString:@""]) {
                        cell.collectDataArray = self.auth_pdf_gua;
                    }
                    cell.selectStr = @"征信查询授权书";
                }
                if (indexPath.row == 7) {
                    if (![self.interview_pic_gua[0] isEqualToString:@""]) {
                        cell.collectDataArray = self.interview_pic_gua;
                    }
                    cell.selectStr = @"手持授权书照片";
                }
                if (indexPath.row == 9) {
                    if (![self.bank_report_gua[0] isEqualToString:@""]) {
                        cell.collectDataArray = self.bank_report_gua;
                    }
                    cell.selectStr = @"征信报告";
                }
                if (indexPath.row == 10) {
                    if (![self.data_report_gua[0] isEqualToString:@""]) {
                        cell.collectDataArray = self.data_report_gua;
                    }
                    cell.selectStr = @"担保人大数据报告";
                }
            }
            
            if (![dataDic[@"isFirstGua"] isEqualToString:@"1"]) {
                if (indexPath.row == 6) {
                    if (![self.auth_pdf_gua1[0] isEqualToString:@""]) {
                        cell.collectDataArray = self.auth_pdf_gua1;
                    }
                    cell.selectStr = @"征信查询授权书";
                }
                if (indexPath.row == 7) {
                    if (![self.interview_pic_gua1[0] isEqualToString:@""]) {
                        cell.collectDataArray = self.interview_pic_gua1;
                    }
                    cell.selectStr = @"手持授权书照片";
                }
                if (indexPath.row == 9) {
                    if (![self.bank_report_gua1[0] isEqualToString:@""]) {
                        cell.collectDataArray = self.bank_report_gua1;
                    }
                    cell.selectStr = @"征信报告";
                }
                if (indexPath.row == 10) {
                    if (![self.data_report_gua1[0] isEqualToString:@""]) {
                        cell.collectDataArray = self.data_report_gua1;
                    }
                    cell.selectStr = @"担保人大数据报告";
                }
            }
            
//            if (indexPath.section > 0) {
//                for (int i = 0; i < indexPath.section - 1; i ++) {
//                    if ([self.model.creditUserList[indexPath.section][@"loanRole"] isEqualToString:@"3"]) {
//                        
//                    }
//                }
//            }
            
//            if (indexPath.section == 2) {
//
//            }
//            if (indexPath.section == 3)
            
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

    NSArray *topArray = @[@"姓名",@"与借贷人关系",@"贷款人角色",@"手机号",@"身份证号",@"",@"",@"",@"信用卡使用占比",@"",@"",@"征信报告说明"];
    cell.topLbl.text = topArray[indexPath.row];
    
    NSArray *bottomArray = @[[BaseModel convertNullReturnStr:dataDic[@"userName"]],
                             [[BaseModel user] setParentKey:@"credit_user_relation" setDkey:dataDic[@"relation"]],
                             [[BaseModel user] setParentKey:@"credit_user_loan_role" setDkey:dataDic[@"loanRole"]],
                             [BaseModel convertNullReturnStr:dataDic[@"mobile"]],
                             [BaseModel convertNullReturnStr:dataDic[@"idNo"]],
                             @"",
                             @"",
                             @"",
                             [BaseModel convertNull:[NSString stringWithFormat:@"%.2f",[dataDic[@"creditCardOccupation"] floatValue]]],
                             @"",
                             @"",
                             [BaseModel convertNull:dataDic[@"bankCreditResultRemark"]]];
    cell.bottomLbl.frame = CGRectMake(15, 39, SCREEN_WIDTH - 137, 14);
    cell.bottomLbl.numberOfLines = 0;
    cell.bottomLbl.text = bottomArray[indexPath.row];
    [cell.bottomLbl sizeToFit];
    return cell;
}

-(void)buttonclick:(UIButton *)sender{
    switch (sender.tag) {
        case 100:
            [[BaseModel user]AlterImageByUrl:self.id_no_front_apply];
            break;
        case 101:
            [[BaseModel user]AlterImageByUrl:self.id_no_reverse_apply];
            break;
        case 102:
            [[BaseModel user]AlterImageByUrl:self.id_no_front_gh];
            break;
        case 103:
            [[BaseModel user]AlterImageByUrl:self.id_no_reverse_gh];
            break;
        case 104:
            [[BaseModel user]AlterImageByUrl:self.id_no_front_gua];
            break;
        case 105:
            [[BaseModel user]AlterImageByUrl:self.id_no_reverse_gua];
            break;
        case 106:
            [[BaseModel user]AlterImageByUrl:self.id_no_front_gua1];
            break;
        case 107:
            [[BaseModel user]AlterImageByUrl:self.id_no_reverse_gua1];
            break;
            
        default:
            break;
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
    NSDictionary *dataDic = self.model.creditUserList[indexPath.section];
    
    NSArray *array;
    if ([dataDic[@"loanRole"] isEqualToString:@"1"]) {
        if (indexPath.row == 6) {
            array = self.auth_pdf_apply;
            NSString * str = array[0];
            if (str.length == 0) {
                return 50;
            }
        }
        if (indexPath.row == 7) {
            array = self.interview_pic_apply;
            NSString * str = array[0];
            if (str.length == 0) {
                return 50;
            }
        }
        if (indexPath.row == 9) {
            array = self.bank_report_apply;
            NSString * str = array[0];
            if (str.length == 0) {
                return 50;
            }
        }
        if (indexPath.row == 10) {
            array = self.data_report_apply;
            NSString * str = array[0];
            if (str.length == 0) {
                return 50;
            }
        }
    }
    if ([dataDic[@"loanRole"] isEqualToString:@"2"]) {
        if (indexPath.row == 6) {
            array = self.auth_pdf_gh;
            NSString * str = array[0];
            if (str.length == 0) {
                return 50;
            }
        }
        if (indexPath.row == 7) {
            array = self.interview_pic_gh;
            NSString * str = array[0];
            if (str.length == 0) {
                return 50;
            }
        }
        if (indexPath.row == 9) {
            
            array = self.bank_report_gh;
            NSString * str = array[0];
            if (str.length == 0) {
                return 50;
            }
        }
        if (indexPath.row == 10) {
            array = self.data_report_gh;
            NSString * str = array[0];
            if (str.length == 0) {
                return 50;
            }
        }
    }
    if ([dataDic[@"loanRole"] isEqualToString:@"3"]) {
        if ([dataDic[@"isFirstGua"] isEqualToString:@"1"]) {
            if (indexPath.row == 6) {
                array = self.auth_pdf_gua;
                NSString * str = array[0];
                if (str.length == 0) {
                    return 50;
                }
                
            }
            if (indexPath.row == 7) {
                array = self.interview_pic_gua;
                NSString * str = array[0];
                if (str.length == 0) {
                    return 50;
                }
                
            }
            if (indexPath.row == 9) {
                
                array = self.bank_report_gua;
                NSString * str = array[0];
                if (str.length == 0) {
                    return 50;
                }
            }
            if (indexPath.row == 10) {
                array = self.data_report_gua;
                NSString * str = array[0];
                if (str.length == 0) {
                    return 50;
                }
            }
        }
        if (![dataDic[@"isFirstGua"] isEqualToString:@"1"]) {
            if (indexPath.row == 6) {
                array = self.auth_pdf_gua1;
                NSString * str = array[0];
                if (str.length == 0) {
                    return 50;
                }
                
            }
            if (indexPath.row == 7) {
                array = self.interview_pic_gua1;
                NSString * str = array[0];
                if (str.length == 0) {
                    return 50;
                }
                
            }
            if (indexPath.row == 9) {
                
                array = self.bank_report_gua1;
                NSString * str = array[0];
                if (str.length == 0) {
                    return 50;
                }
            }
            if (indexPath.row == 10) {
                array = self.data_report_gua1;
                NSString * str = array[0];
                if (str.length == 0) {
                    return 50;
                }
            }
        }
        
//        if (indexPath.section >= 0) {
//            for (int i = 0; i < indexPath.section - 1; i ++) {
//                if ([self.model.creditUserList[i][@"loanRole"] isEqualToString:@"3"]) {
//
//        }
//
//    }
//        }
    }
    
    
    if (indexPath.row == 5) {
        return (SCREEN_WIDTH - 107 - 40)/2/210*133 + 47;
    }
    if (indexPath.row == 6) {
       
        float numberToRound;
        int result;
        numberToRound = (array.count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15) + 32;
    }
    if (indexPath.row == 7) {
       
        float numberToRound;
        int result;
        numberToRound = (array.count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ) + 32;
    }
    if (indexPath.row == 9) {

        float numberToRound;
        int result;
        numberToRound = (array.count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ) + 32;
    }
    if (indexPath.row == 10) {
        
        float numberToRound;
        int result;
        numberToRound = (array.count)/3.0;
        result = (int)ceilf(numberToRound);
        return result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ) + 32;
    }
    return _cell.bottomLbl.yy ;
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
        nameLbl.text = @"征信列表";
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
