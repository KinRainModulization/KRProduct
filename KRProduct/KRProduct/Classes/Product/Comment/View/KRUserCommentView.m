//
//  KRUserCommentView.m
//  KRProduct
//
//  Created by LX on 2018/1/18.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRUserCommentView.h"
#import "KRCommentCell.h"
#import "KRProductDetailModel.h"

static NSString *kCommentCellIdentifier = @"kCommentCellIdentifier";

@interface KRUserCommentView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation KRUserCommentView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = GLOBAL_BACKGROUND_COLOR;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[KRCommentCell class] forCellReuseIdentifier:kCommentCellIdentifier];
    }
    return self;
}

- (void)setData:(NSArray *)data {
    _data = data;
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KRCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:kCommentCellIdentifier forIndexPath:indexPath];
    //test
    KRProductDetailModel *model = self.data[indexPath.row];
    [cell configCellWithModel:model];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    KRProductDetailModel *model = self.data[indexPath.row];
    KRCommentCell *cell = [[KRCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCommentCellIdentifier];
    [cell configCellWithModel:model];
//    CGFloat rowHeight = [KRCommentCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
//        KRCommentCell *cell = (KRCommentCell *)sourceCell;
//        [cell configCellWithModel:model];
//    }];

//    MLog(@"[cell getCellHeight]=%f",rowHeight);
    return [cell getCellHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = GLOBAL_BACKGROUND_COLOR;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

@end
