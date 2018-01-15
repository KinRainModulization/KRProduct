//
//  KRProductDetailView.m
//  KRProduct
//
//  Created by LX on 2018/1/13.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRProductDetailView.h"

#define kDetailPullDownHeight 55

typedef enum {
    BasicViewPullStateUP = 1,
    BasicViewPullStateDown,
} BasicPullState;

@interface KRProductDetailView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *detailPullDownView;
@property (nonatomic, strong) UILabel *detailPullDownLabel;
@property (nonatomic, strong) UIImageView *detailPullDownImgView;

@property (nonatomic, assign) BasicPullState pullState;

@end

@implementation KRProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
        
        [_scrollView addSubview:self.detailPullDownView];
        [_detailPullDownView addSubview:self.detailPullDownLabel];
        [_detailPullDownView addSubview:self.detailPullDownImgView];
        
        UIView *leftLineView = [[UIView alloc] init];
        leftLineView.backgroundColor = RGB(230, 230, 230);
        [_detailPullDownView addSubview:leftLineView];
        leftLineView.x = 13;
        leftLineView.centerY = _detailPullDownLabel.centerY;
        leftLineView.size = CGSizeMake((SCREEN_WIDTH-26-122)*0.5, 0.5);
        
        UIView *rightLineView = [[UIView alloc] init];
        rightLineView.backgroundColor = RGB(230, 230, 230);
        [_detailPullDownView addSubview:rightLineView];
        rightLineView.x = SCREEN_WIDTH-13-leftLineView.width;
        rightLineView.centerY = _detailPullDownLabel.centerY;
        rightLineView.size = leftLineView.size;

    }
    return self;
}

- (void)pullStateChange {
    self.detailPullDownLabel.text = _pullState ==  BasicViewPullStateDown ? @"下拉回到顶部" : @"释放回到顶部";
    [UIView animateWithDuration:0.25 animations:^{
        self.detailPullDownImgView.transform = CGAffineTransformMakeRotation(_pullState ==  BasicViewPullStateDown ? 0.0001 : M_PI);
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < -kDetailPullDownHeight) {
        _pullState = BasicViewPullStateUP;
    }
    else {
        _pullState = BasicViewPullStateDown;
    }
    [self pullStateChange];
}

- (void)setImages:(NSArray *)images {
    _images = images;

    CGFloat contentH = 0;
    for (int i = 0; i < images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        CGFloat imageH = 300;
        imageView.frame = CGRectMake(0, contentH, SCREEN_WIDTH, imageH);
        [self.scrollView addSubview:imageView];
        contentH += imageH;
    }
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentH);
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIView *)detailPullDownView {
    if (!_detailPullDownView) {
        _detailPullDownView = [[UIView alloc] initWithFrame:CGRectMake(0, -kDetailPullDownHeight, SCREEN_WIDTH, kDetailPullDownHeight)];
        _detailPullDownView.backgroundColor = GLOBAL_BACKGROUND_COLOR;
    }
    return _detailPullDownView;
}

- (UILabel *)detailPullDownLabel {
    if (!_detailPullDownLabel) {
        _detailPullDownLabel = [UILabel labelWithText:@"下拉回到顶部" textColor:FONT_COLOR_99 fontSize:12];
        _detailPullDownLabel.center = CGPointMake(SCREEN_WIDTH*0.5, (kDetailPullDownHeight-10)*0.5);
    }
    return _detailPullDownLabel;
}

- (UIImageView *)detailPullDownImgView {
    if (!_detailPullDownImgView) {
        _detailPullDownImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_pull_arrow"]];
        _detailPullDownImgView.transform = CGAffineTransformMakeRotation(0.0001);
        _detailPullDownImgView.y = CGRectGetMaxY(_detailPullDownLabel.frame)+2;
        _detailPullDownImgView.centerX = _detailPullDownLabel.centerX;
    }
    return _detailPullDownImgView;
}
@end
