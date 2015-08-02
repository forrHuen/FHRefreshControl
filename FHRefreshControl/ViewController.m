//
//  ViewController.m
//  FHRefreshControl
//
//  Created by forr on 15/7/18.
//  Copyright (c) 2015年 XY. All rights reserved.
//

#import "ViewController.h"
#import "FHRefreshHeaderView.h"
#import "UIScrollView+FHRefresh.h"

@interface ViewController ()<FHRefreshControlDelegate>
@property(nonatomic,strong)FHRefreshHeaderView *header;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //初始化刷新控件并为其设置代理
    [self.tableView createRefreshWithDelegate:self];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    //通过block块方式刷新、加载数据
//    __weak ViewController *weakSelf = self;
//    [self.tableView addHeaderWithCallBack:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.tableView endRefresh];
//            [weakSelf.dataSource removeAllObjects];
//            for (int i = 0; i < 17; i++) {
//                [weakSelf.dataSource addObject:[NSString stringWithFormat:@"%d",i]];
//            }
//            [weakSelf.tableView reloadData];
//        });
//    }];
//    [self.tableView addFooterWithCallBack:^{
//        if (weakSelf.dataSource.count>30) {
//            [weakSelf.tableView  finishLoad];
//            return;
//        }
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.tableView endLoad];
//            for (int i = 0; i < 10; i++) {
//                [weakSelf.dataSource addObject:[NSString stringWithFormat:@"%d",i]];
//            }
//            [weakSelf.tableView reloadData];
//        });
//        NSLog(@"count=%lu",(unsigned long)weakSelf.dataSource.count);
//    }];
    [self.tableView setIsCanLoadingMore:YES];
    [self.tableView setIsCanRefreshing:YES];
    [self.tableView beginRefresh];
}

#pragma mark  -refreshControlDelegate-
-(void)refreshControlStartRefreshing:(FHRefreshControl *)refreshControl{
    NSLog(@"startRefresh");
     __weak ViewController *weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView endRefresh];
        [weakSelf.dataSource removeAllObjects];
        for (int i = 0; i < 17; i++) {
            [weakSelf.dataSource addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [weakSelf.tableView reloadData];
    });
}

-(void)refreshControlMoving:(FHRefreshControl *)refreshControl offset:(CGFloat)offset percent:(CGFloat)percent{
//    NSLog(@"move");
}

-(void)refreshControlEndRefresh:(FHRefreshControl *)refreshControl{
    NSLog(@"endRefresh");
}

-(void)refreshControlStartLoading:(FHRefreshControl *)refreshControl{
    NSLog(@"startloaded");
    __weak ViewController *weakSelf = self;
    if (weakSelf.dataSource.count>30) {
        [weakSelf.tableView  finishLoad];
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.tableView endLoad];
        for (int i = 0; i < 10; i++) {
            [weakSelf.dataSource addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [weakSelf.tableView reloadData];
    });

}

-(void)refreshControlEndLoad:(FHRefreshControl *)refreshControl{
    NSLog(@"endloaded");
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifer = @"cellIdentifer";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}



@end
