//
//  KRProductBasicView.h
//  KRProduct
//
//  Created by LX on 2018/1/9.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KRProductBasicView;

@protocol KRProductBasicViewDelegate <NSObject>

- (void)productSelectAttributes:(KRProductBasicView *)productBasicView;

- (void)userCommentClick:(KRProductBasicView *)productBasicView;

- (void)chainStoreClick:(KRProductBasicView *)productBasicView;

- (void)storeDetailClick:(KRProductBasicView *)productBasicView;

- (void)storeHotlineClick:(KRProductBasicView *)productBasicView;

- (void)productBasicViewPullUp:(KRProductBasicView *)productBasicView;

@end

@interface KRProductBasicView : UIView

@property (nonatomic, weak) id<KRProductBasicViewDelegate> delegate;

@end
