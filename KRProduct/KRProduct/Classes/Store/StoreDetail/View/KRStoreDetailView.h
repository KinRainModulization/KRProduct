//
//  KRStoreDetailView.h
//  KRProduct
//
//  Created by LX on 2018/1/16.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KRStoreDetailView;

@protocol KRStoreDetailViewDelegate <NSObject>

- (void)storeHotlineClick:(KRStoreDetailView *)storeDetailView;

- (void)chainStoreClick:(KRStoreDetailView *)storeDetailView;

- (void)userCommentClick:(KRStoreDetailView *)storeDetailView;

@end

@interface KRStoreDetailView : UIView

@property (nonatomic, weak) id<KRStoreDetailViewDelegate> delegate;

@end
