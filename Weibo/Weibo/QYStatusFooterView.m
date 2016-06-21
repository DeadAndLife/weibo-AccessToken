//
//  QYStatusFooterView.m
//  Weibo
//
//  Created by qingyun on 16/5/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYStatusFooterView.h"
#import "Masonry.h"
#import "Common.h"
#import "QYStatus.h"
@interface QYStatusFooterView ()
@property (nonatomic, strong) UIButton *reTwitterBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@end

@implementation QYStatusFooterView

-(UIButton *)reTwitterBtn{
    if (_reTwitterBtn == nil) {
        _reTwitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reTwitterBtn setImage:[UIImage imageNamed:@"statusdetail_icon_retweet"] forState:UIControlStateNormal];
        [_reTwitterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _reTwitterBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _reTwitterBtn;
}

-(UIButton *)commentBtn{
    if (_commentBtn == nil) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setImage:[UIImage imageNamed:@"statusdetail_icon_comment"] forState:UIControlStateNormal];
        [_commentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _commentBtn;
}

-(UIButton *)likeBtn{
    if (_likeBtn == nil) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"statusdetail_icon_like"] forState:UIControlStateNormal];
        [_likeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    }
    return _likeBtn;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.reTwitterBtn];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.likeBtn];
        [self setConstraints];
    }
    return self;
}

//更新约束
-(void)setConstraints{
    //设置子视图的约束
    [self.reTwitterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(-(kScreenW / 4.0));
        make.centerY.mas_equalTo(0);
    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
    }];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(kScreenW / 4.0);
        make.centerY.mas_equalTo(0);
    }];
}

-(void)setFooterStatus:(QYStatus *)footerStatus{
    _footerStatus = footerStatus;
    
    //设置btns的标题
    //转发
    NSInteger retwitterNum = footerStatus.reposts_count;
    NSString *retwitterString = retwitterNum ? [NSString stringWithFormat:@"%ld",retwitterNum] : @"转发";
    [self.reTwitterBtn setTitle:retwitterString forState:UIControlStateNormal];
    
    //评论
    NSInteger commentNum = footerStatus.comments_count;
    NSString *commentString = commentNum ? [NSString stringWithFormat:@"%ld",commentNum] : @"评论";
    [self.commentBtn setTitle:commentString forState:UIControlStateNormal];
    
    //赞
    NSInteger likeNum = footerStatus.attitudes_count;
    NSString *likeString = likeNum ? [NSString stringWithFormat:@"%ld",likeNum] : @"赞";
    [self.likeBtn setTitle:likeString forState:UIControlStateNormal];
    
}






@end
