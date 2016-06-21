//
//  NSString+Status.m
//  Weibo
//
//  Created by qingyun on 16/5/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "NSString+Status.h"

@implementation NSString (Status)
+(instancetype)sourceWithHtml:(NSString *)htmlString{
    //<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
    
    //判断不存在htmlString
    if (htmlString.length == 0 || [htmlString isKindOfClass:[NSNull class]]) {
        return nil;
    }
    
    NSString *regExstring = @">.*<";
    NSError *error = nil;
    //创建正则表达式对象
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:regExstring options:NSRegularExpressionCaseInsensitive error:&error];
    //匹配表达式的结果
    NSTextCheckingResult *result = [expression firstMatchInString:htmlString options:NSMatchingReportProgress range:NSMakeRange(0, htmlString.length)];
    if (result) {
        //在结果的range基础 上去头 ">"和尾部的"<"
        NSRange range = NSMakeRange(result.range.location + 1, result.range.length - 2);
        return [htmlString substringWithRange:range];
    }else{
        return nil;
    }
    
}
@end
