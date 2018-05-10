//
//  ViewController.m
//  iOSDemo
//
//  Created by Wuxi on 17/3/7.
//  Copyright © 2017年 Wuxi. All rights reserved.
//

#import "ViewController.h"
#import "WXDemoViewController.h"
#import "TimerViewController.h"
#import "SemaphoreViewController.h"
#import "OperationViewController.h"
#import "WXCoderViewController.h"
#import "WXRotateImageViewController.h"
#import "WXARTextViewController.h"
#import "PushAndPopViewController.h"
#import "WXQRCodeViewController.h"
#import "WXBezierViewController.h"
#import "WXCoreMLViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *sectionArray;
@property (nonatomic, strong)NSMutableArray *firstSectionTitle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    self.sectionArray = [NSMutableArray arrayWithObjects:@"第一部分", nil];
    self.firstSectionTitle = [NSMutableArray arrayWithObjects:@"Demo", @"Timer", @"Semaphore control number", @"3 kinds of Operation", @"Runtime NSCoder", @"rotate Static Image", @"ARTextDemo",@"push and pop", @"scan QR code", @"Bezier Path", @"CoreML(GoogLeNetPlaces)", nil];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionArray.count;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString * const tableViewCellID = @"com.sivanwu.tableviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewCellID];
    }
    cell.textLabel.text = self.firstSectionTitle[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.firstSectionTitle.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *controller;
    switch (indexPath.row) {
        case 0:
            controller = [[WXDemoViewController alloc] init];
            break;
        case 1:
            controller = [[TimerViewController alloc] init];
            break;
        case 2:
            controller = [[SemaphoreViewController alloc] init];
            break;
        case 3:
            controller = [[OperationViewController alloc] init];
            break;
        case 4:
            controller = [[WXCoderViewController alloc] init];
            break;
        case 5:
            controller = [[WXRotateImageViewController alloc] init];
            break;
        case 6:
            controller = [[WXARTextViewController alloc] init];
            break;
        case 7:
            controller = [[PushAndPopViewController alloc] init];
            break;
        case 8:
            controller = [[WXQRCodeViewController alloc] init];
            break;
        case 9:
            controller = [[WXBezierViewController alloc] init];
            break;
        case 10:
            controller = [[WXCoreMLViewController alloc] init];
            break;
        default:
            break;
    }
    if (controller){
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}


@end
