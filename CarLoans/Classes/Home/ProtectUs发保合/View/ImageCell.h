//
//  ImageCell.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/6/10.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ImageCellDelegate <NSObject>
- (void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString*)str;
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str;
@end
@interface ImageCell : UITableViewCell
@property (nonatomic, assign) id<CustomCollectionDelegate> delegate;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *collectDataArray;
@property (nonatomic , copy)NSString *selectStr;
@property (nonatomic , strong)UILabel *topLbl;
@end

NS_ASSUME_NONNULL_END
