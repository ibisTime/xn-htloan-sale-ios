//
//  NewLenderVC.h
//  CarLoans
//
//  Created by 郑勤宝 on 2019/12/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewLenderVC : BaseViewController
@property (nonatomic , strong)NSDictionary *dataDic;
@property (nonatomic , strong)NSString *code;
@property (nonatomic , assign)BOOL isDetails;


@end

NS_ASSUME_NONNULL_END
