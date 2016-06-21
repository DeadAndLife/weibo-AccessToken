//
//  QYCommentCell.m
//  Weibo
//
//  Created by qingyun on 16/5/28.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "QYCommentCell.h"
#import "QYComment.h"
#import "QYUser.h"
#import "UIImageView+WebCache.h"
@interface QYCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *createdTime;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation QYCommentCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCommentModel:(QYComment *)commentModel{
    _commentModel = commentModel;
    
    //设置属性(图片和文本)
    NSString *avatarImageUrl = commentModel.user.profile_image_url;
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:avatarImageUrl] placeholderImage:[UIImage imageNamed:@"social-user"]];
    _avatarView.layer.cornerRadius = 25.0;
    _avatarView.layer.masksToBounds = YES;
    
    _nickName.text = commentModel.user.name;
    
    _createdTime.text = commentModel.created_at;
    
    _content.text = commentModel.text;
}

- (IBAction)likeBtnClick:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
