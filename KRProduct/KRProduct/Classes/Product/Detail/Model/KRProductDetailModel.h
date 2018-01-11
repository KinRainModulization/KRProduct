//
//  KRProductDetailModel.h
//  KRProduct
//
//  Created by LX on 2018/1/11.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KRProductDetailModel : NSObject

@property(nonatomic,copy)NSArray *messageSmallPics;

// 评价内容行数 默认不限制行数
@property (nonatomic, assign) NSInteger numberOfLine;

@end
