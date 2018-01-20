//
//  KRStoreListView.m
//  KRProduct
//
//  Created by LX on 2018/1/18.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRStoreListView.h"
#import "KRStoreListCell.h"

static NSString *kStoreListCellIdentifier = @"kStoreListCellIdentifier";

@interface KRStoreListView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation KRStoreListView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.backgroundColor = GLOBAL_BACKGROUND_COLOR;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[KRStoreListCell class] forCellReuseIdentifier:kStoreListCellIdentifier];
    }
    return self;
}

- (void)setStores:(NSArray *)stores {
    _stores = stores;
    [self reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.storeDetailBlock) {
        self.storeDetailBlock();
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KRStoreListCell *cell = [tableView dequeueReusableCellWithIdentifier:kStoreListCellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
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
