//
//  FHRefreshControl.h
//  FHRefreshControl
//
//  Created by forr on 15/7/18.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "FHRefreshHeaderView.h"
#import "FHRefreshFooterView.h"

typedef NS_ENUM(NSUInteger, FHRefreshState) {
    FHRefreshStateNormal,//正常状态
    FHRefreshStateRefeshing,//刷新中状态
};

typedef enum : NSUInteger {
    FHLoadingMoreNormal,//正常状态
    FHLoadingMorePrepare,//等待加载状态
    FHLoadingMoreRefreshing,//加载中状态
    FHLoadingMoreFinish,//已加载完状态
} FHLoadingMore;

@protocol FHRefreshControlDelegate;


@interface FHRefreshControl : NSObject
/**
 刷新头部视图
 */
@property(nonatomic,strong,readonly)FHRefreshHeaderView *headerView;
/**
 加载底部视图
 */
@property(nonatomic,strong,readonly)FHRefreshFooterView *footerView;
/**
 刷新状态
 */
@property(nonatomic,assign)FHRefreshState state;
/**
 加载状态
 */
@property(nonatomic,assign)FHLoadingMore loadState;

@property(nonatomic,weak)UIScrollView *scrollView;
/**
 刷新、加载回调状态的代理
 */
@property(nonatomic,assign)id<FHRefreshControlDelegate>delegate;
/**
 是否支持加载更多
 */
@property(nonatomic,assign)BOOL isCanLoadingMore;
/**
 是否支持上拉刷新
 */
@property(nonatomic,assign)BOOL isCanRefreshing;

/**
 构造对象
 @param height scrollview刷新时头部的高度
 @return 目标对象
 */
+(instancetype)refreshControlObserverWithScrollView:(UIScrollView *)scrollview;;


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
 调用后开始刷新
 */
-(void)beginRefreshing;

/**
 调用后结束刷新
 */
-(void)endRefresh;

/**
 调用后开始加载更多
 */
-(void)beginLoading;

/**
 调用后结束加载更多
 */
-(void)endLoad;


/**
 已加载完数据
 */
-(void)finishLoad;



@end



@protocol FHRefreshControlDelegate <NSObject>
@optional
/**
 开时刷新
 @param refreshControl
 */
-(void)refreshControlStartRefreshing:(FHRefreshControl *)refreshControl;
/**
 结束刷新
 @param refreshControl
 */
-(void)refreshControlEndRefresh:(FHRefreshControl *)refreshControl;
/**
 移动过程
 @param refreshControl
 @param offset         偏移量
 @param percent        百分比
 */
-(void)refreshControlMoving:(FHRefreshControl *)refreshControl
       offset:(CGFloat )offset
      percent:(CGFloat )percent;
/**
 开时加载更多
 @param refreshControl
 */
-(void)refreshControlStartLoading:(FHRefreshControl *)refreshControl;
/**
 结束加载更多
 @param refreshControl
 */
-(void)refreshControlEndLoad:(FHRefreshControl *)refreshControl;

@end