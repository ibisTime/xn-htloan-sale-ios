//
//  PhotoCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/17.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "PhotoCell.h"


@interface PhotoCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UIButton *photoBtn;
    NSArray *array;
}
@end
@implementation PhotoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        
        UILabel *topLbl = [UILabel labelWithFrame:CGRectMake(15, 23, SCREEN_WIDTH - 107 - 30, 14) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(11) textColor:kHexColor(@"#999999")];
        self.topLbl = topLbl;
        
        [self addSubview:topLbl];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 107 - 45)/3  , (SCREEN_WIDTH - 107 - 45)/3);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH - 107, 0) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.contentView addSubview:self.collectionView];
        NSLog(@"%@",self.collectDataArray);
    }
    return self;
}

-(void)setCollectDataArray:(NSArray *)collectDataArray
{
    array = collectDataArray;
    float numberToRound;
    int result;
    numberToRound = (array.count + 0.0)/3.0;
    result = (int)ceilf(numberToRound);
    _collectionView.frame = CGRectMake(0, 32, SCREEN_WIDTH - 107, result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ));
    [self.collectionView reloadData];
}


#pragma mark -- Collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return array.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *image = [[UIImageView alloc]initWithFrame: cell.bounds];
    kViewBorderRadius(image, 5, 1, HGColor(230, 230, 230));
    image.image = kImage(@"默认");
    
//    if ([array[indexPath.row] hasPrefix:@"http"]) {
//        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",array[indexPath.row]]]];
//    }else
//    {
//        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[array[indexPath.row] convertImageUrl]]]];
//    }
    [cell addSubview:image];
    return cell;
}


-(void)setSelectStr:(NSString *)selectStr
{
    _selectStr = selectStr;
    self.topLbl.text = selectStr;
}


#pragma mark -- Collection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了 %ld ", indexPath.row);
    NSMutableArray *muArray = [NSMutableArray array];
    for (int i = 0; i < array.count; i++) {
        [muArray addObject:[array[i] convertImageUrl]];
    }
    NSArray *seleteArray = muArray;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:indexPath.row imagesBlock:^NSArray *{
        return seleteArray;
    }];
}

-(void)selectButtonClick:(UIButton *)sender
{
    [_delegate UploadImagesBtn:sender str:_selectStr];
}

@end
