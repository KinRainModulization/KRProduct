//
//  KRCommentImageView.m
//  KRProduct
//
//  Created by LX on 2018/1/11.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRCommentImageView.h"

@implementation KRCommentImageView

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    
    CGFloat imageW = (SCREEN_WIDTH-kLeftMargin-2*kMargin-kRightMargin) / 3;
    CGFloat imageH = imageW;
    for (int i = 0; i < dataSource.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i%3)*(imageW+kMargin), (i/3)*(imageH+kMargin), imageW, imageH)];
        imageView.layer.cornerRadius = 5;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
        [imageView addGestureRecognizer:singleTap];

        imageView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    }
}

- (void)tapImageAction:(UITapGestureRecognizer *)tap {
    UIImageView *tapView = (UIImageView *)tap.view;
    if (self.tapBlock) {
        self.tapBlock(tapView.tag,self.dataSource);
    }
}

@end
