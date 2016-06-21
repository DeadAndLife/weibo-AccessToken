//
//  QYComment.h
//  Weibo
//
//  Created by qingyun on 16/5/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QYUser;
@class QYStatus;

//created_at	string	评论创建时间
//idstr	string	字符串型的评论ID
//text	string	评论的内容
//source	string	评论的来源
//user	object	评论作者的用户信息字段 详细
//status	object	评论的微博信息字段 详细
//reply_comment	object	评论来源评论，当本评论属于对另一评论的回复时返回此字段

@interface QYComment : NSObject
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *idstr;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) QYUser *user;
@property (nonatomic, strong) QYStatus *status;
@property (nonatomic, strong) QYComment *reply_comment;

+(instancetype)commentWithDictionary:(NSDictionary *)info;
-(instancetype)initWithDictionary:(NSDictionary *)info;

@end
