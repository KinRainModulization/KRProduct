//
//  KRStoreListView.h
//  KRProduct
//
//  Created by LX on 2018/1/18.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRStoreListView : UITableView

@property (nonatomic, strong) NSArray *stores;

@property (nonatomic, copy) void (^storeDetailBlock)(void);

@end
