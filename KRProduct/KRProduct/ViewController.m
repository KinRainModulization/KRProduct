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
#import "KRStoreListController.h"
#import "KRChainStoreController.h"
#import "KRUserCommentController.h"
#import "KRSecondaryCategoriesVC.h"

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
    
    UIButton *storeListBtn = [UIButton buttonWithTitle:@"跳转所有店铺列表" fontSize:18 titleColor:[UIColor blueColor] target:self action:@selector(storeListBtnClick)];
    storeListBtn.frame = CGRectMake(0, 200, storeListBtn.width, storeListBtn.height);
    [self.view addSubview:storeListBtn];
    
    UIButton *chainStoreBtn = [UIButton buttonWithTitle:@"跳转连锁店铺" fontSize:18 titleColor:[UIColor blueColor] target:self action:@selector(chainStoreBtnClick)];
    chainStoreBtn.frame = CGRectMake(0, 300, chainStoreBtn.width, chainStoreBtn.height);
    [self.view addSubview:chainStoreBtn];
    
    UIButton *commentBtn = [UIButton buttonWithTitle:@"跳转用户评价" fontSize:18 titleColor:[UIColor blueColor] target:self action:@selector(commentBtnClick)];
    commentBtn.frame = CGRectMake(0, 400, chainStoreBtn.width, chainStoreBtn.height);
    [self.view addSubview:commentBtn];
    
    UIButton *categoryBtn = [UIButton buttonWithTitle:@"跳转分类列表" fontSize:18 titleColor:[UIColor blueColor] target:self action:@selector(categoryBtnClick)];
    categoryBtn.frame = CGRectMake(0, 500, chainStoreBtn.width, chainStoreBtn.height);
    [self.view addSubview:categoryBtn];
}

- (void)productBtnClick {
    [self.navigationController pushViewController:[[KRProductController alloc] init] animated:YES];
}

- (void)storeBtnClick {
    [self.navigationController pushViewController:[[KRStoreDetailController alloc] init] animated:YES];
}

- (void)storeListBtnClick {
    [self.navigationController pushViewController:[[KRStoreListController alloc] init] animated:YES];
}

- (void)chainStoreBtnClick {
    [self.navigationController pushViewController:[[KRChainStoreController alloc] init] animated:YES];
}

- (void)commentBtnClick {
    [self.navigationController pushViewController:[[KRUserCommentController alloc] init] animated:YES];
}

- (void)categoryBtnClick {
    [self.navigationController pushViewController:[[KRSecondaryCategoriesVC alloc] init] animated:YES];
}
@end
