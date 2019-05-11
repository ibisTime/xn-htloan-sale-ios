//
//  AddFilesTableView.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/11.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddFilesTableView : TLTableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * fileCount;
@property (nonatomic,strong) NSString * remark;
@end

NS_ASSUME_NONNULL_END
