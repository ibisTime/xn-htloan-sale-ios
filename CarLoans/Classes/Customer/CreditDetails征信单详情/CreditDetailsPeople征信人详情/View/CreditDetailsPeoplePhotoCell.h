//
//  CreditDetailsPeoplePhotoCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/18.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreditDetailsPeoplePhotoCell : UITableViewCell
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *collectDataArray;
@property (nonatomic , copy)NSString *selectStr;
@property (nonatomic , strong)UILabel *topLbl;
@end

NS_ASSUME_NONNULL_END
