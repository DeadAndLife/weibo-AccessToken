//
//  QYAccessToken.m
//  Weibo
//
//  Created by qingyun on 16/6/7.
//  Copyright © 2016年 QingYun. All rights reserved.


#import "QYAccessToken.h"
//声明一个静态变量
/*
@property(nonatomic,strong)NSString *access_token; //授权的token
@property(nonatomic,strong)NSString *remind_in;  //access_token的生命周期
@property(nonatomic,strong)NSString *uid;        //授权用户UID
@property(nonatomic,strong)NSString *expires_in;
*/
static QYAccessToken *accessToken;

static  NSString *KaccessToken=@"access_token";
static  NSString *Kremindin=@"remind_in";
static  NSString *Kuid=@"uid";
static  NSString *Kexpiresin=@"expires_in";

@implementation QYAccessToken
//读取本地持久化数据,反序列化
+(QYAccessToken *)getModeFromPath{
    //反序列化
    QYAccessToken *token=[NSKeyedUnarchiver unarchiveObjectWithFile:[QYAccessToken getFilePath]];
    return token;
}

+(instancetype)shareHandel{
    //判断accesstoken是否为nil
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        accessToken=[QYAccessToken getModeFromPath];
        //判断本地是否有持久化数据
        if (!accessToken) {
            //重新初始化数据
            accessToken=[[QYAccessToken alloc] init];
        }
    });
    return accessToken;
}
//反序列化,data====>objc
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super  init]) {
        _remind_in=[aDecoder decodeObjectForKey:Kremindin];
        _access_token=[aDecoder decodeObjectForKey:KaccessToken];
        _uid=[aDecoder decodeObjectForKey:Kuid];
        _expires_in=[aDecoder decodeObjectForKey:Kexpiresin];
    }
    return self;
}
//序列化
-(void)encodeWithCoder:(NSCoder *)aCoder{
  //mode====>Ndata
    [aCoder encodeObject:_access_token forKey:KaccessToken];
    [aCoder encodeObject:_uid forKey:Kuid];
    [aCoder encodeObject:_expires_in forKey:Kexpiresin];
    [aCoder encodeObject:_remind_in forKey:Kremindin];
}

+(NSString *)getFilePath{
//1.获取沙盒目录
    NSString *documentsPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
 //2.合并路径
    return [documentsPath stringByAppendingPathComponent:@"AccessToken"];

}


-(BOOL)presistenceData{
   //序列化,存储在本地
   return [NSKeyedArchiver archiveRootObject:accessToken toFile:[QYAccessToken  getFilePath]];
}

-(void)logOut{
 //1.本地数据删除
    if ([[NSFileManager defaultManager] removeItemAtPath:[QYAccessToken getFilePath] error:nil]) {
        //清空对象属性
        _access_token=nil;
        _uid=nil;
        _expires_in=nil;
        _remind_in=nil;
    }
}




@end
