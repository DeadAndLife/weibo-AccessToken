//
//  QYLoginVc.m
//  Weibo
//
//  Created by qingyun on 16/6/7.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYLoginVc.h"
#import "ConfigFile.h"
#import "QYAccessToken.h"
static NSString *APPKEY=@"3046349905";
static NSString *DIRPATH=@"http://www.hnqingyun.com";
static NSString *APPSECRET=@"2b8c7eabb70c4437876f86b12f1a914f";

@interface QYLoginVc ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView*myWeb;
@end

@implementation QYLoginVc

-(UIWebView *)myWeb{
    if (_myWeb) return _myWeb;
    _myWeb=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height)];
    _myWeb.delegate=self;
    _myWeb.scalesPageToFit=YES;
    return _myWeb;
}

//2获取AccessToken
-(void)getAccessTokenRequest:(NSString *)code{
#if 0
  //1.url封装
    NSURL *url=[NSURL URLWithString:[BASEURL stringByAppendingPathComponent:GETACCESSTOKENPATH]];
  //2.设置请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url    ];
    //设置请求方法
    request.HTTPMethod=@"POST";
    //请求参数
    /*
                    必选	   类型及范围	     说明
     client_id	    true	string	申请应用时分配的AppKey。
     client_secret	true	string	申请应用时分配的AppSecret。
     grant_type	    true	string	请求的类型，填写authorization_code
     code	        true	string	调用authorize获得的code值。
     redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     */
    request.HTTPBody=[[NSString stringWithFormat:@"client_id=%@&client_secret=%@&grant_type=authorization_code&code=%@&redirect_uri=%@",APPKEY,APPSECRET,code,DIRPATH] dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSession *seesion=[NSURLSession sharedSession];
   //task
    __weak QYLoginVc *login=self;
    NSURLSessionDataTask *task=[seesion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error)NSLog(@"====%@",error);
        //请求状态
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse*)response;
        if (httpResponse.statusCode==200) {
            //解析数据,获取到AccessToken
            NSLog(@"======%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
          //将JSONdata转换成字典
          NSDictionary *pras=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
          //字典转mode
            //获取单例对象
             QYAccessToken *token=[QYAccessToken shareHandel];
            //kvc进行赋值操作
             [token setValuesForKeysWithDictionary:pras];
            //完成授权 出栈回到上个页面
            dispatch_sync(dispatch_get_main_queue(), ^{
                [login.navigationController popViewControllerAnimated:YES];
            });
           
            
        }
    }];
    //启动请求
    [task resume];
#endif
    //创建Manager对象
    AFHTTPSessionManager *manager=[AFHTTPSessionManager
                                   manager];
    //2设置参数
    NSDictionary *pars=@{@"client_id":APPKEY,@"client_secret":APPSECRET,@"grant_type":@"authorization_code",@"code":code,@"redirect_uri":DIRPATH};
   
    
    [SVProgressHUD showWithStatus:@"加载中..."];
    //2.1设置响应接收类型
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",nil];
    //3.Post请求
    __weak QYLoginVc *loginVc=self;
    [manager POST:[BASEURL stringByAppendingPathComponent:GETACCESSTOKENPATH] parameters:pars progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        //3.1请求成功处理
        NSHTTPURLResponse *response=(NSHTTPURLResponse *)task.response;
        if (response.statusCode==200) {
            NSLog(@"=========%@",responseObject);
        //3.2字典数据转mode
        QYAccessToken *token=[QYAccessToken shareHandel];
            
        [token setValuesForKeysWithDictionary:responseObject];
         //持久化数据,
        [token presistenceData];
            
            
            
        //3.3返回主页面
        dispatch_async(dispatch_get_main_queue(), ^{
                [loginVc.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        [SVProgressHUD dismissWithDelay:1];
        
        NSLog(@"======%@",error);
        
    }];
    
    
    
}

//1.请求用户授权Token
-(void)getUserTempToken{
   //1合并url路径
    NSURL *url=[NSURL URLWithString:[BASEURL stringByAppendingPathComponent:AUTHORIZEPATH]];
   //2.设置请求
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod=@"POST";
    //设置body http 默认多个参数用&符号连接
    request.HTTPBody=[[NSString stringWithFormat:@"client_id=%@&redirect_uri=%@",APPKEY,DIRPATH] dataUsingEncoding:NSUTF8StringEncoding];
   //3webView请求
    [self.myWeb loadRequest:request];
    //启动提示框
    [SVProgressHUD show];
    
   
    
}


#pragma mark UIWebViewDelegate
//可以监听到你request请求,获取授权码
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
   //获取授权的code,用来换去授权服务器的令牌accesstoken
  //http://www.hnqingyun.com/?code=650aba102cc66ccc365e4a1934151c1c
    NSString *strUrl=[request.URL absoluteString];
    //判断是否以回调地址开头url,说明是授权成功,获取授权码
    if([strUrl hasPrefix:DIRPATH]){
      //1获取授权code,截取字符串
        NSArray *arr=[strUrl componentsSeparatedByString:@"="];
        NSString *code=arr.lastObject;
      //2请求授权码
        [self getAccessTokenRequest:code];
        return NO;
    }
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    //1.添加webView
    [self.view addSubview:self.myWeb];
    
    //2.请求用户授权Token
    [self getUserTempToken];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
