//
//  NSDate+Status.h
//  Weibo
//
//  Created by qingyun on 16/5/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Status)
//根据字符串返回nsdate
+(instancetype)statusDateWithString:(NSString *)dateString;
@end
