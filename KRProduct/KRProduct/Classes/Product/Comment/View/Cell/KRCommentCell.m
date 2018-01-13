//
//  KRCommentCell.m
//  KRProduct
//
//  Created by LX on 2018/1/11.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRCommentCell.h"
#import "KRCommentImageView.h"
#import "KRProductDetailModel.h"

@interface KRCommentCell ()
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UIView *starView;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) KRCommentImageView *commentImgView;
@end

@implementation KRCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    iconImageView.backgroundColor = [UIColor grayColor];
    iconImageView.layer.cornerRadius = 15;
    iconImageView.clipsToBounds = YES;
    [self addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.leading.equalTo(self).offset(12);
        make.width.height.mas_equalTo(30);
    }];
    _iconImgView = iconImageView;
    
    UILabel *nicknameLabel = [UILabel labelWithText:@"用户名称" textColor:FONT_COLOR_33 fontSize:14];
    [self addSubview:nicknameLabel];
    [nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView);
        make.leading.equalTo(iconImageView.mas_trailing).offset(12.5);
    }];
    _nicknameLabel = nicknameLabel;
    
    UIView *starView = [[UIView alloc] init];
    [self addSubview:starView];
    CGFloat margin = 6;
    CGFloat starW = 10;
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImageView);
        make.trailing.equalTo(self).offset(-12);
        make.size.mas_equalTo(CGSizeMake(starW*5+margin*4, starW));
    }];
    for (int i = 0; i < 5; i++) {
        UIImageView *starImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_rated_small"]];
        [starView addSubview:starImgView];
        [starImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(starView);
            make.width.mas_equalTo(starW);
            make.leading.equalTo(starView).offset(i*starW+i*margin);
        }];
    }
    _starView = starView;
    
    UILabel *infoLabel = [UILabel labelWithText:@"2017-12-02 第1次服务 激光祛痘；中度祛痘" textColor:RGB(159, 159, 159) fontSize:12];
    [self addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nicknameLabel.mas_bottom).offset(7.5);
        make.leading.equalTo(nicknameLabel);
    }];
    _infoLabel = infoLabel;
    
    UILabel *contentLabel = [UILabel labelWithText:@"内容" textColor:FONT_COLOR_33 fontSize:14];
    [self addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(infoLabel.mas_bottom).offset(12);
        make.leading.equalTo(nicknameLabel);
        make.trailing.equalTo(self).offset(12);
    }];
    _contentLabel = contentLabel;
    
    KRCommentImageView *commentImgView = [[KRCommentImageView alloc] init];
    [self addSubview:commentImgView];
    [commentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom);
        make.leading.equalTo(contentLabel);
    }];
    _commentImgView = commentImgView;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = GRAY_LINE_COLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentImgView.mas_bottom).offset(15);
        make.leading.equalTo(self).offset(12);
        make.trailing.equalTo(self).offset(-12);
//        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];

}

- (void)configCellWithModel:(KRProductDetailModel *)model {
    CGFloat commentImgW = (SCREEN_WIDTH-kLeftMargin-kRightMargin);
    CGFloat commentImgH = 0;
    CGFloat imageW = (commentImgW-2*kMargin) / 3;
    
    if (model.messageSmallPics.count==0) {
        commentImgH = 0;
    }else if (model.messageSmallPics.count<=3) {
        commentImgH = imageW;
    }else if (model.messageSmallPics.count>3&&model.messageSmallPics.count<=6){
        commentImgH = 2*imageW+kMargin;
    }else  if (model.messageSmallPics.count>6&&model.messageSmallPics.count<=9){
        commentImgH = 3*imageW+2*kMargin;
    }
    // 解决图片复用问题
    [self.commentImgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.commentImgView.dataSource = model.messageSmallPics;
    [self.commentImgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentLabel.mas_bottom).offset(commentImgH ? 15 : 0);
        make.leading.equalTo(_contentLabel);
        make.size.mas_equalTo(CGSizeMake(commentImgW, commentImgH));
    }];
}

- (CGFloat)getCellHeight {
    [self layoutIfNeeded];
    // 15.5 = lineView + margin
    return CGRectGetMaxY(self.commentImgView.frame)+15.5;
}

@end
