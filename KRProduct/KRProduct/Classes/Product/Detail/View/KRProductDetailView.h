//
//  KRProductDetailView.h
//  Yml
//
//  Created by LX on 2017/11/17.
//  Copyright © 2017年 xi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRProductDetailView : UIView

@property (nonatomic, copy) void (^productDetailBackBlock)(void);

@property (nonatomic, copy) void (^productClickBlock)(void);

@end
