//
//  ViewController.m
//  拖动Demo
//
//  Created by zhangqi on 15/12/22.
//  Copyright © 2015年 zhangqi. All rights reserved.
//

#import "ViewController.h"
#import "XQCustomTableView.h"
#import "XQHeaderView.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property( weak, nullable,nonatomic) XQCustomTableView * tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initView];
    [self _configureViewController];
    [self _configureTableView];
}

- (void)_initView {
//    XQCustomTableView * tableView = [[XQCustomTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    XQCustomTableView * tableView = [XQCustomTableView tableViewWithFrame:self.view.bounds headerHeight:400];
    [self.view addSubview:tableView];
    _tableView = tableView;
    tableView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(tableView)]];
}

- (void)_configureViewController {
    self.automaticallyAdjustsScrollViewInsets = false;
    self.extendedLayoutIncludesOpaqueBars = true;
    self.navigationController.navigationBar.translucent = true;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

static NSString * cellId = @"cellIdtyj";
- (void)_configureTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.headerView.localImagesNameArray =  @[@"6p-1", @"6p-2", @"6p-3", @"4s-1", @"4s-2", @"4s-3"];
    _tableView.headerView.clickBlock = ^(NSIndexPath *indexPath){
      
        NSLog(@"点击了第%ld个图片",(long)indexPath.row);
        
    };
    
}

#pragma mark table的代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = [NSString stringWithFormat:@"cell=====%ld", indexPath.row];
    return cell;
}








@end
