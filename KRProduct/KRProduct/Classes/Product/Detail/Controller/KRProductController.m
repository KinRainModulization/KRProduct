//
//  KRProductController.m
//  KRProductController
//
//  Created by LX on 2018/1/5.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRProductController.h"
#import "TYPagerView.h"
#import "TYTabPagerBar.h"
#import "KRProductBottomView.h"
#import "KRProductBasicView.h"

#define kProductPageViewHeight SCREEN_HEIGHT-kProductBottomViewHeight

static const CGFloat kProductBottomViewHeight = 47;

@interface KRProductController () <UIScrollViewDelegate,TYTabPagerBarDataSource,TYTabPagerBarDelegate>

@property (nonatomic, weak) TYTabPagerBar *tabBar;

@property (nonatomic, weak) UIScrollView *pageScrollView;

@property (nonatomic, weak) KRProductBottomView *bottomView;

@property (nonatomic, weak) KRProductBasicView *productBasicView;

@property (nonatomic, strong) NSArray *datas;

@property (nonatomic, strong) NSArray *pages;

@property (nonatomic, assign) CGFloat preOffsetX;

@property (nonatomic, assign) NSInteger countOfPagerItems;

@end

@implementation KRProductController

typedef NS_ENUM(NSUInteger, PagerScrollingDirection) {
    PagerScrollingLeft,
    PagerScrollingRight,
};

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"ic_share" withTarget:self withAction:@selector(shareBtnClick)];
    [self addPagerTabBar];
    [self addPagerScrollView];
    [self addBottomView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _tabBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), NAV_BAR_HEIGHT);
    _pageScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, kProductPageViewHeight);
    _bottomView.frame = CGRectMake(0, SCREEN_HEIGHT-NAV_BAR_HEIGHT-kProductBottomViewHeight, SCREEN_WIDTH, kProductBottomViewHeight);
}

- (void)addPagerTabBar {
    TYTabPagerBar *tabBar = [[TYTabPagerBar alloc]init];
    tabBar.layout.barStyle = TYPagerBarStyleProgressView;
    tabBar.layout.progressColor = GLOBAL_COLOR;
    tabBar.layout.normalTextColor = FONT_COLOR_99;
    tabBar.layout.normalTextFont = [UIFont systemFontOfSize:18];
    tabBar.layout.selectedTextColor = FONT_COLOR_33;
    tabBar.layout.selectedTextFont = [UIFont systemFontOfSize:18];
    tabBar.dataSource = self;
    tabBar.delegate = self;
    tabBar.layout.adjustContentCellsCenter = YES;
    [tabBar registerClass:[TYTabPagerBarCell class] forCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier]];
    self.navigationItem.titleView = tabBar;
    _tabBar = tabBar;
}

- (void)addPagerScrollView {
    _countOfPagerItems = self.pages.count;

    UIScrollView *pageScrollView = [[UIScrollView alloc] init];
    pageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2, kProductPageViewHeight);
    pageScrollView.delegate = self;
    pageScrollView.pagingEnabled = YES;
    [self.view addSubview:pageScrollView];
    _pageScrollView = pageScrollView;
    
    KRProductBasicView *productBasicView = [[KRProductBasicView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kProductPageViewHeight-NAV_BAR_HEIGHT)];
    _productBasicView = productBasicView;
    [pageScrollView addSubview:productBasicView];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, kProductPageViewHeight)];
    view.backgroundColor = [UIColor blueColor];
    [pageScrollView addSubview:view];
}

#pragma mark - Action

- (void)addBottomView {
    KRProductBottomView *bottom = [[KRProductBottomView alloc] init];
    [self.view addSubview:bottom];
    _bottomView = bottom;
}

- (void)shareBtnClick {
    MLog(@"shareBtnClick");
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    PagerScrollingDirection direction = offsetX >= _preOffsetX ? PagerScrollingLeft : PagerScrollingRight;
    
    if (CGRectIsEmpty(scrollView.frame)) {
        return;
    }

    CGFloat width = CGRectGetWidth(scrollView.frame);
    CGFloat floadIndex = offsetX/width;
    NSInteger floorIndex = floor(floadIndex);
    if (floorIndex < 0 || floorIndex >= _countOfPagerItems || floadIndex > _countOfPagerItems-1) {
        return;
    }
    
    CGFloat progress = offsetX/width-floorIndex;
    NSInteger fromIndex = 0, toIndex = 0;
    if (direction == PagerScrollingLeft) {
        fromIndex = floorIndex;
        toIndex = MIN(_countOfPagerItems -1, fromIndex + 1);
        if (fromIndex == toIndex && toIndex == _countOfPagerItems-1) {
            fromIndex = _countOfPagerItems-2;
            progress = 1.0;
        }
    }else {
        toIndex = floorIndex;
        fromIndex = MIN(_countOfPagerItems-1, toIndex +1);
        progress = 1.0 - progress;
    }
    [_tabBar scrollToItemFromIndex:fromIndex toIndex:toIndex progress:progress];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _preOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewWillScrollToView:(UIScrollView *)scrollView animate:(BOOL)animate {
    _preOffsetX = scrollView.contentOffset.x;
}

#pragma mark - TYTabPagerBarDataSource

- (NSInteger)numberOfItemsInPagerTabBar {
    return self.pages.count;
}

- (UICollectionViewCell<TYTabPagerBarCellProtocol> *)pagerTabBar:(TYTabPagerBar *)pagerTabBar cellForItemAtIndex:(NSInteger)index {
    UICollectionViewCell<TYTabPagerBarCellProtocol> *cell = [pagerTabBar dequeueReusableCellWithReuseIdentifier:[TYTabPagerBarCell cellIdentifier] forIndex:index];
    cell.titleLabel.text = self.pages[index];
    return cell;
}

#pragma mark - TYTabPagerBarDelegate

- (CGFloat)pagerTabBar:(TYTabPagerBar *)pagerTabBar widthForItemAtIndex:(NSInteger)index {
    NSString *title = self.pages[index];
    return [pagerTabBar cellWidthForTitle:title];
}

- (void)pagerTabBar:(TYTabPagerBar *)pagerTabBar didSelectItemAtIndex:(NSInteger)index {
    [pagerTabBar scrollToItemFromIndex:index toIndex:index animate:YES];
    [_pageScrollView setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0) animated:NO];
}

- (NSArray *)pages {
    if (!_pages) {
        _pages = @[@"商品",@"店铺"];
    }
    return _pages;
}
@end
