//
//  WXSystemPushAndPopTableViewController.m
//  iOSDemo
//
//  Created by Wuxi on 2018/5/25.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXSystemPushAndPopTableViewController.h"
#import "WXSecondPresentedViewController.h"
#import "WXSecondPushedViewController.h"

@interface WXSystemPushAndPopTableViewController ()

@property (nonatomic, copy)NSArray *names;

@end

@implementation WXSystemPushAndPopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _names = @[@"Fade",
               @"Push",@"Push",@"Push",@"Push",
               @"Reveal",@"Reveal",@"Reveal",@"Reveal",
               @"MoveIn",@"MoveIn",@"MoveIn",@"MoveIn",
               @"Cube",@"Cube",@"Cube",@"Cube",
               @"suckEffect",
               @"oglFlip",@"oglFlip",@"oglFlip",@"oglFlip",
               @"rippleEffect",
               @"pageCurl",@"pageCurl",@"pageCurl",@"pageCurl",
               @"pageUnCurl",@"pageUnCurl",@"pageUnCurl",@"pageUnCurl",
               @"CameraIrisHollowOpen",
               @"CameraIrisHollowClose"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _names.count;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section == 0 ? @"push" : @"present";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = indexPath.row < _names.count ? _names[indexPath.row] : @"转场动画";
    cell.backgroundColor = [UIColor whiteColor] ;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
//        WXSecondPushedViewController *pushedVC = [[WXSecondPushedViewController alloc] init];
        
    }else{
//        WXSecondPresentedViewController * presentedVC = [[WXSecondPresentedViewController alloc] init];
    }
}
@end
