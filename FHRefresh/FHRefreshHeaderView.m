//
//  FHRefreshHeaderView.m
//  FHRefreshControl
//
//  Created by forr on 15/7/18.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import "FHRefreshHeaderView.h"

@implementation FHRefreshHeaderView

-(void)setUpPara{
    [super setUpPara];
    self.stateTextColor = [UIColor grayColor];
    self.activityIndicatorColor = [UIColor grayColor];
}

-(void)startRefreshAnimation{
    [self.activityIndicator startAnimating];
    self.stateText = REFRESHING_STRING;
}

-(void)endRefreshAnimation{
    [self.activityIndicator stopAnimating];
    self.stateText = REFRESH_END_STRING;
}

-(void)animationWithPercent:(CGFloat)percent{
    if (percent<1.0f) {
        self.stateText = REFRESH_NORMAL_STRING;
    }else{
        self.stateText = REFRESH_BEGIN_STRING;
    }
}


@end
