//
//  WXCoderViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/22.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXCoderViewController.h"
#import "WXUserInfoModel.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>

@interface WXCoderViewController ()

@end

@implementation WXCoderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initButtonView];
    
    [self printModelPropertyCount];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initButtonView{
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *readButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setBackgroundColor:[UIColor greenColor]];
    [readButton setBackgroundColor:[UIColor redColor]];
    [saveButton setTitle:@"save" forState:UIControlStateNormal];
    [readButton setTitle:@"read" forState:UIControlStateNormal];
    [saveButton addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [readButton addTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveButton];
    [self.view addSubview:readButton];
    
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.left.mas_equalTo(self.view).offset(10);
        make.top.mas_equalTo(self.view).offset(200);
    }];
    [readButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.view).offset(200);
    }];
}

- (void)printModelPropertyCount{
    unsigned int count = 0; //成员变量的个数
    Ivar *ivarList =  class_copyIvarList(WXUserInfoModel.class, &count);
    Ivar ivar1 = ivarList[0];
    NSLog(@"第一个属性名%s",ivar_getName(ivar1));
    Ivar ivar2 = ivarList[1];
    NSLog(@"第二个属性名%s",ivar_getName(ivar2));
    //  打印WXUserInfoModel里面的成员属性的个数
    NSLog(@"总属性个数%d",count);
}
- (void)save:(id)sender{
    WXUserInfoModel *model = [WXUserInfoModel new];
    model.name = @"flowerflower";
    model.phoneNumber = 12121212;
    //归档
    [NSKeyedArchiver archiveRootObject:model toFile:[kPathDocument stringByAppendingPathComponent:@"wxUserInfo"]];
}
- (void)read:(id)sender{
    WXUserInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:[kPathDocument stringByAppendingPathComponent:@"wxUserInfo"]];
    NSLog(@"%@----%ld",model.name,(long)model.phoneNumber);
}
@end
