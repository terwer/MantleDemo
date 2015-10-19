//
//  ViewController.m
//  MantleDemo
//
//  Created by Terwer Green on 15/10/12.
//  Copyright © 2015年 Terwer Green. All rights reserved.
//

#import "MantleViewController.h"
#import "GHIssueMantle.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface MantleViewController ()<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation MantleViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBar];
    
    [self initViews];
    
    [self refreshDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - init views

- (void)setNavigationBar{
    self.navigationItem.title = @"使用Mantle";
}

- (void)initViews{
    [self.view addSubview:self.tableView];
}

#pragma mark - getter

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

#pragma mark - UITableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    GHIssueMantle *issue = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = issue.title;
    
    return cell;
}

#pragma mark - UITableView delegate

#pragma mark - dataSource

- (void)refreshDataSource{
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://api.github.com/repos/mantle/mantle/issues"]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
    //状态栏显示活动
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    dispatch_async(dispatch_get_main_queue(), ^{
        //状态栏隐藏活动
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
    
    //数据处理
    //issue字典转换为模型
    NSArray *issueArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    for (int i = 0; i < issueArray.count; i++) {
        NSDictionary *dict = issueArray[i];
        GHIssueMantle *issue = [MTLJSONAdapter modelOfClass:[GHIssueMantle class] fromJSONDictionary:dict error:nil];
        [self.dataSource addObject:issue];
    }
    
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.tableView reloadData];
    });
    
    
}

@end
