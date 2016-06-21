//
//  NSDate+Status.m
//  Weibo
//
//  Created by qingyun on 16/5/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "NSDate+Status.h"

@implementation NSDate (Status)
+(instancetype)statusDateWithString:(NSString *)dateString{
    //如:Mon Dec 28 13:30:15 +0800 2015
    //时间格式化对象的格式
    NSString *dateFormatter = @"EEE MMM dd HH:mm:ss zzz yyyy";
    //创建格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormatter;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    //把字符串格式化成NSDate
    return [formatter dateFromString:dateString];
}
@end
