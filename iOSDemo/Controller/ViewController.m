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

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *sectionArray;
@property (nonatomic, strong)NSMutableArray *firstSectionTitle;
@property (nonatomic, strong)NSMutableArray *firstSectionController;

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
    self.firstSectionTitle = [NSMutableArray arrayWithObjects:@"Demo", @"Timer", @"Semaphore", @"Operation", nil];
    self.firstSectionController = [NSMutableArray arrayWithObjects:[[WXDemoViewController alloc] init],
                                                                    [[TimerViewController alloc] init],
                                                                    [[SemaphoreViewController alloc] init],
                                                                    [[OperationViewController alloc] init], nil];
    
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
    [self.navigationController pushViewController:self.firstSectionController[indexPath.row] animated:YES];
}


@end
