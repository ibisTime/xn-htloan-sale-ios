//
//  MasterLenderInformationVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2020/1/1.
//  Copyright © 2020 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MasterLenderInformationVC : BaseViewController

@property (nonatomic , strong)NSString *code;
@property (nonatomic , strong)NSDictionary *dataDic;
@property (nonatomic , assign)BOOL isDetails;
@end

NS_ASSUME_NONNULL_END
