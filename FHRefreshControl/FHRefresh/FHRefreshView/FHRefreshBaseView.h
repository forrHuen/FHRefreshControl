//
//  FHRefreshBaseView.h
//  FHRefreshControl
//
//  Created by forr on 15/7/18.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FHRefreshViewProtocol.h"


extern NSString *const REFRESH_NORMAL_STRING ;
extern NSString *const REFRESH_BEGIN_STRING;
extern NSString *const REFRESH_END_STRING;

extern NSString *const REFRESHING_STRING;

extern NSString *const LOAD_NORMAL_STRING;
extern NSString *const LOAD_BEGIN_STRING;
extern NSString *const LOAD_FINISH_STRING;


@interface FHRefreshBaseView : UIView <FHRefreshViewProtocol>

@property(nonatomic,strong)UIActivityIndicatorView *activityIndicator;
@property(nonatomic,strong)UIColor *activityIndicatorColor;

@property(nonatomic,strong)UILabel *stateLabel;
@property(nonatomic,strong)NSString *stateText;
@property(nonatomic,strong)UIColor *stateTextColor;

/**
 构造对象
 @param frame 刷新控件坐标大小
 @return 目标对象
 */
+(instancetype )createRefreshViewWithFrame:(CGRect )frame;
/**
 子类重写该方法刷新控件默认参数
 */
-(void)setUpPara;

@end
