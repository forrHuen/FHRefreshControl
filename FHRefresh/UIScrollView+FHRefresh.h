//
//  UIScrollView+FHRefresh.h
//  FHRefreshControl
//
//  Created by forr on 15/7/18.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHRefreshControl.h"

@interface UIScrollView (FHRefresh)

/**
 刷新控制器
 */
@property(nonatomic,strong,readonly)FHRefreshControl *refreshControl;

/**
 添加设置刷新代理
 @param delegate       刷新代理
 */
-(void)createRefreshWithDelegate:(id<FHRefreshControlDelegate>)delegate;

/**
 添加下拉刷新回调函数
 @param callBack <#callBack description#>
 */
-(void)addHeaderWithCallBack:(void(^)())callBack;

/**
 添加向上滑动加载更多回调函数
 @param callBack <#callBack description#>
 */
-(void)addFooterWithCallBack:(void(^)())callBack;


/**
 开始刷新
 */
-(void)beginRefresh;

/**
 结束刷新
 */
-(void)endRefresh;

/**
 开始加载更多
 */
-(void)beginLoad;

/**
 结束加载更多
 */
-(void)endLoad;

/**
 已加载完成数据
 */
-(void)finishLoad;

/**
 设置是否支持下拉加载更多
 */
-(void)setIsCanLoadingMore:(BOOL)flag;
/**
 设置是否支持上拉刷新
 */
-(void)setIsCanRefreshing:(BOOL)flag;




@end
