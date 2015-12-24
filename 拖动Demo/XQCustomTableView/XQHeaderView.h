//
//  XQHeaderView.h
//  拖动Demo
//
//  Created by zhangqi on 15/12/22.
//  Copyright © 2015年 zhangqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^XQHeaderViewClickBlock)(NSIndexPath *indexPath);

@interface XQHeaderView : UIView
@property (strong, nonnull, nonatomic) NSArray <NSString *>* localImagesNameArray;
@property (nonatomic, strong) NSArray <NSString *>* netImagesUrlArray;
@property (nonatomic, copy, nonnull) XQHeaderViewClickBlock clickBlock;

@end
NS_ASSUME_NONNULL_END