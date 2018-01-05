//
//  KRGoodsAttributeCell.h
//  Yml
//
//  Created by LX on 2017/11/27.
//  Copyright © 2017年 xi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KRGoodsAttributeCellDelegate <NSObject>

- (void)heightForAttributeCell:(CGFloat)cellHeight whiteRow:(NSInteger)index;

@end

@interface KRGoodsAttributeCell : UITableViewCell

// 规格数组
@property (nonatomic, strong) NSDictionary *attrs;

@property (nonatomic, weak) id<KRGoodsAttributeCellDelegate> delegate;

- (CGFloat)heightForCell;

@end
