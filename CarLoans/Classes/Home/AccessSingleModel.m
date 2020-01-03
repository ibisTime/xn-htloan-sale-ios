//
//  AccessSingleModel.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/30.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "AccessSingleModel.h"

@implementation AccessSingleModel

- (NSArray *)pics1 {

    if (!_pics1) {

        NSArray *imgs = [self.carInvoice componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            if ([obj convertImageUrl]) {

                [newImgs addObject:[obj convertImageUrl]];
            }
        }];

        _pics1 = newImgs;
    }

    return _pics1;
}

- (NSArray *)pics2 {

    if (!_pics2) {

        NSArray *imgs = [self.carHgzPic componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            if ([obj convertImageUrl]) {

                [newImgs addObject:[obj convertImageUrl]];
            }
        }];

        _pics2 = newImgs;
    }

    return _pics2;
}

- (NSArray *)pics3 {

    if (!_pics3) {

        NSArray *imgs = [self.carJqx componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            if ([obj convertImageUrl]) {

                [newImgs addObject:[obj convertImageUrl]];
            }
        }];

        _pics3 = newImgs;
    }

    return _pics3;
}

- (NSArray *)pics4 {

    if (!_pics4) {

        NSArray *imgs = [self.carSyx componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            if ([obj convertImageUrl]) {

                [newImgs addObject:[obj convertImageUrl]];
            }
        }];

        _pics4 = newImgs;
    }

    return _pics4;
}


- (NSArray *)pics5 {

    if (!_pics5) {

        NSArray *imgs = [self.interviewOtherPdf componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {

                [newImgs addObject:[obj convertImageUrl]];
            }
        }];

        _pics5 = newImgs;
    }

    return _pics5;
}
- (NSArray *)pics6 {
    
    if (!_pics6) {
        
        NSArray *imgs = [self.interviewOtherPdf componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _pics6 = newImgs;
    }
    
    return _pics6;
}

- (NSArray *)pics7 {
    
    if (!_pics7) {
        
        NSArray *imgs = [self.interviewOtherPdf componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _pics7 = newImgs;
    }
    
    return _pics7;
}
- (NSArray *)pics8 {
    
    if (!_pics8) {
        
        NSArray *imgs = [self.pledgeUserIdCardCopy componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _pics8 = newImgs;
    }
    
    return _pics8;
}
- (NSArray *)Newpics1 {
    
    if (!_Newpics1) {
        
        NSArray *imgs = [self.carInvoice componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _Newpics1 = newImgs;
    }
    
    return _Newpics1;
}

- (NSArray *)Newpics2 {
    
    if (!_Newpics2) {
        
        NSArray *imgs = [self.carRegcerti componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _Newpics2 = newImgs;
    }
    
    return _Newpics2;
}

- (NSArray *)Newpics3 {
    
    if (!_Newpics3) {
        
        NSArray *imgs = [self.carPd componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _Newpics3 = newImgs;
    }
    
    return _Newpics3;
}

- (NSArray *)Newpics4 {
    
    if (!_Newpics4) {
        
        NSArray *imgs = [self.carKey componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _Newpics4 = newImgs;
    }
    
    return _Newpics4;
}


- (NSArray *)Newpics5 {
    
    if (!_Newpics5) {
        
        NSArray *imgs = [self.carBigSmj componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _Newpics5 = newImgs;
    }
    
    return _Newpics5;
}
- (NSArray *)Newpics6 {
    
    if (!_Newpics6) {
        
        NSArray *imgs = [self.carXszSmj componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _Newpics6 = newImgs;
    }
    
    return _Newpics6;
}

- (NSArray *)Newpics7 {
    
    if (!_Newpics7) {
        
        NSArray *imgs = [self.dutyPaidProveSmj componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _Newpics7 = newImgs;
    }
    
    return _Newpics7;
}
- (NSArray *)Newpics8 {
    
    if (!_Newpics8) {
        
        NSArray *imgs = [self.pledgeUserIdCardCopy componentsSeparatedByString:@"||"];
        NSMutableArray *newImgs = [NSMutableArray arrayWithCapacity:imgs.count];
        [imgs enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj convertImageUrl]) {
                
                [newImgs addObject:[obj convertImageUrl]];
            }
        }];
        
        _Newpics8 = newImgs;
    }
    
    return _Newpics8;
}
@end
