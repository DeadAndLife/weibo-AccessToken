//
//  QYAccessToken.h
//  Weibo
//
//  Created by qingyun on 16/6/7.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QYAccessToken : NSObject<NSCoding>
//单例
+(instancetype)shareHandel;
@property(nonatomic,strong)NSString *access_token; //授权的token
@property(nonatomic,strong)NSString *remind_in;  //access_token的生命周期
@property(nonatomic,strong)NSString *uid;        //授权用户UID
@property(nonatomic,strong)NSString *expires_in;  //access_token的生命周期
//持久化
-(BOOL)presistenceData;

//logOUt
-(void)logOut;


@end
