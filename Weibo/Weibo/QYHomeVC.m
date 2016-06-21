//
//  QYHomeVC.m
//  Weibo
//
//  Created by qingyun on 16/5/14.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYHomeVC.h"
#import "QYStatus.h"
#import "QYStatusCell.h"
#import "QYStatusFooterView.h"
#import "QYDetailStatusVC.h"
#import "ConfigFile.h"
#import "QYAccessToken.h"
@interface QYHomeVC ()
@property (nonatomic, strong) NSArray *statusArray;
@end

@implementation QYHomeVC
static NSString *cellIdentifier = @"statusCell";
static NSString *footerIdentifier = @"statusFooter";
//懒加载微博首页数据
-(NSArray *)statusArray{
    if (_statusArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"temp" ofType:@"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        
        NSArray *statusArr = dict[@"statuses"];
        NSMutableArray *models = [NSMutableArray array];
        for (NSDictionary *statusDict in statusArr) {
            QYStatus *status = [QYStatus statusWithDictionary:statusDict];
            [models addObject:status];
        }
        _statusArray = models;
    }
    return _statusArray;
}

//网络请求数据
-(void)requestHomeList{
  //GET请求方法
  //1合并URL
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&page=1",[BASEURL stringByAppendingPathComponent:GETHOMELISTPATH],[QYAccessToken shareHandel].access_token]];
  //2.请求数据
    __weak QYHomeVC *home=self;
    NSURLSession *seession=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[seession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       //2.1判断请求成功
        if(error)NSLog(@"=====%@",error);
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
        if (httpResponse.statusCode==200) {
          //2.2 data 转换成字典 JSON解析
          NSDictionary *prs=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
          //2.3 字典转mode
            if (prs) {
                NSArray *dataArr=prs[@"statuses"];
                NSMutableArray *modeArr=[NSMutableArray array];
                for (NSDictionary *tempDic in dataArr) {
                    [modeArr addObject:[QYStatus statusWithDictionary:tempDic]];
                }
                home.statusArray=modeArr;
            }
            //2.4.刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [home.tableView reloadData];
            });
            
        }
    }];
    
   //3.启动
    [task resume];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //判断授权码accessToken
    if ([QYAccessToken shareHandel].access_token) {
        //网络请求数据
        [self requestHomeList];
        //隐藏登录按钮
        self.navigationItem.rightBarButtonItem=nil;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QYStatusCell class]) bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
    //注册sectionFooterView
    [self.tableView registerClass:[QYStatusFooterView class] forHeaderFooterViewReuseIdentifier:footerIdentifier];
    
    //设置tableView的预估高度
    self.tableView.estimatedRowHeight = 120;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.statusArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //获取当前section的模型
    QYStatus *cellStatus = self.statusArray[indexPath.section];
    cell.statusModel = cellStatus;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }else{
        return 10;
    }
}

//设置sectionFooterView的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
}

//设置sectionFooterView
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    QYStatusFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footerIdentifier];
    
    //获取当前section的模型
    QYStatus *status = self.statusArray[section];
    footerView.footerStatus = status;
    
    return footerView;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取详情视图控制器
    QYDetailStatusVC *detailStatusVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detailVC"];
    QYStatus *selectedStatus = self.statusArray[indexPath.section];
    detailStatusVC.cellStatus = selectedStatus;
    
    [self.navigationController pushViewController:detailStatusVC animated:YES];
}


@end
