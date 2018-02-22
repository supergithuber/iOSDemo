//
//  WXChangeIconViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/2/22.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXChangeIconViewController.h"
#import "WXIconCollectionViewCell.h"

static NSString *const kCollectionViewCellIdentifier = @"iOSDemo.IconCell";

@interface WXChangeIconViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *icons;

@end

@implementation WXChangeIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.icons = [NSMutableArray arrayWithObjects:@"icon_demo", @"icon_blue", @"icon_ball", @"icon_red", nil];
    [self.view addSubview:self.collectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionView *)collectionView{
    if (!_collectionView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(120, 120);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[WXIconCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
    }
    return _collectionView;
}

//MARK: delegate and datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WXIconCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.image = [UIImage imageNamed:self.icons[indexPath.row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self changeAppIcon:self.icons[indexPath.row]];
}
- (void)changeAppIcon:(NSString *)iconName{
    UIApplication *application = [UIApplication sharedApplication];
    if ([application supportsAlternateIcons]){
        [application setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
            if (error){
                NSLog(@"更换图标失败%@",error);
            }else{
                NSLog(@"更换图标成功");
            }
        }];
    }else{
        NSLog(@"不支持更换图标");
    }
}
//系统的更换图标会有弹框,更换App图标时的弹框是没有title与message的
//自己添加一个UIViewController的catogory，加入下面代码，用runtime可以拦截弹框
//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
//        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(wx_presentViewController:animated:completion:));
//        // 交换方法实现
//        method_exchangeImplementations(presentM, presentSwizzlingM);
//    });
//}
//- (void)wx_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
//
//    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
//        NSLog(@"title : %@",((UIAlertController *)viewControllerToPresent).title);
//        NSLog(@"message : %@",((UIAlertController *)viewControllerToPresent).message);
//
//        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
//        if (alertController.title == nil && alertController.message == nil) {
//            return;
//        } else {
//            [self wx_presentViewController:viewControllerToPresent animated:flag completion:completion];
//            return;
//        }
//    }
//
//    [self wx_presentViewController:viewControllerToPresent animated:flag completion:completion];
//}
@end
