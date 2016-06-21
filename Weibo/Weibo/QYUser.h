//
//  QYUser.h
//  Weibo
//
//  Created by qingyun on 16/5/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>
//idstr	string	字符串型的用户UID
//screen_name	string	用户昵称
//name	string	友好显示名称
//description	string	用户个人描述
//profile_image_url	string	用户头像地址（中图），50×50像素
//followers_count	int	粉丝数
//friends_count	int	关注数
//statuses_count	int	微博数
//favourites_count	int	收藏数
//avatar_large	string	用户头像地址（大图），180×180像素
//avatar_hd	string	用户头像地址（高清），高清头像原图
@interface QYUser : NSObject
@property (nonatomic, strong) NSString *idstr;
@property (nonatomic, strong) NSString *screen_name;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *user_description;
@property (nonatomic, strong) NSString *profile_image_url;
@property (nonatomic)         NSInteger followers_count;
@property (nonatomic)         NSInteger friends_count;
@property (nonatomic)         NSInteger statuses_count;
@property (nonatomic)         NSInteger favourites_count;
@property (nonatomic, strong) NSString *avatar_large;
@property (nonatomic, strong) NSString *avatar_hd;

+(instancetype)userWithDictionary:(NSDictionary *)info;
-(instancetype)initWithDictionary:(NSDictionary *)info;
@end
