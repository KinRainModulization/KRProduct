//
//  KRProductBasicView.m
//  KRProduct
//
//  Created by LX on 2018/1/9.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRProductBasicView.h"
#import <EllipsePageControl.h>
#import "KRBannerImageCell.h"
#import <KRCustomPriceView.h>
#import <KRArrowIconRowView.h>
#import "KRCommentCell.h"
#import "KRProductDetailModel.h"
#import "KRChainStoreCell.h"

#define kGoodsImgWidth SCREEN_WIDTH
#define kGoodsBannerHeight 10+kGoodsImgWidth+20
#define kBasicPullUpHeight 55

static NSString *kGoodsImageCellIdentifier = @"kGoodsImageCellIdentifier";

typedef enum {
    BasicViewPullStateUP = 1,
    BasicViewPullStateDown,
} BasicPullState;

@interface KRProductBasicView () <UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIScrollView *basicScrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UICollectionView *goodsImgCollectionView;
@property (nonatomic, strong) EllipsePageControl *pageControl;
@property (nonatomic, strong) UILabel *goodsNameLabel;
@property (nonatomic, strong) UILabel *goodsBriefLabel;
@property (nonatomic, strong) KRCustomPriceView *goodsPriceLabel;
@property (nonatomic, strong) UILabel *originalPriceLabel;
@property (nonatomic, strong) KRArrowIconRowView *attrsSelectView;

@property (nonatomic, strong) KRArrowIconRowView *commentHeadView;
@property (nonatomic, strong) UILabel *goodsScoreLabel;
@property (nonatomic, strong) UIView *commentView;
@property (nonatomic, strong) UIButton *allCommentBtn;
@property (nonatomic, strong) UILabel *allCommentLabel;

@property (nonatomic, strong) KRArrowIconRowView *storeHeadView;
@property (nonatomic, strong) KRChainStoreCell *storeView;

@property (nonatomic, strong) UIView *basicPullUpView;
@property (nonatomic, strong) UILabel *basicPullUpLabel;
@property (nonatomic, strong) UIImageView *basicPullUpImgView;

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) BasicPullState pullState;

@end

@implementation KRProductBasicView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
        [self handleBlock];
    }
    return self;
}

- (void)prepareUI {
    self.backgroundColor = GLOBAL_BACKGROUND_COLOR;
    
    [self addSubview:self.basicScrollView];
    [_basicScrollView addSubview:self.contentView];
    [_contentView addSubview:self.goodsImgCollectionView];
    [_contentView addSubview:self.pageControl];
    [_contentView addSubview:self.goodsNameLabel];
    [_contentView addSubview:self.goodsBriefLabel];
    [_contentView addSubview:self.goodsPriceLabel];
    [_contentView addSubview:self.originalPriceLabel];
    UIView *firstLineView = [self createGrayLineView];
    [_contentView addSubview:firstLineView];
    [_contentView addSubview:self.attrsSelectView];
    UIView *secondLineView = [self createGrayLineView];
    [_contentView addSubview:secondLineView];
    [_contentView addSubview:self.commentHeadView];
    [_commentHeadView addSubview:self.goodsScoreLabel];
    UIView *commentLineView = [self createGrayLineView];
    [_contentView addSubview:commentLineView];
    [_contentView addSubview:self.commentView];
    [_contentView addSubview:self.allCommentBtn];
    [_allCommentBtn addSubview:self.allCommentLabel];
    UIView *storeTopLineView = [self createGrayLineView];
    [_contentView addSubview:storeTopLineView];
    [_contentView addSubview:self.storeHeadView];
    UIView *storeBottomLineView = [self createGrayLineView];
    [_storeHeadView addSubview:storeBottomLineView];
    [_contentView addSubview:self.storeView];
    [_contentView addSubview:self.basicPullUpView];
    UIView *leftLineView = [[UIView alloc] init];
    leftLineView.backgroundColor = RGB(230, 230, 230);
    [_basicPullUpView addSubview:leftLineView];
    UIView *rightLineView = [[UIView alloc] init];
    rightLineView.backgroundColor = RGB(230, 230, 230);
    [_basicPullUpView addSubview:rightLineView];
    [_basicPullUpView addSubview:self.basicPullUpLabel];
    [_basicPullUpView addSubview:self.basicPullUpImgView];

    [_basicScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_basicScrollView);
        make.width.equalTo(_basicScrollView);
    }];
    [_goodsImgCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView).offset(10);
        make.leading.trailing.equalTo(_contentView);
        make.height.mas_offset(kGoodsImgWidth);
    }];
    [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView).offset(kGoodsBannerHeight+10);
        make.leading.equalTo(_contentView).offset(12);
        make.trailing.equalTo(_contentView).offset(-12);
    }];
    [_goodsBriefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsNameLabel.mas_bottom).offset(10);
        make.leading.trailing.equalTo(_goodsNameLabel);
    }];
    [_goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsBriefLabel.mas_bottom).offset(16);
        make.leading.equalTo(_goodsNameLabel);
        make.size.mas_equalTo(_goodsPriceLabel.size);
    }];
    [_originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_goodsPriceLabel.mas_trailing).offset(10.5);
        make.bottom.equalTo(_goodsPriceLabel).offset(-2);
    }];
    [firstLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_goodsPriceLabel.mas_bottom).offset(15);
        make.leading.trailing.equalTo(_contentView);
        make.height.mas_equalTo(10);
    }];
    [_attrsSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstLineView.mas_bottom);
        make.leading.trailing.equalTo(_contentView);
        make.height.mas_equalTo(50);
    }];
    [secondLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_attrsSelectView.mas_bottom);
        make.leading.trailing.height.equalTo(firstLineView);
    }];
    [_commentHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondLineView.mas_bottom);
        make.leading.trailing.height.equalTo(_attrsSelectView);
    }];
    [_goodsScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_commentHeadView);
        make.trailing.equalTo(_commentHeadView).offset(-32);
    }];
    [commentLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentHeadView.mas_bottom);
        make.leading.trailing.equalTo(_goodsNameLabel);
        make.height.mas_equalTo(0.5);
    }];
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentLineView.mas_bottom);
        make.leading.trailing.equalTo(_contentView);
    }];
    
    
    // test
    CGFloat commentH = 0;
    for (int i = 0; i < 3; i++) {
        KRCommentCell *cell = [[KRCommentCell alloc] init];
        cell.y = commentH;
        cell.width = SCREEN_WIDTH;
        [_commentView addSubview:cell];
        KRProductDetailModel *model = [[KRProductDetailModel alloc] init];
        model.messageSmallPics = @[@"1",@"2",@"2",@"2"];
        model.numberOfLine = 2;
        [cell configCellWithModel:model];
        CGFloat cellH = [cell getCellHeight];
        commentH += cellH;
    }
    [_commentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(commentH);
    }];
    
    
    [_allCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentView.mas_bottom);
        make.leading.trailing.height.equalTo(_commentHeadView);
    }];
    [_allCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_allCommentBtn);
        make.size.mas_equalTo(CGSizeMake(97, 25));
    }];
    [storeTopLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_allCommentBtn.mas_bottom);
        make.leading.trailing.height.equalTo(firstLineView);
    }];
    [_storeHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(storeTopLineView.mas_bottom);
        make.leading.trailing.height.equalTo(_commentHeadView);
    }];
    [storeBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_storeHeadView);
        make.leading.equalTo(_storeHeadView).offset(12);
        make.trailing.equalTo(_storeHeadView).offset(-12);
        make.height.mas_equalTo(0.5);
    }];
    [_storeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeHeadView.mas_bottom);
        make.leading.trailing.equalTo(_contentView);
        make.height.mas_equalTo(90);
    }];
    [_basicPullUpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeView.mas_bottom);
        make.leading.trailing.equalTo(_contentView);
        make.height.mas_equalTo(kBasicPullUpHeight);
    }];
    [_basicPullUpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_basicPullUpView).offset(-10);
        make.centerX.equalTo(_basicPullUpView);
    }];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_basicPullUpLabel);
        make.leading.equalTo(_basicPullUpView).offset(13);
        make.trailing.equalTo(_basicPullUpLabel.mas_leading).offset(-13);
        make.height.mas_equalTo(0.5);
    }];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(leftLineView);
        make.leading.equalTo(_basicPullUpLabel.mas_trailing).offset(13);
        make.trailing.equalTo(_basicPullUpView).offset(-13);
    }];
    [_basicPullUpImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_basicPullUpLabel.mas_bottom).offset(2);
        make.centerX.equalTo(_basicPullUpView);
    }];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_basicPullUpView.mas_bottom);
    }];
}

- (UIView *)createGrayLineView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = GRAY_LINE_COLOR;
    return lineView;
}

- (void)pullStateChange {
    self.basicPullUpLabel.text = _pullState ==  BasicViewPullStateDown ? @"释放查看图文详情" : @"上拉查看图文详情";
    [UIView animateWithDuration:0.25 animations:^{
        self.basicPullUpImgView.transform = CGAffineTransformMakeRotation(_pullState ==  BasicViewPullStateDown ? 0.0001 : M_PI);
    }];
}

#pragma mark - Action

- (void)allCommentBtnClick {
    if ([self.delegate respondsToSelector:@selector(userCommentClick:)]) {
        [self.delegate userCommentClick:self];
    }
}

- (void)handleBlock {
    WEAK_SELF
    _attrsSelectView.rowDidClickBlock = ^{
        if ([weakSelf.delegate respondsToSelector:@selector(productSelectAttributes:)]) {
            [weakSelf.delegate productSelectAttributes:weakSelf];
        }
    };
    _commentHeadView.rowDidClickBlock = ^{
        [weakSelf allCommentBtnClick];
    };
    _storeHeadView.rowDidClickBlock = ^{
        if ([weakSelf.delegate respondsToSelector:@selector(chainStoreClick:)]) {
            [weakSelf.delegate chainStoreClick:weakSelf];
        }
    };
    _storeView.storeHotlineBlock = ^{
        if ([weakSelf.delegate respondsToSelector:@selector(storeHotlineClick:)]) {
            [weakSelf.delegate storeHotlineClick:weakSelf];
        }
    };
    _storeView.storeDetailBlock = ^{
        if ([weakSelf.delegate respondsToSelector:@selector(storeDetailClick:)]) {
            [weakSelf.delegate storeDetailClick:weakSelf];
        }
    };
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _basicScrollView) {
        CGFloat offsetY = scrollView.contentOffset.y;
        CGFloat scrollH = scrollView.size.height;
        CGFloat threshold = 20;
        if (offsetY + scrollH > scrollView.contentSize.height + threshold) {
            _pullState = BasicViewPullStateDown;
        }
        else {
            _pullState = BasicViewPullStateUP;
        }
        [self pullStateChange];
    }
    else if (scrollView == _goodsImgCollectionView) {
        NSInteger pageNumber = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
        self.pageControl.currentPage = pageNumber;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KRBannerImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kGoodsImageCellIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark - Setter/Getter

- (NSArray *)images {
    if (!_images) {
        _images = @[@"url",@"url",@"url",@"url"];
    }
    return _images;
}

- (UIScrollView *)basicScrollView {
    if (!_basicScrollView) {
        _basicScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _basicScrollView.showsVerticalScrollIndicator = NO;
        _basicScrollView.delegate = self;
    }
    return _basicScrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UICollectionView *)goodsImgCollectionView {
    if (!_goodsImgCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kGoodsImgWidth, kGoodsImgWidth);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        _goodsImgCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _goodsImgCollectionView.backgroundColor = GLOBAL_BACKGROUND_COLOR;
        _goodsImgCollectionView.showsHorizontalScrollIndicator = NO;
        _goodsImgCollectionView.pagingEnabled = YES;
        _goodsImgCollectionView.dataSource = self;
        _goodsImgCollectionView.delegate = self;
        [_goodsImgCollectionView registerClass:[KRBannerImageCell class] forCellWithReuseIdentifier:kGoodsImageCellIdentifier];
    }
    return _goodsImgCollectionView;
}

- (EllipsePageControl *)pageControl {
    if (!_pageControl) {
        EllipsePageControl *pageControl = [[EllipsePageControl alloc] initWithFrame:CGRectMake(0, kGoodsBannerHeight-7.5, SCREEN_WIDTH, 4)];
        pageControl.numberOfPages = self.images.count;
        pageControl.otherColor = RGB(220, 220, 220);
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [UILabel labelWithText:@"商品名商品名商品名商品名商品名商品名商品名商品名商品名商品名商品名商品名商品名" textColor:FONT_COLOR_33 fontSize:16];
        _goodsNameLabel.numberOfLines = 2;
    }
    return _goodsNameLabel;
}

- (UILabel *)goodsBriefLabel {
    if (!_goodsBriefLabel) {
        _goodsBriefLabel = [UILabel labelWithText:@"商品简介" textColor:FONT_COLOR_99 fontSize:14];
        _goodsBriefLabel.numberOfLines = 1;
    }
    return _goodsBriefLabel;
}

- (KRCustomPriceView *)goodsPriceLabel {
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [KRCustomPriceView customPriceViewWithPrice:@"0.00" integerFontSize:24 decimalFontSize:18];
    }
    return _goodsPriceLabel;
}

- (UILabel *)originalPriceLabel {
    if (!_originalPriceLabel) {
        _originalPriceLabel = [UILabel labelWithText:@"" textColor:FONT_COLOR_99 fontSize:12];
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:@"￥1.11" attributes:attribtDic];
        _originalPriceLabel.attributedText = attribtStr;
    }
    return _originalPriceLabel;
}

- (KRArrowIconRowView *)attrsSelectView {
    if (!_attrsSelectView) {
        _attrsSelectView = [KRArrowIconRowView rowViewWithTitle:@"选择规格" subtitle:nil iconName:nil hiddenArrow:NO];
    }
    return _attrsSelectView;
}

- (KRArrowIconRowView *)commentHeadView {
    if (!_commentHeadView) {
        _commentHeadView = [KRArrowIconRowView rowViewWithTitle:@"用户评价" subtitle:nil iconName:nil hiddenArrow:NO];
    }
    return _commentHeadView;
}

- (UILabel *)goodsScoreLabel {
    if (!_goodsScoreLabel) {
        _goodsScoreLabel = [[UILabel alloc] init];
        _goodsScoreLabel.font = [UIFont systemFontOfSize:12];
        NSMutableAttributedString *attrStr =[[NSMutableAttributedString alloc] initWithString:@"好评率 90%"];
        NSRange titleRange=[[attrStr string] rangeOfString:@"好评率"];
        [attrStr addAttribute:NSForegroundColorAttributeName value:FONT_COLOR_99 range:titleRange];
        NSRange scoreRange=[[attrStr string] rangeOfString:@"90%"];
        [attrStr addAttribute:NSForegroundColorAttributeName value:RGB(255, 0, 54) range:scoreRange];
        _goodsScoreLabel.attributedText = attrStr;
    }
    return _goodsScoreLabel;
}

- (UIView *)commentView {
    if (!_commentView) {
        _commentView = [[UIView alloc] init];
    }
    return _commentView;
}

- (UIButton *)allCommentBtn {
    if (!_allCommentBtn) {
        _allCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allCommentBtn addTarget:self action:@selector(allCommentBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allCommentBtn;
}

- (UILabel *)allCommentLabel {
    if (!_allCommentLabel) {
        _allCommentLabel = [UILabel labelWithText:@"查看所有评价" textColor:GLOBAL_COLOR fontSize:12];
        _allCommentLabel.textAlignment = NSTextAlignmentCenter;
        _allCommentLabel.layer.cornerRadius = 12.5;
        _allCommentLabel.layer.borderWidth = 1;
        _allCommentLabel.layer.borderColor = GLOBAL_COLOR.CGColor;
    }
    return _allCommentLabel;
}

- (KRArrowIconRowView *)storeHeadView {
    if (!_storeHeadView) {
        _storeHeadView = [KRArrowIconRowView rowViewWithTitle:@"连锁店铺" subtitle:nil iconName:nil hiddenArrow:NO];
    }
    return _storeHeadView;
}

- (KRChainStoreCell *)storeView {
    if (!_storeView) {
        _storeView = [[KRChainStoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    return _storeView;
}

- (UIView *)basicPullUpView {
    if (!_basicPullUpView) {
        _basicPullUpView = [[UIView alloc] init];
        _basicPullUpView.backgroundColor = GLOBAL_BACKGROUND_COLOR;
    }
    return _basicPullUpView;
}

- (UILabel *)basicPullUpLabel {
    if (!_basicPullUpLabel) {
        _basicPullUpLabel = [UILabel labelWithText:@"上拉查看图文详情" textColor:FONT_COLOR_99 fontSize:12];
    }
    return _basicPullUpLabel;
}

- (UIImageView *)basicPullUpImgView {
    if (!_basicPullUpImgView) {
        _basicPullUpImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_pull_arrow"]];
    }
    return _basicPullUpImgView;
}

@end
