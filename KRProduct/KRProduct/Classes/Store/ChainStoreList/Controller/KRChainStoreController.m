//
//  KRChainStoreController.m
//  KRProduct
//
//  Created by LX on 2018/1/18.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRChainStoreController.h"
#import "KRChainStoreView.h"

@interface KRChainStoreController ()
@property (nonatomic, strong) KRChainStoreView *chainStoreView;
@end

@implementation KRChainStoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"连锁店铺";
    [self.view addSubview:self.chainStoreView];
    self.chainStoreView.stores = @[@"data",@"data",@"data",@"data"];
}

- (void)storeHotlineButtonClick {
    MLog(@"storeHotlineButtonClick");
}

- (KRChainStoreView *)chainStoreView {
    if (!_chainStoreView) {
        _chainStoreView = [[KRChainStoreView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        WEAK_SELF
        _chainStoreView.storeHotlineBlock = ^{
            [weakSelf storeHotlineButtonClick];
        };
    }
    return _chainStoreView;
}
@end
