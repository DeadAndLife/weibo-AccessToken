//
//  QYGuideVC.m
//  Weibo
//
//  Created by qingyun on 16/5/13.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYGuideVC.h"
#import "AppDelegate.h"
#import "Common.h"
#define ImageCount 4
@interface QYGuideVC ()
@property (nonatomic, strong) NSArray *imageNames;
@end

@implementation QYGuideVC

//懒加载引导页图片名称
-(NSArray *)imageNames{
    if (_imageNames == nil) {
        _imageNames = @[@"helper_authority_miaopai_guide",@"helper_authority_notice_guide",@"helper_authority_place_guide",@"helper_authority_weibocamera_guide"];
    }
    return _imageNames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self addScrollViewForView];
    // Do any additional setup after loading the view.
}

//添加滚动视图
-(void)addScrollViewForView{
    //创建并添加scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    
    //设置contentSize
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(scrollView.frame) * ImageCount,  CGRectGetHeight(scrollView.frame));
    //分页
    scrollView.pagingEnabled = YES;
    //隐藏滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < ImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(scrollView.frame) * i, 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame))];
        [scrollView addSubview:imageView];
        
        imageView.image = [UIImage imageNamed:self.imageNames[i]];
        imageView.contentMode = UIViewContentModeCenter;
        if (i == ImageCount - 1) {
            UIButton *endBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [imageView addSubview:endBtn];
            
            endBtn.frame = CGRectMake((CGRectGetWidth(imageView.frame) - 100) / 2.0, CGRectGetHeight(imageView.frame) - 50 - 50, 100, 50);
            [endBtn setTitle:@"结束引导" forState:UIControlStateNormal];
            imageView.userInteractionEnabled = YES;
            //添加事件监听
            [endBtn addTarget:self action:@selector(endGuide) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
}
- (IBAction)btnClick:(UIButton *)sender {
    [self endGuide];
}

-(void)endGuide{
    //获取mainVC
    UITabBarController *tabBarController = [self.storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
    //设置window的根视图控制器
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = tabBarController;
    
    //获取版本号
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    //
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:kAPP_VERSION];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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
