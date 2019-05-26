//
//  SignVideoTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "UploadVideoCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface SignVideoTableView : TLTableView<UITableViewDataSource,UITableViewDelegate,CustomCollectionDelegate,CustomCollectiondelegate1>
@property (nonatomic,strong) NSMutableArray * array;
//银行视频
@property (nonatomic , strong)NSArray *BankVideoArray;
//公司视频
@property (nonatomic , strong)NSArray *CompanyVideoArray;
//身份证正面
@property (nonatomic,strong) NSArray * idfront;
//身份证反面
@property (nonatomic,strong) NSArray * idreverse;
@end

NS_ASSUME_NONNULL_END
