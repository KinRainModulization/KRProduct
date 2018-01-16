//
//  ViewController.m
//  KRProduct
//
//  Created by LX on 2018/1/8.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "ViewController.h"
#import "KRProductController.h"
#import "KRStoreDetailController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *productBtn = [UIButton buttonWithTitle:@"跳转商品详情" fontSize:18 titleColor:[UIColor blueColor] target:self action:@selector(productBtnClick)];
    [self.view addSubview:productBtn];
    UIButton *storeBtn = [UIButton buttonWithTitle:@"跳转店铺详情" fontSize:18 titleColor:[UIColor blueColor] target:self action:@selector(storeBtnClick)];
    storeBtn.frame = CGRectMake(0, 100, storeBtn.width, storeBtn.height);
    [self.view addSubview:storeBtn];
}

- (void)productBtnClick {
    [self.navigationController pushViewController:[[KRProductController alloc] init] animated:YES];
}

- (void)storeBtnClick {
    [self.navigationController pushViewController:[[KRStoreDetailController alloc] init] animated:YES];
}

@end
