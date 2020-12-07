//
//  NewLenderCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "NewLenderCell.h"

@implementation NewLenderCell
{
    NSInteger selectTag;
    NSString *idFrontStr;
    NSString *idReverseStr;
    NSString *holdIdCardPdfStr;
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
            NSData *imgData =UIImageJPEGRepresentation(image, 1.0);
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
    
    [SVProgressHUD showWithStatus:@"上传中"];
    if (selectTag == 0) {
        idFrontStr = data;
        TLNetworking *http = [TLNetworking new];
        http.code = @"630092";
        http.showView = self;
        http.parameters[@"picUrl"] = [data convertImageUrl];
        [http postWithSuccess:^(id responseObject) {
            self.idFrontDic = responseObject[@"data"];
            
            self.returnAryBlock1(idFrontStr,self.idFrontDic, idReverseStr,self.idReverseDic, holdIdCardPdfStr);
            UIButton *btn = [self viewWithTag:100];
            [btn sd_setImageWithURL:[NSURL URLWithString:[data convertImageUrl]] forState:(UIControlStateNormal)];
        } failure:^(NSError *error) {
            
        }];
    }
    if (selectTag == 1) {
        idReverseStr = data;
        
        TLNetworking *http = [TLNetworking new];
        http.code = @"630093";
        http.showView = self;
        http.parameters[@"picUrl"] = [data convertImageUrl];
        [http postWithSuccess:^(id responseObject) {
            self.idReverseDic = responseObject[@"data"];
            
            self.returnAryBlock1(idFrontStr,self.idFrontDic, idReverseStr,self.idReverseDic, holdIdCardPdfStr);
            UIButton *btn = [self viewWithTag:101];
            [btn sd_setImageWithURL:[NSURL URLWithString:[data convertImageUrl]] forState:(UIControlStateNormal)];
        } failure:^(NSError *error) {
            
        }];
    }
    if (selectTag == 2) {
        holdIdCardPdfStr = data;
        self.returnAryBlock1(idFrontStr,self.idFrontDic, idReverseStr,self.idReverseDic, holdIdCardPdfStr);
        UIButton *btn = [self viewWithTag:102];
        [btn sd_setImageWithURL:[NSURL URLWithString:[data convertImageUrl]] forState:(UIControlStateNormal)];
    }
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UILabel *leftLbl = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:@"*资料上传"];
        _leftLbl = leftLbl;
        [attriStr addAttribute:NSForegroundColorAttributeName value:kHexColor(@"#F56A6A") range:NSMakeRange(0, 1)];
        leftLbl.attributedText = attriStr;
        [self addSubview:leftLbl];
        [leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(14.5);
            make.width.mas_equalTo(95);
            make.height.mas_equalTo(16.5);
        }];
        
        NSArray *ary = @[@"身份证正面",@"身份证反面",@"人证照片"];
        for (int i = 0; i < 3; i ++) {
            UIButton *photoBtn = [UIButton buttonWithImageName:@""];
            photoBtn.frame = CGRectMake(15 + i % 3 * ((SCREEN_WIDTH - 45)/3 + 7.5), 41, (SCREEN_WIDTH - 45)/3, 82.5);
            [photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            photoBtn.tag = 100 + i;
            [self addSubview:photoBtn];
            
            UIButton *selectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
            selectButton.frame = CGRectMake(photoBtn.width - 30, 0, 30, 30);
//            _selectButton = selectButton;
            [selectButton setImage:HGImage(@"删除") forState:(UIControlStateNormal)];
            [selectButton addTarget:self action:@selector(selectButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
            selectButton.tag = 5000 + i;
            selectButton.hidden = YES;
            [photoBtn addSubview:selectButton];
            
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(photoBtn.x, photoBtn.yy + 7, photoBtn.width, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
            nameLbl.text = ary[i];
            [self addSubview:nameLbl];
        }
        
    }
    return self;
}

-(void)selectButtonClick:(UIButton *)sender
{
    if (_isDetails == YES) {
        return;
    }
    switch (sender.tag - 5000) {
        case 0:
        {
            idFrontStr = @"";
//            self.idFrontDic = @{};
            self.returnAryBlock1(idFrontStr,self.idFrontDic, idReverseStr,self.idReverseDic, holdIdCardPdfStr);
        }
            break;
        case 1:
        {
            idReverseStr = @"";
//            self.idReverseDic = @{};
            self.returnAryBlock1(idFrontStr,self.idFrontDic, idReverseStr,self.idReverseDic, holdIdCardPdfStr);
        }
            break;
        case 2:
        {
            holdIdCardPdfStr = @"";
            self.returnAryBlock1(idFrontStr,self.idFrontDic, idReverseStr,self.idReverseDic, holdIdCardPdfStr);
        }
            break;
        default:
            break;
    }
}

-(void)setIsDetails:(BOOL)isDetails
{
    _isDetails = isDetails;
    if (isDetails == YES) {
        UIButton *btn = [self viewWithTag:100];
        UIButton *btn1 = [self viewWithTag:101];
        UIButton *btn2 = [self viewWithTag:102];
        [btn setImage:kImage(@"") forState:(UIControlStateNormal)];
        [btn1 setImage:kImage(@"") forState:(UIControlStateNormal)];
        [btn2 setImage:kImage(@"") forState:(UIControlStateNormal)];
        UIButton *selectButton = [self viewWithTag:5000];
        UIButton *selectButton1 = [self viewWithTag:5001];
        UIButton *selectButton2 = [self viewWithTag:5002];
        [selectButton setImage:kImage(@"") forState:(UIControlStateNormal)];
        [selectButton1 setImage:kImage(@"") forState:(UIControlStateNormal)];
        [selectButton2 setImage:kImage(@"") forState:(UIControlStateNormal)];
    }
}

-(void)setIdFront:(NSString *)idFront
{
    _idFront = idFront;
    
    UIButton *selectButton = [self viewWithTag:5000];
    selectButton.hidden = YES;
//    if (_isDetails == NO) {
//        <#statements#>
//    }
//    if ([idFront isEqualToString:@""]) {
//        return;
//    }
//    if ([BaseModel isBlankString:idFrontStr] == NO) {
//        return;
//    }
    if (![idFront isEqualToString:@""]) {
        selectButton.hidden = NO;
    }
    
    idFrontStr = idFront;
    UIButton *btn = [self viewWithTag:100];
    if (_isDetails == YES) {
        [btn sd_setImageWithURL:[NSURL URLWithString:[idFront convertImageUrl]] forState:(UIControlStateNormal) placeholderImage:kImage(@"")];
    }else
    {
        [btn sd_setImageWithURL:[NSURL URLWithString:[idFront convertImageUrl]] forState:(UIControlStateNormal) placeholderImage:kImage(@"资料上传")];
    }
    
}

-(void)setIdReverse:(NSString *)idReverse
{
    _idReverse = idReverse;
    UIButton *selectButton = [self viewWithTag:5001];
    selectButton.hidden = YES;
//    if ([idReverse isEqualToString:@""]) {
//        return;
//    }
//    if ([BaseModel isBlankString:idReverseStr] == NO) {
//        return;
//    }
//
    if (![idReverse isEqualToString:@""]) {
        selectButton.hidden = NO;
    }
//    selectButton.hidden = NO;
    UIButton *btn = [self viewWithTag:101];
    idReverseStr = idReverse;
    if (_isDetails == YES) {
        [btn sd_setImageWithURL:[NSURL URLWithString:[idReverse convertImageUrl]] forState:(UIControlStateNormal) placeholderImage:kImage(@"")];
    }else
    {
        [btn sd_setImageWithURL:[NSURL URLWithString:[idReverse convertImageUrl]] forState:(UIControlStateNormal) placeholderImage:kImage(@"资料上传")];
    }
    
}

-(void)setHoldIdCardPdf:(NSString *)holdIdCardPdf
{
    _holdIdCardPdf = holdIdCardPdf;
    
    UIButton *selectButton = [self viewWithTag:5002];
    selectButton.hidden = YES;
    if (![holdIdCardPdf isEqualToString:@""]) {
        selectButton.hidden = NO;
    }

    
    holdIdCardPdfStr = holdIdCardPdf;
    UIButton *btn = [self viewWithTag:102];
    if (_isDetails == YES) {
        [btn sd_setImageWithURL:[NSURL URLWithString:[holdIdCardPdf convertImageUrl]] forState:(UIControlStateNormal) placeholderImage:kImage(@"")];
    }else
    {
        [btn sd_setImageWithURL:[NSURL URLWithString:[holdIdCardPdf convertImageUrl]] forState:(UIControlStateNormal) placeholderImage:kImage(@"资料上传")];
    }
}

-(void)photoBtnClick:(UIButton *)sender
{
    
    selectTag = sender.tag - 100;
    if (selectTag == 0) {
        if ([_idFront isEqualToString:@""]) {
            if (self.isDetails == YES) {
                return;
            }
            [self.imagePicker picker];
        }else
        {
            NSArray *ary = @[[_idFront convertImageUrl]];
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0  imagesBlock:^NSArray *{
                return ary;
            }];
        }
    }
    if (selectTag == 1) {
        if ([_idReverse isEqualToString:@""] ) {
            if (self.isDetails == YES) {
                return;
            }
            [self.imagePicker picker];
        }else
        {
            NSArray *ary = @[[_idReverse convertImageUrl]];
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0  imagesBlock:^NSArray *{
                return ary;
            }];
        }
    }
    if (selectTag == 2) {
        if ([_holdIdCardPdf isEqualToString:@""]) {
            if (self.isDetails == YES) {
                return;
            }
            [self.imagePicker picker];
        }else
        {
            NSArray *ary = @[[_holdIdCardPdf convertImageUrl]];
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            [ImageBrowserViewController show:window.rootViewController type:PhotoBroswerVCTypeModal index:0  imagesBlock:^NSArray *{
                return ary;
            }];
        }
    }
}

@end
