//
//  FHRefreshBaseView.m
//  FHRefreshControl
//
//  Created by forr on 15/7/18.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import "FHRefreshBaseView.h"
NSString *const REFRESH_NORMAL_STRING = @"上拉加载更多";
NSString *const REFRESH_BEGIN_STRING = @"松手刷新状态";
NSString *const REFRESH_END_STRING = @"刷新成功";

NSString *const REFRESHING_STRING = @"加载中,请稍后...";

NSString *const LOAD_NORMAL_STRING = @"上拉加载更多";
NSString *const LOAD_BEGIN_STRING = @"松手刷新状态";
NSString *const LOAD_FINISH_STRING = @"已加载完";

#define StateLabelHeight  12

@implementation FHRefreshBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width-50)/2,8,50,50)];
        _activityIndicator.hidesWhenStopped = NO;
        [self addSubview:_activityIndicator];
        //
        CGPoint center = self.center;
        _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,frame.size.width,StateLabelHeight)];
        _stateLabel.font = [UIFont systemFontOfSize:10];
        _stateLabel.textAlignment = NSTextAlignmentCenter;
        center.y = frame.size.height - StateLabelHeight/2;
        _stateLabel.center = center;
        [self addSubview:_stateLabel];
        //
        [self setUpPara];
    }
    return self;
}

+(instancetype)createRefreshViewWithFrame:(CGRect)frame{
    return [[self alloc]initWithFrame:frame];
}

-(void)setUpPara{
    _activityIndicator.color = [UIColor redColor];
    _stateLabel.textColor = [UIColor redColor];
    _stateLabel.text = REFRESH_NORMAL_STRING;
}

#pragma mark -FHRefreshViewProtocol-

-(void)startRefreshAnimation{
    
}

-(void)endRefreshAnimation{
    
}

-(void)animationWithPercent:(CGFloat)percent{
    
}
#pragma mark -setter
-(void)setStateText:(NSString *)stateText{
    if (_stateText!=stateText) {
        _stateText = stateText;
        _stateLabel.text = stateText;
    }
}

-(void)setStateTextColor:(UIColor *)stateTextColor{
    if (_stateTextColor!=stateTextColor ) {
        _stateTextColor = stateTextColor;
        _stateLabel.textColor = stateTextColor;
    }
}

-(void)setActivityIndicatorColor:(UIColor *)activityIndicatorColor{
    if (_activityIndicatorColor!=activityIndicatorColor) {
        _activityIndicatorColor = activityIndicatorColor;
        _activityIndicator.color = activityIndicatorColor;
    }
}








@end
