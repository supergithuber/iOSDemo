//
//  PushAndPopViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/2/11.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "PushAndPopViewController.h"

@interface PushAndPopViewController ()

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *names;

@end

@implementation PushAndPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.names = @[@"present"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.names.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"com.iOSDemo.tableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = self.names[indexPath.row];
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            
            break;
        default:
            break;
    }
}
//MARK: - getter
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor orangeColor];
    }
    return _tableView;
}


@end
