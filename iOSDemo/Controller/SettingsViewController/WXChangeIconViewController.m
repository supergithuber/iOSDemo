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

@end

@implementation WXChangeIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    switch (indexPath.row) {
        case 0:
            cell.image = [UIImage imageNamed:@"icon_demo"];
            break;
        case 1:
            cell.image = [UIImage imageNamed:@"icon_blue"];
            break;
        case 2:
            cell.image = [UIImage imageNamed:@"icon_ball"];
            break;
        case 3:
            cell.image = [UIImage imageNamed:@"icon_red"];
            break;
        default:
            break;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
