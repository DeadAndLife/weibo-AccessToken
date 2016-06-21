//
//  QYDetailSectionHeaderView.m
//  Weibo
//
//  Created by qingyun on 16/5/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYDetailSectionHeaderView.h"
#import "QYStatus.h"
#import "Masonry.h"
@interface QYDetailSectionHeaderView ()
@property (nonatomic, strong) UIButton *retwitterBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIView *indicatorView;
@end

@implementation QYDetailSectionHeaderView
static NSString *headerIdentifier = @"headerView";
//类方法初始化sectionHeaderView
+(instancetype)sectionHeaderViewForTableView:(UITableView *)tableView WithSelectedTag:(NSInteger)selectedTag{
    QYDetailSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    
    if (headerView == nil) {
        headerView = [[QYDetailSectionHeaderView alloc] initWithReuseIdentifier:headerIdentifier WithSelectedTag:(NSInteger)selectedTag];
    }
    return headerView;
}


#pragma mark 懒加载需要的子视图
-(UIButton *)retwitterBtn{
    if (_retwitterBtn == nil) {
        _retwitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_retwitterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _retwitterBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_retwitterBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _retwitterBtn.tag = 101;
    }
    return _retwitterBtn;
}

-(UIButton *)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_commentBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _commentBtn.tag = 102;
    }
    return _commentBtn;
}

-(UIButton *)likeBtn{
    if (_likeBtn == nil) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [_likeBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _likeBtn.tag = 103;
    }
    return _likeBtn;
}

-(UIView *)indicatorView{
    if (_indicatorView == nil) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [UIColor redColor];
    }
    return _indicatorView;
}

//初始化headerView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier WithSelectedTag:(NSInteger)selectedTag{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.retwitterBtn];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.likeBtn];
        [self.contentView addSubview:self.indicatorView];
        [self setConstrainsWithSelectedTag:selectedTag];
    }
    return self;
}

//设置子视图的约束
-(void)setConstrainsWithSelectedTag:(NSInteger)selectedTag{
    [self.retwitterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_retwitterBtn.mas_right).with.offset(50);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-30);
        make.centerY.mas_equalTo(0);
    }];
    
    UIButton *selectedBtn = (UIButton *)[self.contentView viewWithTag:selectedTag];
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(selectedBtn);
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(0);
    }];
}


-(void)setSelectedTagOfBtns:(NSInteger)selectedTagOfBtns{
    _selectedTagOfBtns = selectedTagOfBtns;
    
    UIButton *selectedBtn = (UIButton *)[self.contentView viewWithTag:selectedTagOfBtns];
    
    [self.indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.width.equalTo(selectedBtn);
        make.height.mas_equalTo(2);
        make.bottom.mas_equalTo(0);
    }];
    __weak QYDetailSectionHeaderView *weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf layoutIfNeeded];
    }];
}


//设置headerView的子视图属性
-(void)setHeaderStatus:(QYStatus *)headerStatus{
    _headerStatus = headerStatus;
    
    //设置btns的标题
    //转发
    NSInteger retwitterNum = headerStatus.reposts_count;
    NSString *retwitterString = [NSString stringWithFormat:@"转发 %ld",retwitterNum];
    [self.retwitterBtn setTitle:retwitterString forState:UIControlStateNormal];
    
    //评论
    NSInteger commentNum = headerStatus.comments_count;
    NSString *commentString =  [NSString stringWithFormat:@"评论 %ld",commentNum] ;
    [self.commentBtn setTitle:commentString forState:UIControlStateNormal];
    
    //赞
    NSInteger likeNum = headerStatus.attitudes_count;
    NSString *likeString = [NSString stringWithFormat:@"赞 %ld",likeNum];
    [self.likeBtn setTitle:likeString forState:UIControlStateNormal];
    
}

-(void)btnClick:(UIButton *)sender{
    if (_changedSelectedBtn) {
        _changedSelectedBtn(sender.tag);
    }
}

@end
