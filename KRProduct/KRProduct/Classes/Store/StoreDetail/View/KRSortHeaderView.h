//
//  KRSortHeaderView.h
//  KRProduct
//
//  Created by LX on 2018/1/16.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ProductSortTypeDefault = 1,
    ProductSortTypeSalesVolume,
    ProductSortTypePriceAsc,
    ProductSortTypePriceDesc
} ProductSortType;

@interface KRSortHeaderView : UIView

@property (nonatomic, copy) void (^productSortBlock)(ProductSortType sortType);

@end
