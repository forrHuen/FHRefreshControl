//
//  FHRefreshFooterView.h
//  FHRefreshControl
//
//  Created by forr on 15/7/19.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import "FHRefreshBaseView.h"



@interface FHRefreshFooterView : FHRefreshBaseView


@property(nonatomic,copy) void (^beginLoadingMoreBlock)();


@end
