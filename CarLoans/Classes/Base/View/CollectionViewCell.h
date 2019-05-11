//
//  CollectionViewCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewCell.h"

@protocol CustomCollectiondelegate <NSObject>

- (void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString*)str;

-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str;

@end


@interface CollectionViewCell : UITableViewCell

@property (nonatomic, assign) id<CustomCollectionDelegate> delegate;
@property (nonatomic,strong)UICollectionView *collectionView;
//图片数组
@property (nonatomic,strong)NSArray *collectDataArray;
//标题
@property (nonatomic , copy)NSString *selectStr;
@property (nonatomic,strong) NSString * title;
//是否允许编辑
@property (nonatomic , assign)BOOL isEditor;


@end
