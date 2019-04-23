//
//  PhotoCell.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CustomCollectionDelegate <NSObject>
- (void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString*)str;
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str;
@end
@interface PhotoCell : UITableViewCell

@property (nonatomic, assign) id<CustomCollectionDelegate> delegate;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *collectDataArray;
@property (nonatomic , copy)NSString *selectStr;
@property (nonatomic , strong)UILabel *topLbl;
@end

NS_ASSUME_NONNULL_END

