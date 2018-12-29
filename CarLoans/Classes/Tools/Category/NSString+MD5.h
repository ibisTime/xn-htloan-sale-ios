//
//  NSString+MD5.h
//  CarLoans
//
//  Created by shaojianfei on 2018/10/19.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)
/**
 *  md5加密的字符串
 *
 *  @param str
 *
 *  @return
 */
+ (NSString *) md5:(NSString *) str;

@end
