//
//  QYStatus.m
//  Weibo
//
//  Created by qingyun on 16/5/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYStatus.h"
#import "NSDate+Status.h"
#import "NSString+Status.h"
#import "QYUser.h"
#import "Common.h"
@implementation QYStatus

+(instancetype)statusWithDictionary:(NSDictionary *)info{
    return [[self alloc] initWithDictionary:info];
}

-(instancetype)initWithDictionary:(NSDictionary *)info{
    if (self = [super init]) {
        //获取创建微博的时间(字符串)
        NSString *createdString = info[kStatusCreatedAt];
        //微博的时间转化成NSDate
        NSDate *createdDate = [NSDate statusDateWithString:createdString];
        //确定微博显示级别
        _created_at = [self dateStringForDate:createdDate];
        //id
        _idstr = info[kStatusIdstr];
        //微博信息内容
        _text = info[kStatusText];
        //微博来源
        _source = [NSString sourceWithHtml:info[kStatusSource]];
        //是否收藏
        _favorited = [info[kStatusFavorited] integerValue];
        //原始图片
        _original_pic = info[kStatusOriginalPic];
        //用户
        _user = [QYUser userWithDictionary:info[kStatusUser]];
        //转发的微博
        NSDictionary *reStatus = info[kStatusRetweetedStatus];
        if (reStatus) {
            _retweeted_status = [QYStatus statusWithDictionary:reStatus];
        }
        //转发数/评论数/表态数
        _reposts_count = [info[kStatusRepostsCount] integerValue];
        _comments_count = [info[kStatusCommentsCount] integerValue];
        _attitudes_count = [info[kStatusAttitudesCount] integerValue];
        //微博图片
        _pic_urls = info[kStatusPicUrls];
    }
    return self;
}
//动态计算微博创建的时间(按照时间级别展示)
-(NSString *)dateStringForDate:(NSDate *)date{
    //1.计算时间差(单位:秒)
    NSTimeInterval interval = -[date timeIntervalSinceNow];
    //2.根据时间差确定时间级别
    if (interval < 60) {//秒级
        return [NSString stringWithFormat:@"刚刚 %d 秒之前",(int)interval];
    }else if (interval < 60 * 60){//分级
        return [NSString stringWithFormat:@"刚刚 %d 分之前",(int)(interval / 60)];
    }else if (interval < 60 * 60 * 24){//时级
        return [NSString stringWithFormat:@"刚刚 %d 小时之前",(int)(interval / (60 * 60))];
    }else if (interval < 60 * 60 * 24 * 30){//天级
        return [NSString stringWithFormat:@"刚刚 %d 天之前",(int)(interval / (60 * 60 * 24))];
    }else{//直接格式化时间
        /****NSDateFormatterStyle
         NSDateFormatterNoStyle
         如:(空白)
         NSDateFormatterShortStyle
         如:16/5/26   上午 11:41
         NSDateFormatterMediumStyle
         如:2016年5月26日  上午 11:42:00
         NSDateFormatterLongStyle
         如:2016年5月26日  GMT +8 上午 11:42:00
         NSDateFormatterFullStyle
         如:2016年5月26日 星期四    中国标准时间上午 上午 11:42:00
        ***/
        return [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    }
}
@end
