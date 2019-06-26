//
//  UpdateBrandTableView.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/6/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "TLTableView.h"
#import "CollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface UpdateBrandTableView : TLTableView<UITableViewDelegate,UITableViewDataSource,CustomCollectionDelegate>
@property (nonatomic,strong) NSMutableArray * brandlogo;
@end

NS_ASSUME_NONNULL_END
