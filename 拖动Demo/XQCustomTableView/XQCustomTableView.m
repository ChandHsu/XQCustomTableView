//
//  CustomTableView.m
//  拖动Demo
//
//  Created by zhangqi on 15/12/22.
//  Copyright © 2015年 zhangqi. All rights reserved.
//

#import "XQCustomTableView.h"

@interface XQCustomTableView ()

@end

@implementation XQCustomTableView

static CGFloat headerViewH = 232;
+(instancetype)tableViewWithFrame:(CGRect)frame headerHeight:(CGFloat)height{
    headerViewH = height;
    return [[self alloc] initWithFrame:frame style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self _initView];
        [self _configureTableView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]){
        [self _initView];
        [self _configureTableView];
    }
    return self;
}

- (void)_initView {
    XQHeaderView * headerView = [[XQHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, headerViewH)];
    [self addSubview:headerView];
    _headerView = headerView;
    headerView.translatesAutoresizingMaskIntoConstraints = false;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-offsetY-[headerView(==height)]" options:NSLayoutFormatDirectionLeadingToTrailing metrics:@{@"height":@(headerViewH), @"offsetY" :@(-headerViewH) } views:NSDictionaryOfVariableBindings(headerView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerView(==self)]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(headerView,self)]];
    
}

- (void)_configureTableView {
    _pushUpMovingRate = 0.5;
    self.backgroundColor = [UIColor whiteColor];
    self.contentInset = UIEdgeInsetsMake(headerViewH, 0, 0, 0);
    self.contentOffset = CGPointMake(0, -headerViewH);
}

- (void)setContentOffset:(CGPoint)contentOffset {
    CGPoint offset = contentOffset;
    
    if (offset.y < -headerViewH) {
        //放大:向下移动距离为偏移的一半，并放大
        _headerView.hidden = false;
        CGFloat delta = ABS(offset.y + headerViewH);
        CGFloat scale = delta / headerViewH + 1;
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(scale, scale);
        CGAffineTransform translationTransform = CGAffineTransformMakeTranslation(0, -0.5 * delta);
        _headerView.transform = CGAffineTransformConcat(scaleTransform, translationTransform);
    }else if (offset.y < 0) {
        //偏移：上拉距离 * 偏移比例。
        _headerView.hidden = false;
        CGFloat delta = ABS(offset.y + headerViewH);
        _headerView.transform = CGAffineTransformMakeTranslation(0, delta * _pushUpMovingRate);
    }else {
        _headerView.transform = CGAffineTransformIdentity;
        _headerView.hidden = true;
    }
    [super setContentOffset:contentOffset];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self insertSubview:_headerView atIndex:0];
}


@end
