//
//  WXIconCollectionViewCell.m
//  iOSDemo
//
//  Created by wuxi on 2018/2/22.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXIconCollectionViewCell.h"

@interface WXIconCollectionViewCell()

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation WXIconCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.imageView];
}
- (void)setImage:(UIImage *)image{
    if (self.imageView){
        [self.imageView setImage:image];
    }
}

@end
