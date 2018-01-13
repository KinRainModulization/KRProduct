//
//  KRProductDetailView.m
//  KRProduct
//
//  Created by LX on 2018/1/13.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRProductDetailView.h"

@interface KRProductDetailView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation KRProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.scrollView];
    }
    return self;
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
    }
    return _scrollView;
}
@end
