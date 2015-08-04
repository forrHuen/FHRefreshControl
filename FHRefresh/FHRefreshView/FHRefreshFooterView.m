//
//  FHRefreshFooterView.m
//  FHRefreshControl
//
//  Created by forr on 15/7/19.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import "FHRefreshFooterView.h"


@interface FHRefreshFooterView ()



@end

@implementation FHRefreshFooterView


-(void)endRefreshAnimation{
    [self.activityIndicator stopAnimating];
}

-(void)startRefreshAnimation{
    self.stateText = REFRESHING_STRING;
    [self.activityIndicator startAnimating];
}

-(void)animationWithPercent:(CGFloat)percent{
    if (percent<1.0f) {
        self.stateText = LOAD_NORMAL_STRING;
    }else{
        self.stateText = LOAD_BEGIN_STRING;
    }
}


@end
