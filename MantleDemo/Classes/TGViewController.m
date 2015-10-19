//
//  TGViewController.m
//  MantleDemo
//
//  Created by Terwer Green on 15/10/17.
//  Copyright © 2015年 Terwer Green. All rights reserved.
//

#import "TGViewController.h"
#import "NoMantleViewController.h"
#import "MantleViewController.h"

@interface TGViewController ()

@end

@implementation TGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"演示Github Issue";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITAbleView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"不使用Mantle";
        cell.detailTextLabel.text = @"不使用Mantle展示数据";
    }else{
        cell.textLabel.text = @"使用Mantle";
        cell.detailTextLabel.text = @"使用Mantle展示数据";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NoMantleViewController *noMantleViewController = [[NoMantleViewController alloc] init];
        [self.navigationController pushViewController:noMantleViewController animated:YES];
    }else{
        MantleViewController *mantleViewController = [[MantleViewController alloc] init];
        [self.navigationController pushViewController:mantleViewController animated:YES];
        
    }
}

@end
