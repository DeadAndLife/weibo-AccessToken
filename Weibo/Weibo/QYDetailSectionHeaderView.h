//
//  QYDetailSectionHeaderView.h
//  Weibo
//
//  Created by qingyun on 16/5/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QYStatus;
@interface QYDetailSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) QYStatus *headerStatus;
@property (nonatomic, copy) void (^changedSelectedBtn)(NSInteger tag);

//选中的btn的tag值
@property (nonatomic) NSInteger selectedTagOfBtns;

+(instancetype)sectionHeaderViewForTableView:(UITableView *)tableView WithSelectedTag:(NSInteger)selectedTag;
@end
