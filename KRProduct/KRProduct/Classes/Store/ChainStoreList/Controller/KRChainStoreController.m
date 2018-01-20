//
//  KRChainStoreController.m
//  KRProduct
//
//  Created by LX on 2018/1/18.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRChainStoreController.h"
#import "KRChainStoreView.h"
#import "KRStoreDetailController.h"

@interface KRChainStoreController ()
@property (nonatomic, strong) KRChainStoreView *chainStoreView;
@end

@implementation KRChainStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"连锁店铺";
    [self.view addSubview:self.chainStoreView];
    WEAK_SELF
    _chainStoreView.storeHotlineBlock = ^{
        [weakSelf storeHotlineClick];
    };
    _chainStoreView.storeDetailBlock = ^{
        [weakSelf storeDetailClick];
    };
    self.chainStoreView.stores = @[@"data",@"data",@"data",@"data"];
}

- (void)storeHotlineClick {
    MLog(@"storeHotlineButtonClick");
}

- (void)storeDetailClick {
    [self.navigationController pushViewController:[[KRStoreDetailController alloc] init] animated:YES];
}

- (KRChainStoreView *)chainStoreView {
    if (!_chainStoreView) {
        _chainStoreView = [[KRChainStoreView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _chainStoreView;
}
@end
