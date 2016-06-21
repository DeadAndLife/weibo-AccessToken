//
//  QYUser.m
//  Weibo
//
//  Created by qingyun on 16/5/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYUser.h"
#import "Common.h"
@implementation QYUser

+(instancetype)userWithDictionary:(NSDictionary *)info{
    return [[self alloc] initWithDictionary:info];
}

-(instancetype)initWithDictionary:(NSDictionary *)info{
    if (self = [super init]) {
        //字符串类型的id
        _idstr = info[kUserId];
        //用户昵称
        _name = info[kUserName];
        //友好显示的名称
        _screen_name = info[kUserScreenName];
        //用户个人描述
        _user_description = info[kUserDescription];
        //用户头像(50 * 50)
        _profile_image_url = info[kUserProfileImageUrl];
        //粉丝数/关注数/微博数/收藏数
        _followers_count = [info[kUserFollowersCount] integerValue];
        _friends_count = [info[kUserFriendsCount] integerValue];
        _statuses_count = [info[kUserStatusesCount] integerValue];
        _favourites_count = [info[kUserFavouritesCount] integerValue];
        //用户头像大图(180 * 180)
        _avatar_large = info[kUserAvatarLarge];
        //用户头像原图
        _avatar_hd = info[kUserAvatarHD];
    }
    return self;
}
@end
