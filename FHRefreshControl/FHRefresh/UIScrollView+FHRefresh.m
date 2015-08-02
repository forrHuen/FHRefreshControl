//
//  UIScrollView+FHRefresh.m
//  FHRefreshControl
//
//  Created by forr on 15/7/18.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import "UIScrollView+FHRefresh.h"
#import <objc/runtime.h>

NSString *const REFRESHCONTROL_OBJECT_KEY = @"REFRESHCONTROL_OBJECT_KEY";


@implementation UIScrollView (FHRefresh)

-(void)setRefreshControl:(FHRefreshControl *)refreshControl{
   objc_setAssociatedObject(self, (__bridge const void *)REFRESHCONTROL_OBJECT_KEY, refreshControl,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(FHRefreshControl *)refreshControl{
    return objc_getAssociatedObject(self, (__bridge const void *)(REFRESHCONTROL_OBJECT_KEY));
}

-(void)createRefreshWithDelegate:(id<FHRefreshControlDelegate>)delegate{
    if (self.refreshControl==nil) {
        self.refreshControl = [FHRefreshControl refreshControlObserverWithScrollView:self];
        self.refreshControl.delegate = delegate;
    }
}


-(void)addHeaderWithCallBack:(void(^)())callBack{
    [self.refreshControl addHeaderWithCallBack:callBack];
}

-(void)addFooterWithCallBack:(void(^)())callBack{
    [self.refreshControl addFooterWithCallBack:callBack];
}


-(void)beginRefresh{
    [self.refreshControl beginRefreshing];
}


-(void)endRefresh{
    [self.refreshControl endRefresh];
}

-(void)beginLoad{
    [self.refreshControl beginLoading];
}

-(void)endLoad{
    [self.refreshControl endLoad];
}

-(void)setIsCanLoadingMore:(BOOL)flag{
    [self.refreshControl setIsCanLoadingMore:flag];
}

-(void)setIsCanRefreshing:(BOOL)flag{
    [self.refreshControl setIsCanRefreshing:flag];
}

-(void)finishLoad{
    [self.refreshControl finishLoad];
}

@end
