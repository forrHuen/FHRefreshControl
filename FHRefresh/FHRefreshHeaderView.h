//
//  FHRefreshHeaderView.h
//  FHRefreshControl
//
//  Created by forr on 15/7/18.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import "FHRefreshBaseView.h"

@interface FHRefreshHeaderView : FHRefreshBaseView

@property(nonatomic,copy) void (^beginRefreshBlock)();

@end
