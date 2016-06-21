//
//  QYComment.m
//  Weibo
//
//  Created by qingyun on 16/5/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYComment.h"
#import "Common.h"
#import "NSDate+Status.h"
#import "NSString+Status.h"
#import "QYUser.h"
#import "QYStatus.h"
@implementation QYComment

+(instancetype)commentWithDictionary:(NSDictionary *)info{
    return [[self alloc] initWithDictionary:info];
}

-(instancetype)initWithDictionary:(NSDictionary *)info{
    if (self = [super init]) {
        NSString *createdString = info[kCommemtCreatedAt];
        NSDate *createdDate = [NSDate statusDateWithString:createdString];
        
        _created_at  = [NSDateFormatter localizedStringFromDate:createdDate dateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterShortStyle];
        
        _idstr = info[kCommemtIdstr];
        _text = info[kCommemtText];
        _source = [NSString sourceWithHtml:info[kCommemtSource]];
        _user = [QYUser userWithDictionary:info[kCommemtUser]];
        _status = [QYStatus statusWithDictionary:info[kCommemtStatus]];
        //评论来源评论
        NSDictionary *replyComment = info[kCommemtReplyComment];
        if (replyComment) {
            _reply_comment = [QYComment commentWithDictionary:replyComment];
        }
    }
    return self;
}
@end
