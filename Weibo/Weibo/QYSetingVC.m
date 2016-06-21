//
//  QYSetingVC.m
//  Weibo
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYSetingVC.h"
#import "QYAccessToken.h"
@interface QYSetingVC ()
@property(nonatomic,strong)NSArray *dataArr;
@end

@implementation QYSetingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //判断是否登录
    if ([QYAccessToken shareHandel].access_token) {
        self.dataArr=@[@[@"账号管理",@"账号安全"],@[@"通知",@"隐私",@"通用设置"],@[@"清理缓存",@"意见反馈",@"关于微博"],@[@"退出登录"]];
    }else{
        self.dataArr=@[@[@"通用设置"],@[@"关于微博"]];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Settingfier" forIndexPath:indexPath];
    //赋值操作
    cell.textLabel.text=self.dataArr[indexPath.section][indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSString *str=self.dataArr[indexPath.section][indexPath.row];
    if ([str isEqualToString:@"退出登录"]) {
        //1.退出登录
        [[QYAccessToken shareHandel] logOut];
        
        //2.出栈
        [self.navigationController popViewControllerAnimated:YES];
    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
