//
//  XQHeaderView.m
//  拖动Demo
//
//  Created by zhangqi on 15/12/22.
//  Copyright © 2015年 zhangqi. All rights reserved.
//

#import "XQHeaderView.h"

/** 分页的间距*/
static CGFloat margin = 10;

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nullable, nonatomic) UIImageView * imageView;

@end

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self _initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self _initView];
    }
    return self;
}

- (void)_initView {
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:imageView];
    _imageView = imageView;
    imageView.translatesAutoresizingMaskIntoConstraints = false;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(imageView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]-(margin)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:@{@"margin":@(margin)} views:NSDictionaryOfVariableBindings(imageView)]];
}

@end

#pragma mark - ******************************************************************

@interface XQHeaderView ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nullable, nonatomic) UIPageControl * pageControl;
@property (weak, readonly, nullable, nonatomic) UICollectionView * collectionView;
@end

@implementation XQHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {
        [self _initView];
        [self _configureCollectionView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self _initView];
        [self _configureCollectionView];
    }
    return self;
}

- (void)_initView {
    UICollectionViewFlowLayout * f = [[UICollectionViewFlowLayout alloc] init];
    f.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    f.footerReferenceSize = CGSizeZero;
    f.headerReferenceSize = CGSizeZero;
    f.minimumInteritemSpacing = margin;
    f.minimumLineSpacing = 0;
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:f];
    collectionView.backgroundColor = [UIColor blackColor];
    [self addSubview:collectionView];
    _collectionView = collectionView;
    collectionView.translatesAutoresizingMaskIntoConstraints = false;
    collectionView.pagingEnabled = true;
    collectionView.showsHorizontalScrollIndicator = false;
    collectionView.showsVerticalScrollIndicator = false;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(collectionView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]-(margin)-|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:@{@"margin":@(-margin)} views:NSDictionaryOfVariableBindings(collectionView)]];
}

static NSString * cellId = @"cellIdasdas";
- (void)_configureCollectionView {
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellId];
}

- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.enabled = false;
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    }
    return _pageControl;
}

- (void)didMoveToSuperview{
    [super didMoveToSuperview];
    [self.pageControl removeFromSuperview];
    [self.superview addSubview:self.pageControl];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = false;
    UIPageControl *pageControl = self.pageControl;
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(pageControl)]];
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pageControl]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(pageControl)]];
}

- (void)setLocalImagesNameArray:(NSArray<NSString *> *)localImagesNameArray{
    _localImagesNameArray = localImagesNameArray;
    
    if (![localImagesNameArray isEqual:_localImagesNameArray]) {
        [_collectionView reloadData];
    }
    
}

- (void)setNetImagesUrlArray:(NSArray<NSString *> *)netImagesUrlArray{
    _netImagesUrlArray = netImagesUrlArray;
    if (![netImagesUrlArray isEqual:_netImagesUrlArray]) {
        [_collectionView reloadData];
    }
}

#pragma mark UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger count = _localImagesNameArray.count?_localImagesNameArray.count:self.netImagesUrlArray.count;
    if (_pageControl.superview != nil) {
        _pageControl.numberOfPages = count;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    if (_localImagesNameArray.count) {
        cell.imageView.image = [UIImage imageNamed:_localImagesNameArray[indexPath.item]];
    }else{// 设置网络图片
//        cell sd_setImage....
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.clickBlock) {
        self.clickBlock(indexPath);
    }
}

#pragma mark UICollectionViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (_pageControl.superview != nil) {
        _pageControl.currentPage = (NSInteger)(*targetContentOffset).x / scrollView.bounds.size.width;
    }
}

@end
