//
//  MaterialsUploadedCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/27.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MaterialsUploadedCell.h"

@implementation MaterialsUploadedCell
{
    NSInteger selectTag;
}
- (TLImagePicker *)imagePicker {
    
    if (!_imagePicker) {
        CarLoansWeakSelf;
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        _imagePicker = [[TLImagePicker alloc] initWithVC:window.rootViewController];
        
        _imagePicker.allowsEditing = YES;
        _imagePicker.pickFinish = ^(NSDictionary *info){
            NSLog(@"%@",info);
            UIImage *image = info[@"UIImagePickerControllerOriginalImage"];
            NSData *imgData = UIImageJPEGRepresentation(image, 0.8);
            [SVProgressHUD showWithStatus:@"上传中"];
            //进行上传
            TLUploadManager *manager = [TLUploadManager manager];
            
            manager.imgData = imgData;
            manager.image = image;
            [manager getTokenShowView:weakSelf succes:^(NSString *key) {
                WGLog(@"%@",key);
                [weakSelf setImage:image setData:key];
            } failure:^(NSError *error) {
                [TLAlert alertWithInfo:@"上传失败"];
            }];
        };
    }
    return _imagePicker;
}

-(void)setImage:(UIImage *)image setData:(NSString *)data
{
    if (selectTag == 100) {
        self.driveCard = data;
    }
    if (selectTag == 101) {
        self.marryPdf = data;
    }
    if (selectTag == 102) {
        self.divorcePdf = data;
    }
    if (selectTag == 103) {
        self.singleProve = data;
    }
    if (selectTag == 104) {
        self.incomeProve = data;
    }
    if (selectTag == 105) {
        self.liveProvePdf = data;
    }
    if (selectTag == 106) {
        self.housePropertyCardPdf = data;
    }
    self.dataUploadBlock(_driveCard, _marryPdf, _divorcePdf, _singleProve, _incomeProve, _liveProvePdf, _housePropertyCardPdf);
}

-(void)setDriveCard:(NSString *)driveCard
{
    _driveCard = driveCard;
    if ([BaseModel isBlankString:driveCard] == YES) {
        return;
    }
    if ([driveCard isEqualToString:@""]) {
        return;
    }
    UIButton *btn = [self viewWithTag:100];
    [btn sd_setImageWithURL:[NSURL URLWithString:[driveCard convertImageUrl]] forState:(UIControlStateNormal)];
}

-(void)setMarryPdf:(NSString *)marryPdf
{
    _marryPdf = marryPdf;
    if ([BaseModel isBlankString:marryPdf] == YES) {
        return;
    }
    if ([marryPdf isEqualToString:@""]) {
        return;
    }
    UIButton *btn = [self viewWithTag:101];
    [btn sd_setImageWithURL:[NSURL URLWithString:[marryPdf convertImageUrl]] forState:(UIControlStateNormal)];
}

-(void)setDivorcePdf:(NSString *)divorcePdf
{
    _divorcePdf = divorcePdf;
    if ([BaseModel isBlankString:divorcePdf] == YES) {
        return;
    }
    if ([divorcePdf isEqualToString:@""]) {
        return;
    }
    UIButton *btn = [self viewWithTag:102];
    [btn sd_setImageWithURL:[NSURL URLWithString:[divorcePdf convertImageUrl]] forState:(UIControlStateNormal)];
}

-(void)setSingleProve:(NSString *)singleProve
{
    _singleProve = singleProve;
    if ([BaseModel isBlankString:singleProve] == YES) {
        return;
    }
    if ([singleProve isEqualToString:@""]) {
        return;
    }
    UIButton *btn = [self viewWithTag:103];
    [btn sd_setImageWithURL:[NSURL URLWithString:[singleProve convertImageUrl]] forState:(UIControlStateNormal)];
}

-(void)setIncomeProve:(NSString *)incomeProve
{
    _incomeProve = incomeProve;
    if ([BaseModel isBlankString:incomeProve] == YES) {
        return;
    }
    if ([incomeProve isEqualToString:@""]) {
        return;
    }
    UIButton *btn = [self viewWithTag:104];
    [btn sd_setImageWithURL:[NSURL URLWithString:[incomeProve convertImageUrl]] forState:(UIControlStateNormal)];
}

-(void)setLiveProvePdf:(NSString *)liveProvePdf
{
    _liveProvePdf = liveProvePdf;
    if ([BaseModel isBlankString:liveProvePdf] == YES) {
        return;
    }
    if ([liveProvePdf isEqualToString:@""]) {
        return;
    }
    UIButton *btn = [self viewWithTag:105];
    [btn sd_setImageWithURL:[NSURL URLWithString:[liveProvePdf convertImageUrl]] forState:(UIControlStateNormal)];
}

-(void)setHousePropertyCardPdf:(NSString *)housePropertyCardPdf
{
    _housePropertyCardPdf = housePropertyCardPdf;
    if ([BaseModel isBlankString:housePropertyCardPdf] == YES) {
        return;
    }
    if ([housePropertyCardPdf isEqualToString:@""]) {
        return;
    }
    UIButton *btn = [self viewWithTag:106];
    [btn sd_setImageWithURL:[NSURL URLWithString:[housePropertyCardPdf convertImageUrl]] forState:(UIControlStateNormal)];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UILabel *leftLbl = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
//        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:@"资料上传"];
//        [attriStr addAttribute:NSForegroundColorAttributeName value:kHexColor(@"#F56A6A") range:NSMakeRange(0, 1)];
        leftLbl.text = @"资料上传";
        [self addSubview:leftLbl];
        [leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(14.5);
            make.width.mas_equalTo(95);
            make.height.mas_equalTo(16.5);
        }];
        
        NSArray *ary = @[@"驾驶证",@"结婚证",@"离婚证",@"单身证明",@"收入证明",@"居住证",@"产权证内容页"];
        for (int i = 0; i < 7; i ++) {
            UIButton *photoBtn = [UIButton buttonWithImageName:@"资料上传"];
            photoBtn.frame = CGRectMake(15 + i % 3 * ((SCREEN_WIDTH - 45)/3 + 7.5), 41 + i / 3 * 121, (SCREEN_WIDTH - 45)/3, 82.5);
            photoBtn.tag = 100 + i;
            [photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:photoBtn];
            
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(photoBtn.x, photoBtn.yy + 7, photoBtn.width, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
            nameLbl.text = ary[i];
            [self addSubview:nameLbl];
        }
        
    }
    return self;
}

-(void)setIsDetails:(BOOL)isDetails
{
    _isDetails = isDetails;
    if (isDetails == YES) {
        UIButton *btn = [self viewWithTag:100];
        UIButton *btn1 = [self viewWithTag:101];
        UIButton *btn2 = [self viewWithTag:102];
        UIButton *btn3 = [self viewWithTag:103];
        UIButton *btn4 = [self viewWithTag:104];
        UIButton *btn5 = [self viewWithTag:105];
        UIButton *btn6 = [self viewWithTag:106];
        [btn setImage:kImage(@"") forState:(UIControlStateNormal)];
        [btn1 setImage:kImage(@"") forState:(UIControlStateNormal)];
        [btn2 setImage:kImage(@"") forState:(UIControlStateNormal)];
        [btn3 setImage:kImage(@"") forState:(UIControlStateNormal)];
        [btn4 setImage:kImage(@"") forState:(UIControlStateNormal)];
        [btn5 setImage:kImage(@"") forState:(UIControlStateNormal)];
        [btn6 setImage:kImage(@"") forState:(UIControlStateNormal)];
    }
}

-(void)photoBtnClick:(UIButton *)sender
{
    if (_isDetails == YES) {
        
        
//        @property (nonatomic , strong)NSString *driveCard;
//        @property (nonatomic , strong)NSString *marryPdf;
//        @property (nonatomic , strong)NSString *divorcePdf;
//        @property (nonatomic , strong)NSString *singleProve;
//        @property (nonatomic , strong)NSString *incomeProve;
//
//        @property (nonatomic , strong)NSString *liveProvePdf;
//        @property (nonatomic , strong)NSString *housePropertyCardPdf;
//
        if (sender.tag == 100) {
            if ([BaseModel isBlankString:_driveCard] == YES) {
                return;
            }
            if ([_driveCard isEqualToString:@""]) {
                return;
            }
            NSArray *ary = @[[_driveCard convertImageUrl]];
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                return ary;
            }];
        }
        if (sender.tag == 101) {
            if ([BaseModel isBlankString:_marryPdf] == YES) {
                return;
            }
            if ([_marryPdf isEqualToString:@""]) {
                return;
            }
            NSArray *ary = @[[_marryPdf convertImageUrl]];
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                return ary;
            }];
        }
        if (sender.tag == 102) {
            if ([BaseModel isBlankString:_divorcePdf] == YES) {
                return;
            }
            if ([_divorcePdf isEqualToString:@""]) {
                return;
            }
            NSArray *ary = @[[_divorcePdf convertImageUrl]];
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                return ary;
            }];
        }
        if (sender.tag == 103) {
            if ([BaseModel isBlankString:_singleProve] == YES) {
                return;
            }
            if ([_singleProve isEqualToString:@""]) {
                return;
            }
            NSArray *ary = @[[_singleProve convertImageUrl]];
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                return ary;
            }];
        }
        if (sender.tag == 104) {
            if ([BaseModel isBlankString:_incomeProve] == YES) {
                return;
            }
            if ([_incomeProve isEqualToString:@""]) {
                return;
            }
            NSArray *ary = @[[_incomeProve convertImageUrl]];
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                return ary;
            }];
        }
        if (sender.tag == 105) {
            if ([BaseModel isBlankString:_liveProvePdf] == YES) {
                return;
            }
            if ([_liveProvePdf isEqualToString:@""]) {
                return;
            }
            NSArray *ary = @[[_liveProvePdf convertImageUrl]];
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                return ary;
            }];
        }
        if (sender.tag == 106) {
            if ([BaseModel isBlankString:_housePropertyCardPdf] == YES) {
                return;
            }
            if ([_housePropertyCardPdf isEqualToString:@""]) {
                return;
            }
            NSArray *ary = @[[_housePropertyCardPdf convertImageUrl]];
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0 imagesBlock:^NSArray *{
                return ary;
            }];
        }
        
        
    }
    selectTag = sender.tag;
    [self.imagePicker picker];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
