//
//  QYMySelfVC.m
//  Weibo
//
//  Created by qingyun on 16/5/14.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYMySelfVC.h"

@interface QYMySelfVC ()
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (strong, nonatomic) UIImageView *imageView;

@property (nonatomic) CGRect bgFrame;

@end

@implementation QYMySelfVC

-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:_headerView.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.image = [UIImage imageNamed:@"headerView"];
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

//视图已经显示的时候调用
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_headerView addSubview:self.imageView];
    _bgFrame = self.imageView.frame;
}

#pragma mark -UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = self.tableView.contentOffset;
    
    NSInteger offsetY = -offset.y;
    
    if (offsetY > 0) {
        CGRect frame = self.bgFrame;
        frame.size.height += offsetY;
        frame.origin.y -= offsetY;
        self.imageView.frame = frame;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
