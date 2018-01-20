//
//  KRSecondaryCategoriesVC.m
//  KRProduct
//
//  Created by LX on 2018/1/19.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRSecondaryCategoriesVC.h"
#import "KRProductListView.h"
#import "KRProductController.h"

@interface KRSecondaryCategoriesVC ()

@property (nonatomic, strong) KRProductListView *productListView;

@end

@implementation KRSecondaryCategoriesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"分类名";
    [self.view addSubview:self.productListView];
    
    WEAK_SELF
    _productListView.productSortBlock = ^(ProductSortType sortType) {
        [weakSelf productSortWithType:sortType];
    };
    _productListView.productDetailBlock = ^{
        [weakSelf productDetailClick];
    };
    
}

- (void)productDetailClick {
    [self.navigationController pushViewController:[[KRProductController alloc] init] animated:YES];
}

- (void)productSortWithType:(ProductSortType)sortType {
    MLog(@"sortType=%d",sortType);
}

- (KRProductListView *)productListView {
    if (!_productListView) {
        _productListView = [[KRProductListView alloc] initWithFrame:self.view.bounds];
    }
    return _productListView;
}

@end
