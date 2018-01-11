//
//  KRProductBasicView.m
//  KRProduct
//
//  Created by LX on 2018/1/9.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRProductBasicView.h"
#import <NewPagedFlowView.h>
#import <EllipsePageControl.h>
#import "KRProductBannerView.h"
#import <KRCustomPriceView.h>
#import <KRArrowIconRowView.h>
#import "KRCommentCell.h"
#import "KRProductDetailModel.h"

#define kProductPicHeight SCREEN_WIDTH-24
#define kProductBannerpHeight 10+kProductPicHeight+20

@interface KRProductBasicView () <NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

@property (nonatomic, strong) UIScrollView *goodsScrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
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
@property (nonatomic, strong) NSArray *images;
@end

@implementation KRProductBasicView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI {
    self.backgroundColor = GLOBAL_BACKGROUND_COLOR;
    
    [self addSubview:self.goodsScrollView];
    [_goodsScrollView addSubview:self.contentView];
    [_contentView addSubview:self.pageFlowView];
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
    [_contentView addSubview:self.storeHeadView];
    UIView *storeTopLineView = [self createGrayLineView];
    [_contentView addSubview:storeTopLineView];

    [_goodsScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_goodsScrollView);
        make.width.equalTo(_goodsScrollView);
    }];
    [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_contentView).offset(kProductBannerpHeight+10);
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
    

    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_storeHeadView.mas_bottom);
//        make.height.mas_equalTo(1800);
    }];
}

- (UIView *)createGrayLineView {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = GRAY_LINE_COLOR;
    return lineView;
}

#pragma mark - NewPagedFlowView Delegate

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    self.pageControl.currentPage = pageNumber;
}

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(kProductPicHeight, kProductPicHeight);
}

#pragma mark - NewPagedFlowView Datasource

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.images.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    KRProductBannerView *bannerView = (KRProductBannerView *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[KRProductBannerView alloc] init];
    }
    
    //[bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    
    //    bannerView.mainImageView.image = self.bannerArray[index];
    return bannerView;
}

#pragma mark - Setter/Getter
- (NSArray *)images {
    if (!_images) {
        _images = @[@"url",@"url",@"url",@"url"];
    }
    return _images;
}

- (UIScrollView *)goodsScrollView {
    if (!_goodsScrollView) {
        _goodsScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        _goodsScrollView.showsVerticalScrollIndicator = NO;
    }
    return _goodsScrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (NewPagedFlowView *)pageFlowView {
    if (!_pageFlowView) {
        NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, kProductPicHeight)];
        pageFlowView.delegate = self;
        pageFlowView.dataSource = self;
        pageFlowView.minimumPageAlpha = 0.4;
        pageFlowView.leftRightMargin = 15;
        pageFlowView.topBottomMargin = 0;
        pageFlowView.orginPageCount = self.images.count;
        pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView = pageFlowView;
        [_pageFlowView reloadData];
    }
    return _pageFlowView;
}

- (EllipsePageControl *)pageControl {
    if (!_pageControl) {
        EllipsePageControl *pageControl = [[EllipsePageControl alloc] initWithFrame:CGRectMake(0, kProductBannerpHeight-7.5, SCREEN_WIDTH, 4)];
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
        _attrsSelectView = [KRArrowIconRowView rowViewWithSize:CGSizeMake(SCREEN_WIDTH, 50) title:@"选择规格" subtitle:nil iconName:nil hiddenArrow:NO];
    }
    return _attrsSelectView;
}

- (KRArrowIconRowView *)commentHeadView {
    if (!_commentHeadView) {
        _commentHeadView = [KRArrowIconRowView rowViewWithSize:CGSizeMake(SCREEN_WIDTH, 50) title:@"用户评价" subtitle:nil iconName:nil hiddenArrow:NO];
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
        _storeHeadView = [KRArrowIconRowView rowViewWithSize:CGSizeMake(SCREEN_WIDTH, 50) title:@"连锁店铺" subtitle:nil iconName:nil hiddenArrow:NO];
    }
    return _storeHeadView;
}

@end
