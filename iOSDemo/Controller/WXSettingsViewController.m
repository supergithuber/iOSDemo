//
//  WXSettingsViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/2/8.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXSettingsViewController.h"
#import "WXChangeIconViewController.h"

@interface WXSettingsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong)NSMutableArray *sections;
@property (nonatomic, strong)NSMutableArray *firstSection;

@end

@implementation WXSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initArray];
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initArray{
    self.sections = [NSMutableArray arrayWithObjects:@"第一部分", nil];
    self.firstSection = [NSMutableArray arrayWithObjects:@"更换图标", nil];
}
//MARK: delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.firstSection.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * const tableViewCellID = @"com.sivanwu.settingsTableviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewCellID];
    }
    cell.textLabel.text = self.firstSection[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *controller = nil;
    switch (indexPath.row) {
        case 0:
            controller = [[WXChangeIconViewController alloc] init];
            break;
            
        default:
            break;
    }
    if (controller){
        controller.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
//MARK: get
- (UITableView *)tableView{
    if (!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return  _tableView;
}

@end
