//
//  KRGoodsAttributeCell.m
//  Yml
//
//  Created by LX on 2017/11/27.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "KRGoodsAttributeCell.h"

#define kContentW SCREEN_WIDTH-24
static const CGFloat kBtnHeight = 25;
static const CGFloat kTitleHeight = 50;
static const CGFloat kPaddingHorizontal = 10;
static const CGFloat kPaddingVertical = 5;
static const CGFloat kBtnPadding = 24;

@interface KRGoodsAttributeCell ()

@property (nonatomic, strong) UILabel *attrLabel;
@end

@implementation KRGoodsAttributeCell

- (CGFloat)heightForCell {
    CGFloat pointX = 0;
    CGFloat pointY = kTitleHeight;
    CGFloat sumW = kContentW;
    NSArray *attrArray = _attrs[@"attr"];
    for (int i = 0; i< attrArray.count; i++) {
        CGFloat fontW = [attrArray[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width;
        CGFloat btnWidth = fontW + kBtnPadding;
        if (pointX + btnWidth > sumW) {
            pointX = 0;
            pointY += (kBtnHeight + kPaddingVertical);
        }
        pointX += (btnWidth + kPaddingHorizontal);
    }
    return pointY + kBtnHeight;
}

- (void)setAttrs:(NSDictionary *)attrs {
    _attrs = attrs;
    UILabel *titleLabel = [UILabel labelWithText:attrs[@"title"] textColor:FONT_COLOR_33 fontSize:14];
    titleLabel.frame = CGRectMake(0, 0, titleLabel.width, kTitleHeight);
    [self addSubview:titleLabel];
    CGFloat pointX = 0;
    CGFloat pointY = titleLabel.height;
    CGFloat sumW = kContentW;
    
    NSArray *attrArray = attrs[@"attr"];
    for (int i = 0; i < attrArray.count; i++) {
//        CGRect frame = [attrArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, kBtnHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : fontSize} context:nil];
//        CGFloat btnWidth = frame.size.width + kBtnPadding;
        CGFloat fontW = [attrArray[i] sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width;
        CGFloat btnWidth = fontW + kBtnPadding;
        // 换行
        if (pointX + btnWidth > sumW) {
            pointX = 0;
            pointY += (kBtnHeight + kPaddingVertical);
        }
        UIButton *button = [UIButton buttonWithTitle:attrArray[i] fontSize:12 titleColor:FONT_COLOR_99 target:self action:@selector(buttonDidClick:)];
        button.frame = CGRectMake(pointX, pointY, btnWidth, kBtnHeight);
        button.tag = i;
        button.backgroundColor = RGB(240, 240, 240);
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 12.5;
        pointX += (btnWidth + kPaddingHorizontal);
        [self addSubview:button];
    }
}

- (void)buttonDidClick:(UIButton *)sender {
    MLog(@"%ld",(long)sender.tag);
}

@end
