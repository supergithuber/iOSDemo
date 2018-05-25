//
//  PushAndPopViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/2/11.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "PushAndPopViewController.h"
#import "WXSecondPresentedViewController.h"
#import "WXSystemPushAndPopTableViewController.h"

@interface PushAndPopViewController ()

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,copy)   NSArray *names;
@property (nonatomic,copy)   NSArray *customNames;

@end

@implementation PushAndPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    _names = @[@"pageTransition"];
    _customNames = @[@"poitnt spread from tap center",@"test "];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//MARK: - tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
        case 2:
            return _names.count;
            break;
        default:
            return _customNames.count;
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 25)];
    label.font = [UIFont systemFontOfSize:25];
    
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    switch (section) {
        case 0:
            label.text = @"systerm";
            break;
        case 1:
            label.text = @"push";
            break;
        case 2:
            label.text = @"present";
            break;
        default:
            label.text = @"custom";
            break;
    }
    
    return label;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 26;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.000001;
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
            cell.textLabel.text = @"systerm";
            break;
        case 1:
        case 2:
            cell.textLabel.text = indexPath.row < _names.count ? _names[indexPath.row] : @"other";
            break;
        case 3:
            cell.textLabel.text = indexPath.row < _customNames.count ? _customNames[indexPath.row] : @"other";
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:{
            WXSystemPushAndPopTableViewController *vc = [[WXSystemPushAndPopTableViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:{
            
            break;
        }
        case 2:{
            break;
        }
        case 3:{
            break;
        }
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
