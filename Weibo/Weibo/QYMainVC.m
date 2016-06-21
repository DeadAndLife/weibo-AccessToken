//
//  QYMainVC.m
//  Weibo
//
//  Created by qingyun on 16/5/13.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYMainVC.h"

@interface QYMainVC ()

@end

@implementation QYMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置中间的 + 号
    [self setTabBar];
    // Do any additional setup after loading the view.
}

-(void)setTabBar{
    CGFloat btnW = 50;
    CGFloat btnH = 40;
    CGFloat btnX = self.tabBar.center.x - btnW / 2.0;
    CGFloat btnY = (CGRectGetHeight(self.tabBar.frame) - btnH) / 2.0;
    //创建并添加btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tabBar addSubview:btn];
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    //设置背景颜色
    [btn setBackgroundColor:[UIColor orangeColor]];
    //设置图片
    [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
   //添加事件监听
    [btn addTarget:self action:@selector(composeAction:) forControlEvents:UIControlEventTouchUpInside];
    //设置圆角
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
}

-(void)composeAction:(UIButton *)composeItme{
    
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
