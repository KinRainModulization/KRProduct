//
//  KRGoodsAttributeCell.m
//  Yml
//
//  Created by LX on 2017/11/27.
//  Copyright © 2017年 xi. All rights reserved.
//

#import "KRGoodsAttributeCell.h"

#define BtnHeight 30
#define PaddingHorizontal 10
#define PaddingVertical 5

@interface KRGoodsAttributeCell ()

@property (nonatomic, strong) UILabel *attrLabel;
@end

@implementation KRGoodsAttributeCell

- (CGFloat)heightForCell {
    CGFloat pointX = 0;
    CGFloat pointY = 50; //标题高度
    CGFloat sumW = SCREEN_WIDTH - PaddingHorizontal;
    CGFloat fontW = SCREEN_WIDTH / 2 / 10.0f;// 字符所占宽度
    NSArray *attrArray = _attrs[@"attr"];
    for (int i = 0; i< attrArray.count; i++) {
        NSString *str = attrArray[i];
        CGFloat btnWidth = str.length * fontW + 20;

        if (pointX + btnWidth > sumW) {
            pointX = 0;
            pointY += (BtnHeight + PaddingVertical);
        }
        pointX += (btnWidth + PaddingHorizontal);
    }
    return pointY + BtnHeight;
}

- (void)setAttrs:(NSDictionary *)attrs {
    _attrs = attrs;
    UILabel *titleLabel = [UILabel labelWithText:attrs[@"title"] textColor:[UIColor blackColor] fontSize:16];
    titleLabel.frame = CGRectMake(0, 0, titleLabel.width, 50);
    [self addSubview:titleLabel];
    CGFloat pointX = 0;
    CGFloat pointY = titleLabel.height;
    CGFloat sumW = SCREEN_WIDTH - PaddingHorizontal;
    UIFont *fontSize = [UIFont systemFontOfSize:15];
    
    NSArray *attrArray = attrs[@"attr"];
    for (int i = 0; i < attrArray.count; i++) {
        CGRect frame = [attrArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, BtnHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : fontSize} context:nil];
        CGFloat btnWidth = frame.size.width + 20;
        // 换行
        if (pointX + btnWidth > sumW) {
            pointX = 0;
            pointY += (BtnHeight + PaddingVertical);
        }
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(pointX, pointY, btnWidth, BtnHeight);
        button.tag = i;
        [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = BtnHeight*0.3;
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor redColor].CGColor;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:attrArray[i] forState:UIControlStateNormal];
        button.titleLabel.font = fontSize;
        pointX += (btnWidth + PaddingHorizontal);
        [self addSubview:button];
    }
}

- (void)buttonDidClick:(UIButton *)sender {
    MLog(@"%ld",(long)sender.tag);
}

//- (CGFloat)heightForCell {
//    CGFloat sumW = 0;
//    CGFloat sumH = PaddingVertical+BtnHeight;
//    CGFloat fontW = SCREEN_WIDTH / 2 / 10.0f;// 字符所占宽度
//    
//    for (int i = 0; i< _attrs.count; i++) {
//        NSString *str = _attrs[i];
//        NSInteger numberOfStr = str.length;
//        sumW += PaddingHorizontal + numberOfStr * fontW;
//        // 换行
//        if (sumW > (SCREEN_WIDTH - PaddingHorizontal * 2)) {
//            sumW = 0;
//            sumW += PaddingHorizontal + numberOfStr * fontW;
//            sumH += PaddingVertical + BtnHeight;
//        }
//    }
////    sumH += PaddingVertical;
//    return sumH;
//}


@end
