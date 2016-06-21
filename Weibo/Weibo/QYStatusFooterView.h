//
//  QYStatusFooterView.h
//  Weibo
//
//  Created by qingyun on 16/5/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYStatus;
@interface QYStatusFooterView : UITableViewHeaderFooterView
@property (nonatomic, strong) QYStatus *footerStatus;
@end
