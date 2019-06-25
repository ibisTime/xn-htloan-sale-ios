//
//  CollectionViewCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/8/2.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UIButton *photoBtn;
    NSArray *array;
}
@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.minimumInteritemSpacing = 0;
//        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 50)/3  , (SCREEN_WIDTH - 50)/3);
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        float numberToRound;
        int result;
        self.isEditor = YES;
        numberToRound = (array.count + 1.0)/3.0;
        result = (int)ceilf(numberToRound);
        NSLog(@"roundf(%.2f) = %d", numberToRound, result);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH - 20, result * ((SCREEN_WIDTH - 50)/3 + 10)) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];

        //注册cell
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:self.collectionView];
        NSLog(@"%@",self.collectDataArray);
    }
    return self;
}

-(void)setIsEditor:(BOOL)isEditor
{
    _isEditor = isEditor;
}

-(void)setCollectDataArray:(NSArray *)collectDataArray
{
    
    array = collectDataArray;
    float numberToRound;
    int result;
    if (_isEditor == NO) {
        numberToRound = (array.count )/3.0;
    }else
    {
        numberToRound = (array.count + 1.0)/3.0;
    }
    result = (int)ceilf(numberToRound);
    _collectionView.frame = CGRectMake(10, 5, SCREEN_WIDTH - 20, result * ((SCREEN_WIDTH - 50)/3 + 10));
    [self.collectionView reloadData];

}

#pragma mark -- Collection delegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.isEditor == NO) {
        return array.count;
    }
    return array.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    
    if (self.isEditor == NO) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        UIImageView *image = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, (SCREEN_WIDTH - 50)/3, (SCREEN_WIDTH - 50)/3)];
        kViewBorderRadius(image, 5, 1, HGColor(230, 230, 230));
        [image sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@", array[indexPath.row]] convertImageUrl]]];
        [cell addSubview:image];
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0) {
        photoBtn = [UIButton buttonWithTitle:@"" titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
        photoBtn.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 50)/3, (SCREEN_WIDTH - 50)/3);
        kViewBorderRadius(photoBtn, 5, 1, HGColor(230, 230, 230));
        [photoBtn setTitle:@"上传" forState:(UIControlStateNormal)];
        [photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:10 imagePositionBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        }];
        [cell addSubview:photoBtn];

        UIView *backView = [[UIView alloc]initWithFrame:cell.frame];
        [cell addSubview:backView];
    }
    else
    {
        if (array.count > 0) {
            UIImageView *image = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, (SCREEN_WIDTH - 50)/3, (SCREEN_WIDTH - 50)/3)];
            kViewBorderRadius(image, 5, 1, HGColor(230, 230, 230));
            [image sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@", array[indexPath.row - 1]] convertImageUrl]]];
            [cell addSubview:image];
            
            UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            selectButton.frame = CGRectMake((SCREEN_WIDTH - 50)/3 - 40, 0, 40, 40);
            [selectButton setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
            [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            selectButton.tag = indexPath.row - 1 + 1000;
            [cell addSubview:selectButton];
        }
        
    }
    return cell;
}



-(void)setSelectStr:(NSString *)selectStr
{
    _selectStr = selectStr;
}

#pragma mark -- Collection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isEditor == NO) {
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 0; i < array.count; i ++) {
            [imageArray addObject:[array[i] convertImageUrl]];
        }
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:indexPath.row imagesBlock:^NSArray *{
            return imageArray;
        }];
    }
    NSLog(@"点击了 %ld ", indexPath.row);
    if (indexPath.row == 0) {
        if([self.delegate respondsToSelector:@selector(CustomCollection:didSelectRowAtIndexPath:str:)]){
            [self.delegate CustomCollection:collectionView didSelectRowAtIndexPath:indexPath str:_selectStr];
        }
    }else
    {
        NSMutableArray *imageArray = [NSMutableArray array];
        for (int i = 0; i < array.count; i ++) {
            [imageArray addObject:[[NSString stringWithFormat:@"%@", array[i]] convertImageUrl]];
        }
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:indexPath.row - 1 imagesBlock:^NSArray *{
            return imageArray;
        }];
    }
    
}

-(void)selectButtonClick:(UIButton *)sender
{
    [_delegate UploadImagesBtn:sender str:_selectStr];
}

@end
