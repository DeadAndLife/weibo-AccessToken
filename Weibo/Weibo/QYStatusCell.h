//
//  QYStatusCell.h
//  Weibo
//
//  Created by qingyun on 16/5/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYStatus;
@interface QYStatusCell : UITableViewCell
@property (nonatomic, strong) QYStatus *statusModel;
@end
