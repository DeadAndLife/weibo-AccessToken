//
//  QYStatusCell.m
//  Weibo
//
//  Created by qingyun on 16/5/26.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYStatusCell.h"
#import "QYStatus.h"
#import "QYUser.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "Common.h"

#define kColumn         3
#define kImageSpace     8
#define kImageWH        (kScreenW - (kColumn + 1) * kImageSpace) / kColumn
@interface QYStatusCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *imageContentView;
@property (weak, nonatomic) IBOutlet UILabel *reTwitterContent;
@property (weak, nonatomic) IBOutlet UIView *reTwitterImageContentView;

@end

@implementation QYStatusCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setStatusModel:(QYStatus *)statusModel{
    //赋值
    _statusModel = statusModel;
    
    //设置子视图属性
    //头像
    _avatarView.layer.cornerRadius = 25.0;
    _avatarView.layer.masksToBounds = YES;
    NSString *imageUrlString = statusModel.user.profile_image_url;
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:imageUrlString] placeholderImage:[UIImage imageNamed:@"social-user"]];
    
    //友好显示的名称
    _nickNameLabel.text = statusModel.user.name;
    //发布时间
    _createdTimeLabel.text = statusModel.created_at;
    //来源
    _sourceLabel.text = statusModel.source;
    //内容
    _contentLabel.text = statusModel.text;
    
    //判断是否有转发的微博
    if (statusModel.retweeted_status) {
        //显示转发的微博内容和图片
        _reTwitterContent.text = statusModel.retweeted_status.text;
        [self layoutImage:statusModel.retweeted_status.pic_urls forView:_reTwitterImageContentView];
        //不显示imageContentView
        [self layoutImage:nil forView:_imageContentView];
    }else{
        //不显示转发的微博内容和图片
        _reTwitterContent.text = nil;
        [self layoutImage:nil forView:_reTwitterImageContentView];
        //显示imageContentView
        [self layoutImage:statusModel.pic_urls forView:_imageContentView];
    }
}

//布局图片
-(void)layoutImage:(NSArray *)images forView:(UIView *)view{
    //1.移除view上所有子视图
    [view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //2.根据images个数来更改view的高度约束
    NSArray *constraints = view.constraints;
    for (NSLayoutConstraint *constraint in constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            constraint.constant = [self imageContentViewHeightWithImages:images];
            break;
        }
    }
    //3.添加子视图
    for (int i = 0; i < images.count; i++) {
        //定位imageView的位置(相对于父视图view)
        CGFloat imageViewX = kImageSpace * (i % kColumn + 1) + kImageWH * (i % kColumn);
        CGFloat imageViewY = kImageSpace * (i / kColumn + 1) + kImageWH * (i / kColumn);
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [view addSubview:imageView];
        //设置约束
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kImageWH, kImageWH));
            make.left.mas_equalTo(imageViewX);
            make.top.mas_equalTo(imageViewY);
        }];
        
        //设置图片
        NSString *urlString = images[i][kStatusThumbnailPic];
        [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"social-placeholder"]];
        
        //防止图片走形
        imageView.contentMode =  UIViewContentModeScaleAspectFill;
        imageView.layer.masksToBounds = YES;
    }
}

//计算图片视图的父视图的高度
-(CGFloat)imageContentViewHeightWithImages:(NSArray *)images{
    if (images.count == 0) {
        return 0;
    }
    //图片的个数
    NSInteger imageCount = images.count;
    //行数
    NSInteger line = (imageCount - 1) / kColumn + 1;
    //高度
    return (line * kImageWH + ((line + 1) * kImageSpace));
}


@end
