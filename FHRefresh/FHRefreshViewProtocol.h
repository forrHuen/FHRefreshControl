//
//  FHRefreshViewProtocol.h
//  FHRefreshControl
//
//  Created by forr on 15/7/18.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FHRefreshViewProtocol <NSObject>

/**
 开始刷新、加载动画
 */
-(void)startRefreshAnimation;

/**
 通过百分比定义是否改变为可刷新、加载状态
 @param percent <#percent description#>
 */
-(void)animationWithPercent:(CGFloat )percent;

/**
 停止刷新、加载
 */
-(void)endRefreshAnimation;


@end
