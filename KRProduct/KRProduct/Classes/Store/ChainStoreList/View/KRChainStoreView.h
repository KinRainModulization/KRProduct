//
//  KRChainStoreView.h
//  KRProduct
//
//  Created by LX on 2018/1/18.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRChainStoreView : UITableView

@property (nonatomic, strong) NSArray *stores;

@property (nonatomic, copy) void (^storeHotlineBlock)(void);

@property (nonatomic, copy) void (^storeDetailBlock)(void);

@end
