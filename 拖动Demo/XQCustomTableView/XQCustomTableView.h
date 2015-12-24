//
//  CustomTableView.h
//  拖动Demo
//
//  Created by zhangqi on 15/12/22.
//  Copyright © 2015年 zhangqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XQHeaderView.h"

NS_ASSUME_NONNULL_BEGIN
@class XQHeaderView;

@interface XQCustomTableView : UITableView

@property(weak, readonly, nullable, nonatomic) XQHeaderView *headerView;
/**默认为0.5，移动到定点的时候图片移动到中点*/
@property(assign, nonatomic) CGFloat pushUpMovingRate;
@property (nonatomic, assign) CGFloat heightForHeader;

@end
NS_ASSUME_NONNULL_END
