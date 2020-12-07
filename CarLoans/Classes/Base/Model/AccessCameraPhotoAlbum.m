//
//  AccessCameraPhotoAlbum.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/19.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AccessCameraPhotoAlbum.h"

@interface AccessCameraPhotoAlbum ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation AccessCameraPhotoAlbum

-(void)AccessCameraPhotoAlbumMethods
{

    UIWindow *window = [[UIApplication sharedApplication] keyWindow];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        [action setValue:HGColor(138, 138, 138) forKey:@"titleTextColor"];
    }];
    UIAlertAction* fromPhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {

        //创建UIImagePickerController对象，并设置代理和可编辑
        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.editing = YES;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        //选择相机时，设置UIImagePickerController对象相关属性
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
        imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        //跳转到UIImagePickerController控制器弹出相机
        [window.rootViewController presentViewController:imagePicker animated:YES completion:nil];



    }];
    UIAlertAction* fromPhotoAction1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault                                                                 handler:^(UIAlertAction * action) {


        UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.editing = YES;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //跳转到UIImagePickerController控制器弹出相册

        [window.rootViewController presentViewController:imagePicker animated:YES completion:nil];

    }];
    [cancelAction setValue:GaryTextColor forKey:@"_titleTextColor"];
    [fromPhotoAction setValue:MainColor forKey:@"_titleTextColor"];
    [fromPhotoAction1 setValue:MainColor forKey:@"_titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:fromPhotoAction];
    [alertController addAction:fromPhotoAction1];
    if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
//        alertController.popoverPresentationController.sourceView = self;
//        alertController.popoverPresentationController.sourceRect = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    [window.rootViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -- 获取图片代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
//    CarLoansWeakSelf;
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    [_PhotoDelegate AccessCameraPhotoAlbumImage:image typeStr:@""];

}

@end
