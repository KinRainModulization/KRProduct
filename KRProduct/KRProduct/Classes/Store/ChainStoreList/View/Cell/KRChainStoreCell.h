//
//  KRChainStoreCell.h
//  KRProduct
//
//  Created by LX on 2018/1/18.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KRChainStoreCell : UITableViewCell

@property (nonatomic, copy) void (^storeDetailBlock)(void);

@property (nonatomic, copy) void (^storeHotlineBlock)(void);
@end
