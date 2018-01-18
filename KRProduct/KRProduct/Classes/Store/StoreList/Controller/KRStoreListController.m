//
//  KRStoreListController.m
//  KRProduct
//
//  Created by LX on 2018/1/5.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRStoreListController.h"
#import "KRStoreListView.h"

@interface KRStoreListController ()

@property (nonatomic, strong) KRStoreListView *storeListView;

@end

@implementation KRStoreListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"所有店铺";
    [self.view addSubview:self.storeListView];
    
    self.storeListView.stores = @[@"data",@"data",@"data",@"data"];
}

- (KRStoreListView *)storeListView {
    if (!_storeListView) {
        _storeListView = [[KRStoreListView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _storeListView;
}
@end
