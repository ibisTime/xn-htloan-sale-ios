//
//  VehicleLicenseCell.m
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/17.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "VehicleLicenseCell.h"

@implementation VehicleLicenseCell
{
    UIButton *photoBtn;
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
    NSMutableArray *ary = [NSMutableArray array];
    [ary addObject:data];
    _collectDataArray = ary;
    self.returnAryBlock(ary, @"行驶证", 0);
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UILabel *leftLbl = [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        //        NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:@"资料上传"];
        //        [attriStr addAttribute:NSForegroundColorAttributeName value:kHexColor(@"#F56A6A") range:NSMakeRange(0, 1)];
        leftLbl.text = @"行驶证";
        [self addSubview:leftLbl];
        [leftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(14.5);
            make.width.mas_equalTo(95);
            make.height.mas_equalTo(16.5);
        }];
        
        photoBtn = [UIButton buttonWithImageName:@"资料上传"];
        photoBtn.frame = CGRectMake(15 , 41, (SCREEN_WIDTH - 45)/3, 82.5);
        photoBtn.tag = 100;
        [photoBtn addTarget:self action:@selector(photoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:photoBtn];
        
        
        
    }
    return self;
}

-(void)setCollectDataArray:(NSArray *)collectDataArray
{
    _collectDataArray = collectDataArray;
    if (collectDataArray.count > 0) {
        if ([collectDataArray[0] isEqualToString:@""]) {
            if (_isDetails == YES) {
                [photoBtn setImage:kImage(@"") forState:(UIControlStateNormal)];
            }else
            {
                [photoBtn setImage:kImage(@"资料上传") forState:(UIControlStateNormal)];
            }
        }else
        {
            [photoBtn sd_setImageWithURL:[NSURL URLWithString:[collectDataArray[0] convertImageUrl]] forState:(UIControlStateNormal) placeholderImage:kImage(@"资料上传")];
        }
        
    }else
    {
        if (_isDetails == YES) {
            [photoBtn setImage:kImage(@"") forState:(UIControlStateNormal)];
        }else
        {
            [photoBtn setImage:kImage(@"资料上传") forState:(UIControlStateNormal)];
        }
        
    }
}

-(void)setIsDetails:(BOOL)isDetails
{
    _isDetails = isDetails;
}

-(void)photoBtnClick:(UIButton *)sender
{
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
