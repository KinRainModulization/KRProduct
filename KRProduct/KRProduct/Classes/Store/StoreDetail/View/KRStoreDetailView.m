//
//  KRStoreDetailView.m
//  KRProduct
//
//  Created by LX on 2018/1/16.
//  Copyright © 2018年 Ace. All rights reserved.
//

#import "KRStoreDetailView.h"
#import "KRBannerImageCell.h"
#import <KRArrowIconRowView.h>
#import "KRVisagisteCell.h"
#import "KRCommentCell.h"
#import "KRProductDetailModel.h"

#define kSotreImgHeight SCREEN_WIDTH / 375 * 207
#define kVisagisteImageWidth (SCREEN_WIDTH-12-3*15) / 3.3
#define kVisagisteViewHeight kVisagisteImageWidth + 37

static NSString *kStoreImageCellIdentifier = @"kStoreImageCellIdentifier";
static NSString *kVisagisteCellIdentifier = @"kVisagisteCellIdentifier";

@interface KRStoreDetailView ()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UICollectionView *storeImgCollectionView;
@property (nonatomic, strong) UILabel *imageCountLabel;
@property (nonatomic, strong) UILabel *storeNameLabel;
@property (nonatomic, strong) UILabel *storeDistanceLabel;
@property (nonatomic, strong) UILabel *storeScoreLabel;
@property (nonatomic, strong) UILabel *storeAddressLabel;
@property (nonatomic, strong) UIButton *storeHotlineBtn;

@property (nonatomic, strong) UILabel *businessInfoLabel;
@property (nonatomic, strong) UILabel *businessTimeLabel;
@property (nonatomic, strong) UIView *businessTimeView;
@property (nonatomic, strong) UILabel *storeNoticeLabel;
@property (nonatomic, strong) UIView *storeNoticeView;

@property (nonatomic, strong) UILabel *visagisteHeadView;
@property (nonatomic, strong) UICollectionView *visagisteCollectionView;

@property (nonatomic, strong) KRArrowIconRowView *chainStoreView;

@property (nonatomic, strong) KRArrowIconRowView *commentHeadView;
@property (nonatomic, strong) UILabel *goodsScoreLabel;
@property (nonatomic, strong) UIView *commentView;
@property (nonatomic, strong) UIButton *allCommentBtn;
@property (nonatomic, strong) UILabel *allCommentLabel;


@end

@implementation KRStoreDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self prepareUI];
        
//        [self.storeImgCollectionView setContentOffset:CGPointMake(1, 0) animated:NO];
    }
    return self;
}

- (void)prepareUI {
    [self addSubview:self.scrollView];
    [_scrollView addSubview:self.contentView];
    
    [_contentView addSubview:self.storeImgCollectionView];
    [_contentView addSubview:self.imageCountLabel];
    [_contentView addSubview:self.storeNameLabel];
    UIImageView *distanceImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_located"]];
    [_contentView addSubview:distanceImgView];
    [_contentView addSubview:self.storeDistanceLabel];
    UIImageView *scoreImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_rated_score"]];
    [_contentView addSubview:scoreImgView];
    [_contentView addSubview:self.storeScoreLabel];
    UIView *basicLineView = [self createLineViewWithColor:GRAY_LINE_COLOR];
    [_contentView addSubview:basicLineView];
    UIImageView *addressImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_get_location"]];
    [_contentView addSubview:addressImgView];
    [_contentView addSubview:self.storeAddressLabel];
    [_contentView addSubview:self.storeHotlineBtn];
    UIView *basicBottomLineView = [self createLineViewWithColor:GLOBAL_BACKGROUND_COLOR];
    [_contentView addSubview:basicBottomLineView];
    
    [_contentView addSubview:self.businessInfoLabel];
    UIView *businessLineView = [self createLineViewWithColor:GRAY_LINE_COLOR];
    [_contentView addSubview:businessLineView];
    [_contentView addSubview:self.businessTimeLabel];
    [_contentView addSubview:self.businessTimeView];
    [_contentView addSubview:self.storeNoticeLabel];
    [_contentView addSubview:self.storeNoticeView];
    UIView *businessBottomLineView = [self createLineViewWithColor:GLOBAL_BACKGROUND_COLOR];
    [_contentView addSubview:businessBottomLineView];
    
    [_contentView addSubview:self.visagisteHeadView];
    UIView *visagisteLineView = [self createLineViewWithColor:GRAY_LINE_COLOR];
    [_contentView addSubview:visagisteLineView];
    [_contentView addSubview:self.visagisteCollectionView];
    
    UIView *chainStoreTopLineView = [self createLineViewWithColor:GLOBAL_BACKGROUND_COLOR];
    [_contentView addSubview:chainStoreTopLineView];
    [_contentView addSubview:self.chainStoreView];
    UIView *chainStoreBottomLineView = [self createLineViewWithColor:GLOBAL_BACKGROUND_COLOR];
    [_contentView addSubview:chainStoreBottomLineView];
    
    [_contentView addSubview:self.commentHeadView];
    [_commentHeadView addSubview:self.goodsScoreLabel];
    UIView *commentLineView = [self createLineViewWithColor:GRAY_LINE_COLOR];
    [_contentView addSubview:commentLineView];
    [_contentView addSubview:self.commentView];
    [_contentView addSubview:self.allCommentBtn];
    [_allCommentBtn addSubview:self.allCommentLabel];


    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
    }];
    [_storeImgCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(_contentView);
        make.height.mas_equalTo(kSotreImgHeight);
    }];
    [_imageCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.equalTo(_storeImgCollectionView);
        make.size.mas_equalTo(CGSizeMake(45, 17));
    }];
    [_storeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeImgCollectionView.mas_bottom).offset(15);
        make.leading.equalTo(_contentView).offset(12);
        make.trailing.equalTo(_contentView).offset(-12);
    }];
    [basicLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeImgCollectionView.mas_bottom).offset(85);
        make.leading.trailing.equalTo(_storeNameLabel);
        make.height.mas_equalTo(0.5);
    }];
    [distanceImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_storeNameLabel);
        make.bottom.equalTo(basicLineView.mas_top).offset(-15);
    }];
    [_storeDistanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(distanceImgView);
        make.leading.equalTo(distanceImgView.mas_trailing).offset(6);
    }];
    [scoreImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(distanceImgView);
        make.leading.equalTo(_storeDistanceLabel.mas_trailing).offset(12);
    }];
    [_storeScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(distanceImgView);
        make.leading.equalTo(scoreImgView.mas_trailing).offset(6);
    }];
    [addressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(basicLineView.mas_bottom).offset(16);
        make.leading.equalTo(_storeNameLabel);
    }];
    [_storeAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(basicLineView.mas_bottom).offset(13);
        make.leading.equalTo(addressImgView.mas_trailing).offset(10);
        make.trailing.equalTo(_storeNameLabel);
    }];
    [_storeHotlineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeAddressLabel.mas_bottom);
        make.leading.trailing.equalTo(_storeNameLabel);
        make.height.mas_equalTo(50);
    }];
    [basicBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeHotlineBtn.mas_bottom);
        make.leading.trailing.equalTo(_contentView);
        make.height.mas_equalTo(10);
    }];
    [_businessInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(basicBottomLineView.mas_bottom);
        make.leading.trailing.equalTo(_storeNameLabel);
        make.height.mas_equalTo(50);
    }];
    [businessLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_businessInfoLabel.mas_bottom);
        make.leading.trailing.equalTo(_businessInfoLabel);
        make.height.mas_equalTo(0.5);
    }];
    [_businessTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(businessLineView.mas_bottom).offset(13);
        make.leading.equalTo(_contentView).offset(14);
    }];
    [_businessTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_businessTimeLabel);
        make.leading.equalTo(_businessTimeLabel.mas_trailing).offset(10);
        make.trailing.equalTo(_contentView).offset(-10);
    }];
    
    // -----test
    UILabel *tempLabel = nil;
    for (int i = 0; i < 2; ++i) {
        UILabel *label = [UILabel labelWithText:@"周一、周一、周一、周日10:00-21:00、14:00-21:30" textColor:FONT_COLOR_66 fontSize:14];
        label.numberOfLines = 0;
        label.x = 0;
        label.y = tempLabel ? CGRectGetMaxY(tempLabel.frame)+17 : 0;
        label.width = SCREEN_WIDTH-95;
        [label sizeToFit];
        [_businessTimeView addSubview:label];
        tempLabel = label;
    }
    [_businessTimeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(CGRectGetMaxY(tempLabel.frame)+17);
    }];
    //-------
    
    [_storeNoticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_businessTimeView.mas_bottom).offset(4);
        make.leading.equalTo(_businessTimeLabel);
    }];
    [_storeNoticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeNoticeLabel);
        make.leading.trailing.equalTo(_businessTimeView);
        make.height.mas_equalTo(40); //test
    }];
    [businessBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_storeNoticeView.mas_bottom);
        make.leading.trailing.equalTo(_contentView);
        make.height.mas_equalTo(10);
    }];
    [_visagisteHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(businessBottomLineView.mas_bottom);
        make.leading.trailing.height.equalTo(_businessInfoLabel);
    }];
    [visagisteLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_visagisteHeadView.mas_bottom);
        make.leading.trailing.height.equalTo(businessLineView);
    }];
    [_visagisteCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(visagisteLineView.mas_bottom).offset(15);
        make.leading.trailing.equalTo(_contentView);
        make.height.mas_equalTo(kVisagisteViewHeight);
    }];
    [chainStoreTopLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_visagisteCollectionView.mas_bottom);
        make.leading.trailing.height.equalTo(businessBottomLineView);
    }];
    [_chainStoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chainStoreTopLineView.mas_bottom);
        make.leading.trailing.equalTo(_contentView);
        make.height.mas_equalTo(50);
    }];
    [chainStoreBottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_chainStoreView.mas_bottom);
        make.leading.trailing.height.equalTo(chainStoreTopLineView);
    }];
    [_commentHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(chainStoreBottomLineView.mas_bottom);
        make.leading.trailing.height.equalTo(_chainStoreView);
    }];
    [_goodsScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_commentHeadView);
        make.trailing.equalTo(_commentHeadView).offset(-32);
    }];
    [commentLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentHeadView.mas_bottom);
        make.leading.trailing.height.equalTo(businessLineView);
    }];
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(commentLineView.mas_bottom);
        make.leading.trailing.equalTo(_contentView);
    }];
    
    
    // -----test
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
    // -----
    
    [_allCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_commentView.mas_bottom);
        make.leading.trailing.height.equalTo(_commentHeadView);
    }];
    [_allCommentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_allCommentBtn);
        make.size.mas_equalTo(CGSizeMake(97, 25));
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_allCommentBtn.mas_bottom);
    }];
}

- (UIView *)createLineViewWithColor:(UIColor *)bgColor {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = bgColor;
    return view;
}

#pragma mark - Action

- (void)storeHotlineBtnClick {
    
}

#pragma mark - UICollectionViewDataSource / Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.storeImgCollectionView) {
        NSInteger pageNumber = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
        _imageCountLabel.text = [NSString stringWithFormat:@"%ld/4",pageNumber+1];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == _storeImgCollectionView) {
        return 4;
    }
    else if (collectionView == _visagisteCollectionView) {
        return 6;
    }
    else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    if (collectionView == _storeImgCollectionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kStoreImageCellIdentifier forIndexPath:indexPath];
    }
    else if (collectionView == _visagisteCollectionView) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:kVisagisteCellIdentifier forIndexPath:indexPath];
    }
    return cell;
}

#pragma mark - Setter/Getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UICollectionView *)storeImgCollectionView {
    if (!_storeImgCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, kSotreImgHeight);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        _storeImgCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _storeImgCollectionView.backgroundColor = GLOBAL_BACKGROUND_COLOR;
        _storeImgCollectionView.showsHorizontalScrollIndicator = NO;
        _storeImgCollectionView.pagingEnabled = YES;
        _storeImgCollectionView.bounces = NO;
        _storeImgCollectionView.dataSource = self;
        _storeImgCollectionView.delegate = self;
        [_storeImgCollectionView registerClass:[KRBannerImageCell class] forCellWithReuseIdentifier:kStoreImageCellIdentifier];
    }
    return _storeImgCollectionView;
}

- (UILabel *)imageCountLabel {
    if (!_imageCountLabel) {
        _imageCountLabel = [UILabel labelWithText:@"1/4" textColor:[UIColor whiteColor] fontSize:12];
        _imageCountLabel.textAlignment = NSTextAlignmentCenter;
        _imageCountLabel.backgroundColor = RGBA(0, 0, 0, 0.5);
    }
    return _imageCountLabel;
}

- (UILabel *)storeNameLabel {
    if (!_storeNameLabel) {
        _storeNameLabel = [UILabel labelWithText:@"店铺名店铺名店" textColor:FONT_COLOR_33 fontSize:16];
        _storeNameLabel.numberOfLines = 2;
    }
    return _storeNameLabel;
}

- (UILabel *)storeDistanceLabel {
    if (!_storeDistanceLabel) {
        _storeDistanceLabel = [UILabel labelWithText:@"1.3km" textColor:FONT_COLOR_99 fontSize:12];
    }
    return _storeDistanceLabel;
}

- (UILabel *)storeScoreLabel {
    if (!_storeScoreLabel) {
        _storeScoreLabel = [UILabel labelWithText:@"评分4.0" textColor:FONT_COLOR_99 fontSize:12];
    }
    return _storeScoreLabel;
}

- (UILabel *)storeAddressLabel {
    if (!_storeAddressLabel) {
        _storeAddressLabel = [UILabel labelWithText:@"小新塘小新塘小新塘小新塘小新塘小新塘小新塘小新塘小新塘小新塘小新塘" textColor:FONT_COLOR_66 fontSize:14];
        _storeAddressLabel.numberOfLines = 0;
    }
    return _storeAddressLabel;
}

- (UIButton *)storeHotlineBtn {
    if (!_storeHotlineBtn) {
        _storeHotlineBtn = [UIButton buttonWithTitle:@"020-56898989" fontSize:14 titleColor:FONT_COLOR_66 target:self action:@selector(storeHotlineBtnClick)];
        [_storeHotlineBtn setImage:[UIImage imageNamed:@"phone_call_small"] forState:UIControlStateNormal];
        _storeHotlineBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _storeHotlineBtn.imageEdgeInsets = UIEdgeInsetsMake(3, 0, 0, 0);
        _storeHotlineBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _storeHotlineBtn;
}

- (UILabel *)businessInfoLabel {
    if (!_businessInfoLabel) {
        _businessInfoLabel = [UILabel labelWithText:@"营业信息" textColor:FONT_COLOR_33 fontSize:14];
    }
    return _businessInfoLabel;
}

- (UILabel *)businessTimeLabel {
    if (!_businessTimeLabel) {
        _businessTimeLabel = [UILabel labelWithText:@"营业时间:" textColor:RGB(0, 0, 32) fontSize:14];
    }
    return _businessTimeLabel;
}

- (UIView *)businessTimeView {
    if (!_businessTimeView) {
        _businessTimeView = [[UIView alloc] init];
    }
    return _businessTimeView;
}

- (UILabel *)storeNoticeLabel {
    if (!_storeNoticeLabel) {
        _storeNoticeLabel = [UILabel labelWithText:@"店铺告知:" textColor:RGB(0, 0, 32) fontSize:14];
    }
    return _storeNoticeLabel;
}

- (UIView *)storeNoticeView {
    if (!_storeNoticeView) {
        _storeNoticeView = [[UIView alloc] init];
    }
    return _storeNoticeView;
}

- (UILabel *)visagisteHeadView {
    if (!_visagisteHeadView) {
        _visagisteHeadView = [UILabel labelWithText:@"专业美容师" textColor:FONT_COLOR_33 fontSize:14];
    }
    return _visagisteHeadView;
}

- (UICollectionView *)visagisteCollectionView {
    if (!_visagisteCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kVisagisteImageWidth, kVisagisteViewHeight);
        layout.minimumLineSpacing = 15;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 0);
        _visagisteCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_visagisteCollectionView registerClass:[KRVisagisteCell class] forCellWithReuseIdentifier:kVisagisteCellIdentifier];
        _visagisteCollectionView.delegate = self;
        _visagisteCollectionView.dataSource = self;
        _visagisteCollectionView.backgroundColor = [UIColor whiteColor];
        _visagisteCollectionView.showsHorizontalScrollIndicator = NO;
        _visagisteCollectionView.bounces = NO;
    }
    return _visagisteCollectionView;
}

- (KRArrowIconRowView *)chainStoreView {
    if (!_chainStoreView) {
        _chainStoreView = [KRArrowIconRowView rowViewWithSize:CGSizeMake(SCREEN_WIDTH, 50) title:@"连锁店铺" subtitle:nil iconName:nil hiddenArrow:NO];
    }
    return _chainStoreView;
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

@end
