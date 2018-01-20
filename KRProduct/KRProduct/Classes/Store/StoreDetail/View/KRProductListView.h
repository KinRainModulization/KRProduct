//
//  KRProductListView.h
//  KRProduct
//
//  Created by LX on 2018/1/16.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KRSortHeaderView.h"

@interface KRProductListView : UIView

@property (nonatomic, copy) void (^productSortBlock)(ProductSortType sortType);

@property (nonatomic, copy) void (^productDetailBlock)(void);

@end
