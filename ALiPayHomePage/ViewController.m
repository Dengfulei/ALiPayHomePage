//
//  ViewController.m
//  ALiPayHomePage
//
//  Created by 杭州移领 on 17/1/20.
//  Copyright © 2017年 DFL. All rights reserved.
//

#import "ViewController.h"
#import "DFLHeaderView.h"
#import "DFLRefreshHeader.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) DFLHeaderView *headerView;

//如果使用UIView 可以实现滑动效果，但是添加在parentScrollView的tableView和headerView，的点击事件无效
@property (nonatomic , strong) UIScrollView *parentScrollView;

@end

@implementation ViewController
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(264, 0, 0, 0);
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[DFLHeaderView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
    }
    return _headerView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
  
    self.parentScrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.parentScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.parentScrollView];
       //移除scrollView原有手势操作
    NSMutableArray *list = [NSMutableArray arrayWithArray:self.parentScrollView.gestureRecognizers];
    for (UIGestureRecognizer *gestureRecognizer in list) {
        [self.parentScrollView removeGestureRecognizer:gestureRecognizer];
    }
    
    for (UIGestureRecognizer *gestureRecognizer in self.tableView.gestureRecognizers) {
        [self.parentScrollView addGestureRecognizer:gestureRecognizer];
    }
    [self.parentScrollView addSubview:self.tableView];
    [self.parentScrollView addSubview:self.headerView];
    DFLRefreshHeader *header = [DFLRefreshHeader headerWithRefreshingBlock:^{
        
    }];
    self.tableView.mj_header = header;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"这是测试数据%ld",(long)indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat start =  264 + scrollView.contentOffset.y;
    CGRect frame = self.headerView.frame;
    if (start > 0) {
        frame.origin.y = 64 - start;
    } else {
        frame.origin.y = 64 ;
    }
    self.headerView.frame = frame;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}


// 不影响侧滑删除效果
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删出";
}


@end
