//
//  AddFilesVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/11.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "FileModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddFilesVC : BaseViewController
@property (nonatomic,strong) AccessSingleModel * model;
@property (nonatomic,strong) FileModel * fileModel;
@end

NS_ASSUME_NONNULL_END
