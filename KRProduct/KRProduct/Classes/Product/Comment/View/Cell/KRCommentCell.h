//
//  KRCommentCell.h
//  KRProduct
//
//  Created by LX on 2018/1/11.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KRProductDetailModel;

@interface KRCommentCell : UITableViewCell

- (CGFloat)getCellHeight;

- (void)configCellWithModel:(KRProductDetailModel *)model;

@end
