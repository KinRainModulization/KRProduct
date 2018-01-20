//
//  KRStoreListController.m
//  KRProduct
//
//  Created by LX on 2018/1/5.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRStoreListController.h"
#import "KRStoreListView.h"
#import "KRStoreDetailController.h"

@interface KRStoreListController ()

@property (nonatomic, strong) KRStoreListView *storeListView;

@end

@implementation KRStoreListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"所有店铺";
    [self.view addSubview:self.storeListView];
    WEAK_SELF
    _storeListView.storeDetailBlock = ^{
        [weakSelf storeDetailClick];
    };
    
    self.storeListView.stores = @[@"data",@"data",@"data",@"data"];
}

- (void)storeDetailClick {
    [self.navigationController pushViewController:[[KRStoreDetailController alloc] init] animated:YES];
}

- (KRStoreListView *)storeListView {
    if (!_storeListView) {
        _storeListView = [[KRStoreListView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _storeListView;
}
@end
