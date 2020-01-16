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
            UIButton *photoBtn = [UIButton buttonWithImageName:@"资料上传"];
            photoBtn.frame = CGRectMake(15 + i % 3 * ((SCREEN_WIDTH - 45)/3 + 7.5), 41, (SCREEN_WIDTH - 45)/3, 82.5);
            [photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            photoBtn.tag = 100 + i;
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
        [btn setImage:kImage(@"") forState:(UIControlStateNormal)];
        [btn1 setImage:kImage(@"") forState:(UIControlStateNormal)];
        [btn2 setImage:kImage(@"") forState:(UIControlStateNormal)];
    }
}

-(void)setIdFront:(NSString *)idFront
{
    if ([idFront isEqualToString:@""]) {
        return;
    }
    if ([BaseModel isBlankString:idFrontStr] == NO) {
        return;
    }
    idFrontStr = idFront;
    UIButton *btn = [self viewWithTag:100];
    [btn sd_setImageWithURL:[NSURL URLWithString:[idFront convertImageUrl]] forState:(UIControlStateNormal)];
}

-(void)setIdReverse:(NSString *)idReverse
{
    if ([idReverse isEqualToString:@""]) {
        return;
    }
    if ([BaseModel isBlankString:idReverseStr] == NO) {
        return;
    }
    idReverseStr = idReverse;
    UIButton *btn = [self viewWithTag:101];
    [btn sd_setImageWithURL:[NSURL URLWithString:[idReverse convertImageUrl]] forState:(UIControlStateNormal)];
}

-(void)setHoldIdCardPdf:(NSString *)holdIdCardPdf
{
    if ([holdIdCardPdf isEqualToString:@""]) {
        return;
    }
    if ([BaseModel isBlankString:holdIdCardPdfStr] == NO) {
        return;
    }
    holdIdCardPdfStr = holdIdCardPdf;
    UIButton *btn = [self viewWithTag:102];
    [btn sd_setImageWithURL:[NSURL URLWithString:[holdIdCardPdf convertImageUrl]] forState:(UIControlStateNormal)];
}

-(void)photoBtnClick:(UIButton *)sender
{
    if (self.isDetails == YES) {
        return;
    }
    selectTag = sender.tag - 100;
    [self.imagePicker picker];
}

@end
