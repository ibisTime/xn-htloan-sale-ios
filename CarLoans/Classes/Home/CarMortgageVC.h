//
//  CarMortgageVC.h
//  CarLoans
//
//  Created by 梅敏杰 on 2019/5/8.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarMortgageVC : BaseViewController
@property (nonatomic , assign) BOOL  isMortgage;
@property (nonatomic,strong) NSArray * curNodeCodeList;
@end

NS_ASSUME_NONNULL_END
