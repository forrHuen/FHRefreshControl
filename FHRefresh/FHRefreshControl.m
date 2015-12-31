//
//  FHRefreshControl.m
//  FHRefreshControl
//
//  Created by forr on 15/7/18.
//  Copyright (c) 2015年 XY. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FHRefreshControl.h"



#define FHRefreshHeaderViewHeight    64
#define FHRefreshFooterViewHeight    64


@interface FHRefreshControl ()

@end

@implementation FHRefreshControl

+(instancetype)refreshControlObserverWithScrollView:(UIScrollView *)scrollview
{
    FHRefreshControl *object = [self new];
    object.scrollView = scrollview;
    [object addObserverWithScrollView];
    [object initUI];
    [object setUpPara];
    return object;
}

-(void)setUpPara
{
    self.isCanRefreshing = YES;
    self.isCanLoadingMore = YES;
}

/**
 初始化刷新的头部、尾部控件
 */
-(void)initUI
{
    _headerView = [FHRefreshHeaderView createRefreshViewWithFrame:CGRectMake(0, -FHRefreshHeaderViewHeight, [UIScreen mainScreen].bounds.size.width, FHRefreshHeaderViewHeight)];
    [_scrollView addSubview:_headerView];
    _footerView = [FHRefreshFooterView createRefreshViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, FHRefreshFooterViewHeight)];
    [self ajustFooterView];
    [_scrollView addSubview:_footerView];
}

/**
 *  调整footerView的位置
 */
- (void)ajustFooterView
{
    CGFloat contentSizeHeight = _scrollView.contentSize.height;
    CGFloat height = _scrollView.frame.size.height;
    //    NSLog(@"sizeHeight=%lf,height=%lf",contentSizeHeight,height);
    CGRect frame = _footerView.frame;
    frame.origin.y = MAX(height, contentSizeHeight);
    _footerView.frame = frame;
}

-(void)addHeaderWithCallBack:(void(^)())callBack
{
    _headerView.beginRefreshBlock = callBack;
}


-(void)addFooterWithCallBack:(void(^)())callBack
{
    _footerView.beginLoadingMoreBlock = callBack;
}


#pragma mark －下拉刷新
-(void)beginRefreshing{
    if (_state==FHRefreshStateNormal)
    {
        _state = FHRefreshStateRefeshing;
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(refreshControlStartRefreshing:scrollView:)])
        {
            [self.delegate refreshControlStartRefreshing:self scrollView:self.scrollView];
        }
        if (_headerView.beginRefreshBlock)
        {
            _headerView.beginRefreshBlock();
        }
        [self refreshingAnimation];
        [_headerView startRefreshAnimation];
        [self resetLoadState];
    }
}

-(void)refreshingAnimation{
    [UIView animateWithDuration:0.3 animations:^{
        _scrollView.contentInset = UIEdgeInsetsMake(FHRefreshHeaderViewHeight, 0,_scrollView.contentInset.bottom, 0);
    }];
}

-(void)endRefresh
{
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(refreshControlEndRefresh:scrollView:)])
    {
        [self.delegate refreshControlEndRefresh:self scrollView:self.scrollView];
    }
    [_headerView endRefreshAnimation];
    [self endRefreshAnimation];
}

-(void)endRefreshAnimation{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0,_scrollView.contentInset.bottom, 0);
    } completion:^(BOOL finished) {
        _state = FHRefreshStateNormal;
        //校验是否已加载完
        if (self.scrollView.frame.size.height>self.scrollView.contentSize.height) {
//            NSLog(@"frame=%@-%lf",NSStringFromCGRect(_scrollView.frame),_scrollView.contentSize.height);
            [self finishLoad];
        }
    }];
}

#pragma mark －加载更多
-(void)beginLoading
{
    if (_loadState==FHLoadingMorePrepare)
    {
        _loadState = FHLoadingMoreRefreshing;
        [_footerView startRefreshAnimation];
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(refreshControlStartLoading:scrollView:)])
        {
            [self.delegate refreshControlStartLoading:self scrollView:self.scrollView];
        }
        if (_footerView.beginLoadingMoreBlock)
        {
            _footerView.beginLoadingMoreBlock();
        }
    }
}


-(void)endLoad
{
    [_footerView endRefreshAnimation];
    _loadState = FHLoadingMoreNormal;
    if(self.delegate &&
       [self.delegate respondsToSelector:@selector(refreshControlEndLoad:scrollView:)])
    {
        [self.delegate refreshControlEndLoad:self scrollView:self.scrollView];
    }
//    NSLog(@"end");
}

/**
 对滑动事件添加监听
 */
-(void)addObserverWithScrollView{
    if (_scrollView) {
        [_scrollView addObserver:self
                      forKeyPath:@"contentOffset"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
        [_scrollView addObserver:self
                      forKeyPath:@"contentSize"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    }
}

-(void)removeObserverWithScrollView{
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
        [_scrollView removeObserver:self forKeyPath:@"contentSize"];
        _scrollView = nil;
    }
}

-(void)dealloc{
    [self removeObserverWithScrollView];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        [self ajustFooterView];
    }
//     NSLog(@"frame=%@-%lf",NSStringFromCGRect(_scrollView.frame),_scrollView.contentSize.height);
    //当前位置
    CGFloat offsetY = _scrollView.contentOffset.y;
    if (offsetY>0) {
        if (self.isCanRefreshing) {
            //上拉加载更多
            [self handleWithScrollViewContentInsetBottom:offsetY];
        }
    }else{
        if (self.isCanLoadingMore) {
            //下拉刷新
            [self handleWithScrollViewContentInsetTop:offsetY];
        }
    }
    
}

/**
 处理向上滑动
 @param offset 滚动偏移量
 */
-(void)handleWithScrollViewContentInsetBottom:(CGFloat)offset{

    if (_loadState==FHLoadingMoreRefreshing||_loadState==FHLoadingMoreFinish||_state==FHRefreshStateRefeshing) {
        return;
    }
        CGFloat offsetY = self.scrollView.contentOffset.y;
        CGFloat sizeHeight = self.scrollView.contentSize.height;
        sizeHeight = sizeHeight - self.scrollView.frame.size.height;
        if (offsetY>0) {
//            NSLog(@"y=%lf,r=%lf,s=%lf",offsetY,sizeHeight,self.scrollView.contentInset.bottom);
            if (self.scrollView.isDragging) {
                //拖拽中。。。
                CGFloat  percent = (offset-sizeHeight<=0)?0:(offset-sizeHeight)/FHRefreshFooterViewHeight;
                [_footerView animationWithPercent:percent];
                if (percent>=1) {
                    _loadState = FHLoadingMorePrepare;
                }else{
                    _loadState = FHLoadingMoreNormal;
                }
            }else{
//                 NSLog(@"y=%lf,r=%lf",offsetY,sizeHeight+FHRefreshFooterViewHeight*0.85);
                //结束拖拽。。。
                if (offsetY>sizeHeight+FHRefreshFooterViewHeight*0.85) {
//                    NSLog(@"加载");
                    [self beginLoading];
                }
            }
        }
}

/**
 处理上拉
 @param offsetY 滚动偏移量
 */
-(void)handleWithScrollViewContentInsetTop:(CGFloat )offsetY
{
    if (_state==FHRefreshStateNormal&&_loadState!=FHLoadingMoreRefreshing)
    {
        //当前位置
        CGFloat offsetY = _scrollView.contentOffset.y;
        if (_scrollView.isDragging==YES)
        {
            //拖拽中
            if (self.delegate &&
                [self.delegate respondsToSelector:@selector(refreshControlMoving:offset:percent:scrollView:)])
            {
                CGFloat  percent = -offsetY/FHRefreshHeaderViewHeight;
                [self.delegate refreshControlMoving:self
                                             offset:offsetY
                                            percent:percent
                                          scrollView:self.scrollView];
                [_headerView animationWithPercent:percent];
            }
        }
        else if(_scrollView.isDragging==NO)
        {
            //结束拖拽,到达更新的阀值才执行更新
            //            NSLog(@"y=%lf,height=%lf",-_offsetY,_height);
            if (-offsetY >= FHRefreshHeaderViewHeight*0.8)
            {
                [self beginRefreshing];
            }
        }
    }
}

/**
 已加载完数据
 */
-(void)finishLoad{
    [_footerView endRefreshAnimation];
    _loadState = FHLoadingMoreFinish;
    //
    _footerView.stateText = LOAD_FINISH_STRING;
}

/**
 重置为最初的加载状态
 */
-(void)resetLoadState{
    _loadState = FHLoadingMoreNormal;
    _footerView.stateText = LOAD_NORMAL_STRING;
}


#pragma mark setter
-(void)setIsCanRefreshing:(BOOL)isCanRefreshing{
    if (_isCanRefreshing!=isCanRefreshing) {
        _isCanRefreshing =  isCanRefreshing;
        [self.headerView setHidden:!_isCanRefreshing];
        _isCanRefreshing==NO?[self setState:FHRefreshStateRefeshing]:[self setState:FHRefreshStateNormal];
    }
}

-(void)setIsCanLoadingMore:(BOOL)isCanLoadingMore{
    if (_isCanLoadingMore!=isCanLoadingMore) {
        _isCanLoadingMore = isCanLoadingMore;
        [self.footerView setHidden:!_isCanLoadingMore];
        _isCanLoadingMore==NO?[self setLoadState:FHLoadingMoreRefreshing]:[self setLoadState:FHLoadingMoreNormal];
    }
}

@end

