//
//  KRCommentImageView.h
//  KRProduct
//
//  Created by LX on 2018/1/11.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLeftMargin 54
#define kRightMargin 12
#define kMargin 5

typedef void (^TapBlcok)(NSInteger index, NSArray *dataSource);

@interface KRCommentImageView : UIView

@property (nonatomic, retain)NSArray *dataSource;

@property (nonatomic, copy)TapBlcok tapBlock;

@end
