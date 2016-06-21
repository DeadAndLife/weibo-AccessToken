//
//  QYCommentCell.h
//  Weibo
//
//  Created by qingyun on 16/5/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYComment;
@interface QYCommentCell : UITableViewCell
@property (nonatomic, strong) QYComment *commentModel;
@end
