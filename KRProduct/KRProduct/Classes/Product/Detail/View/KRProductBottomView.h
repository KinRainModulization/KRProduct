//
//  KRProductBottomView.h
//  KRProduct
//
//  Created by LX on 2018/1/8.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KRProductBottomView;

@protocol KRProductBottomViewDelegate <NSObject>

- (void)storeClick:(KRProductBottomView *)productBottomView;

- (void)shoppingCartClick:(KRProductBottomView *)productBottomView;

- (void)orderClick:(KRProductBottomView *)productBottomView;

- (void)addShoppingCart:(KRProductBottomView *)productBottomView;

@end

@interface KRProductBottomView : UIView

@property (nonatomic, weak) id<KRProductBottomViewDelegate> delegate;

@end
