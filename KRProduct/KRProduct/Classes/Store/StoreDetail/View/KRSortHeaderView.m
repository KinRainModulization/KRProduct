//
//  KRSortHeaderView.m
//  KRProduct
//
//  Created by LX on 2018/1/16.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRSortHeaderView.h"

@interface KRSortHeaderView ()

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, assign) BOOL isAscSort;

@end

@implementation KRSortHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _isAscSort = NO;
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    self.backgroundColor = GLOBAL_BACKGROUND_COLOR;
    
    CGFloat btnW = self.width / 3;
    for (int i = 0; i < self.titleArray.count; i++) {
        UIButton *button = nil;
        if (i == _titleArray.count-1) {
            button = [UIButton buttonWithImage:@"none_sort" spacing:5 title:_titleArray[i] fontSize:14 titleColor:FONT_COLOR_99 target:self action:@selector(titleBtnClick:)];
        }
        else {
            button = [UIButton buttonWithTitle:_titleArray[i] fontSize:14 titleColor:FONT_COLOR_99 target:self action:@selector(titleBtnClick:)];
            if (i == 0) {
                [self titleBtnClick:button];
            }
        }
        button.tag = 1000+i;
        [button setTitleColor:GLOBAL_COLOR forState:UIControlStateSelected];
        button.frame = CGRectMake(i*btnW, 0, btnW, self.height);
        [self addSubview:button];
    }
}

- (void)titleBtnClick:(UIButton *)button {
    if (button.tag == 1002) {
        _isAscSort = self.selectedBtn == button ? !_isAscSort : YES;
        [button setImage:[UIImage imageNamed:_isAscSort ? @"asc_sort" : @"desc_sort"] forState:UIControlStateSelected];
    }
    self.selectedBtn.selected = NO;
    self.selectedBtn.userInteractionEnabled = YES;
    
    self.selectedBtn = button;
    self.selectedBtn.selected = YES;
    self.selectedBtn.userInteractionEnabled = button.tag != 1002 ? NO : YES;
    
    ProductSortType type = 1;
    switch (button.tag) {
        case 1000:
            type = ProductSortTypeDefault;
            break;
        case 1001:
            type = ProductSortTypeSalesVolume;
            break;
        default:
            type = _isAscSort ? ProductSortTypePriceAsc : ProductSortTypePriceDesc;
            break;
    }
    if (self.productSortBlock) {
        self.productSortBlock(type);
    }
    
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"综合",@"销量",@"价格"];
    }
    return _titleArray;
}

@end
