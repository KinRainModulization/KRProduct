//
//  KRPopupView.h
//  KRProduct
//
//  Created by LX on 2018/1/15.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRPopupView : UIView

+ (instancetype)sharedManager;

- (void)showModal:(UIView *)view;

- (void)dismiss;

@end
