//
//  QYStatus.h
//  Weibo
//
//  Created by qingyun on 16/5/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>
@class QYUser;
//created_at	string	微博创建时间
//idstr	string	字符串型的微博ID
//text	string	微博信息内容
//source	string	微博来源
//favorited	boolean	是否已收藏，true：是，false：否
//thumbnail_pic	string	缩略图片地址，没有时不返回此字段
//bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
//original_pic	string	原始图片地址，没有时不返回此字段
//user	object	微博作者的用户信息字段 详细
//retweeted_status	object	被转发的原微博信息字段，当该微博为转发微博时返回 详细
//reposts_count	int	转发数
//comments_count	int	评论数
//attitudes_count	int	表态数
//pic_urls          array 微博图片
@interface QYStatus : NSObject
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *idstr;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *source;
@property (nonatomic)         BOOL favorited;
@property (nonatomic, strong) NSString *original_pic;
@property (nonatomic, strong) QYUser *user;
@property (nonatomic, strong) QYStatus *retweeted_status;
@property (nonatomic)         NSInteger reposts_count;
@property (nonatomic)         NSInteger comments_count;
@property (nonatomic)         NSInteger attitudes_count;
@property (nonatomic, strong) NSArray *pic_urls;


+(instancetype)statusWithDictionary:(NSDictionary *)info;
-(instancetype)initWithDictionary:(NSDictionary *)info;
@end
