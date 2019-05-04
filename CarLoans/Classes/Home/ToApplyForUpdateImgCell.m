//
//  ToApplyForUpdateImgCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/4/29.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ToApplyForUpdateImgCell.h"



@interface ToApplyForUpdateImgCell () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UIButton *photoBtn;
    
}
@property (nonatomic , strong)TLImagePicker *imagePicker;
@property (nonatomic , strong)UICollectionView *collectionView;


@end
@implementation ToApplyForUpdateImgCell


- (TLImagePicker *)imagePicker {
    if (!_imagePicker) {
        ProjectWeakSelf;
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        _imagePicker = [[TLImagePicker alloc] initWithVC:window.rootViewController];
        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
            TLUploadManager *manager = [TLUploadManager manager];
            manager.imgData = imgData;
            manager.image = image;
            
            [manager getTokenShowView:weakSelf succes:^(NSString *key) {
                WGLog(@"%@",key);
                [weakSelf setImage:image setData:key];
            } failure:^(NSError *error) {
            }];
        };
    }
    return _imagePicker;
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    [_muArray addObject:data];
    [self.collectionView reloadData];
    [self CustomBlock];
}


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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 32, SCREEN_WIDTH - 107, (SCREEN_WIDTH - 107 - 45)/3 + 15) collectionViewLayout:layout];
//        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.contentView addSubview:self.collectionView];
        
        _muArray = [NSMutableArray array];
//        NSLog(@"%@",self.collectDataArray);
    }
    return self;
}


-(void)setMuArray:(NSMutableArray *)muArray
{
    _muArray = muArray;
    float numberToRound;
    int result;
    numberToRound = (_muArray.count + 1.0)/3.0;
    result = (int)ceilf(numberToRound);
    _collectionView.frame = CGRectMake(0, 32, SCREEN_WIDTH - 107, result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ));
    
//    [_muArray addObjectsFromArray:_muArray];
    [self.collectionView reloadData];
}


#pragma mark -- Collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _muArray.count + 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.row == 0) {
        photoBtn = [UIButton buttonWithTitle:@"" titleColor:GaryTextColor backgroundColor:BackColor titleFont:13];
        photoBtn.frame = CGRectMake(0, 0, (SCREEN_WIDTH - 107 - 45)/3, (SCREEN_WIDTH - 107 - 45)/3);
        kViewBorderRadius(photoBtn, 5, 1, HGColor(230, 230, 230));
        [photoBtn setTitle:@"上传" forState:(UIControlStateNormal)];
        [photoBtn SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:5 imagePositionBlock:^(UIButton *button) {
            [button setImage:[UIImage imageNamed:@"添加"] forState:(UIControlStateNormal)];
        }];
        [cell addSubview:photoBtn];
        
        UIView *backView = [[UIView alloc]initWithFrame:cell.frame];
        [cell addSubview:backView];
    }
    else
    {
        UIImageView *image = [[UIImageView alloc]initWithFrame: CGRectMake(0, 0, (SCREEN_WIDTH - 107 - 45)/3, (SCREEN_WIDTH - 107 - 45)/3)];
        kViewBorderRadius(image, 5, 1, HGColor(230, 230, 230));
        [image sd_setImageWithURL:[NSURL URLWithString:[_muArray[indexPath.row - 1] convertImageUrl]]];
        [cell addSubview:image];
        
        UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        selectButton.frame = CGRectMake((SCREEN_WIDTH - 107 - 45)/3 - 30, 0, 30, 30);
        [selectButton setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
        [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        selectButton.tag = indexPath.row - 1 + 1000;
        [cell addSubview:selectButton];
    }
    return cell;
}

-(void)selectButtonClick:(UIButton *)sender
{
    [_muArray removeObjectAtIndex:sender.tag - 1000];
    [self CustomBlock];
}

-(void)setName:(NSString *)name
{
    _name = name;
    self.topLbl.text = name;
}


-(void)CustomBlock
{
    NSArray *array = _muArray;
    self.returnAryBlock(array, _name);
    
    
    float numberToRound;
    int result;
    numberToRound = (_muArray.count + 1.0)/3.0;
    result = (int)ceilf(numberToRound);
    _collectionView.frame = CGRectMake(0, 32, SCREEN_WIDTH - 107, result * ((SCREEN_WIDTH - 107 - 45)/3 + 15 ));
    [self.collectionView reloadData];
}


#pragma mark -- Collection delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"点击了 %ld ", indexPath.row);
    if (indexPath.row == 0) {
        [self.imagePicker picker];
    }else
    {
        NSMutableArray *muArray = [NSMutableArray array];
        for (int i = 0; i < _muArray.count; i++) {
            [muArray addObject:[_muArray[i] convertImageUrl]];
        }
        NSArray *seleteArray = muArray;
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:indexPath.row - 1 imagesBlock:^NSArray *{
            return seleteArray;
        }];
    }
}

@end