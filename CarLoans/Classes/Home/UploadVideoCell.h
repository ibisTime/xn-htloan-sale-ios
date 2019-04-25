//
//  UploadVideoCell.h
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCollectionDelegate1 <NSObject>

- (void)CustomCollection:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath str:(NSString*)str;

-(void)UploadImagesBtn:(UIButton *)sender str:(NSString *)str;

@end

@interface UploadVideoCell : UITableViewCell


@property (nonatomic, assign) id<CustomCollectionDelegate1> delegate;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSArray *collectDataArray;
@property (nonatomic , copy)NSString *selectStr;
//是否允许编辑
@property (nonatomic , assign)BOOL isEditor;

@end
