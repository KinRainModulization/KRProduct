//
//  ViewController.m
//  KRProduct
//
//  Created by LX on 2018/1/8.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "ViewController.h"
#import "KRProductController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithTitle:@"跳转商品详情" fontSize:18 titleColor:[UIColor blueColor] target:self action:@selector(productBtnClick)];
    [self.view addSubview:button];
}

- (void)productBtnClick {
    [self.navigationController pushViewController:[[KRProductController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
