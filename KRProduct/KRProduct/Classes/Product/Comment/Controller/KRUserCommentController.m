//
//  KRUserCommentController.m
//  KRProduct
//
//  Created by LX on 2018/1/18.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRUserCommentController.h"
#import "KRUserCommentView.h"
#import "KRProductDetailModel.h"

@interface KRUserCommentController ()

@property (nonatomic, strong) KRUserCommentView *userCommentView;
@end

@implementation KRUserCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"用户评价";
    [self.view addSubview:self.userCommentView];
    
    KRProductDetailModel *model1 = [[KRProductDetailModel alloc] init];
    model1.messageSmallPics = @[@"url"];
    KRProductDetailModel *model3 = [[KRProductDetailModel alloc] init];
    KRProductDetailModel *model2 = [[KRProductDetailModel alloc] init];
    model2.messageSmallPics = @[@"url",@"url",@"url",@"url"];
    self.userCommentView.data = @[model1,model3,model2,model2,model2,model2];
}

- (KRUserCommentView *)userCommentView {
    if (!_userCommentView) {
        _userCommentView = [[KRUserCommentView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _userCommentView;
}
@end
