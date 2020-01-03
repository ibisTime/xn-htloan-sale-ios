#import <UIKit/UIKit.h>

@class CollectionCell1;
@protocol CustomCollectiondelegate <NSObject>
- (void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString*)str;
-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str;
@end
@interface CollectionCell1 : UITableViewCell
@property (nonatomic, assign) id<CustomCollectionDelegate> delegate;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *collectDataArray;
@property (nonatomic , copy)NSString *selectStr;
//@dynamic delegate;
@end
