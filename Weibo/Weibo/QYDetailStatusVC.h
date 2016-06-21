//
//  QYDetailStatusVC.h
//  Weibo
//
//  Created by qingyun on 16/5/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYStatus;
@interface QYDetailStatusVC : UITableViewController
@property (nonatomic, strong) QYStatus *cellStatus;         //微博信息
@end
