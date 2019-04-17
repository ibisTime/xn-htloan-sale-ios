//
//  AddGPSInstallationTableView.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/3.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

@interface AddGPSInstallationTableView : TLTableView
//安装图片
@property (nonatomic , strong)NSArray *BankPicArray;
//其他图片
@property (nonatomic , strong)NSArray *CompanyPicArray;
@property (nonatomic  , copy)NSString *GPS;

@property (nonatomic  , copy)NSString *date;

@property (nonatomic , assign)NSInteger isSelect;
@property (nonatomic  , copy)NSString *Str1;
@property (nonatomic  , copy)NSString *Str2;
@property (nonatomic  , copy)NSString *Str3;

@end