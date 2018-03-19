//
//  WXCyclicScrollLabel.m
//  iOSDemo
//
//  Created by 吴浠 on 2018/3/15.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXCyclicScrollLabel.h"
#import "WXSingleScrollLabel.h"

@interface WXCyclicScrollLabel()

@property (nonatomic, weak)WXSingleScrollLabel *upLabel;
@property (nonatomic, weak)WXSingleScrollLabel *downLabel;
//文本行分割数组
@property (strong, nonatomic) NSArray *scrollArray;
@property (strong, nonatomic) NSArray *scrollTexts;

@property (assign, nonatomic) UIViewAnimationOptions options;

@end

@implementation WXCyclicScrollLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor blackColor];
        [self setupScrollLabel];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                         type:(WXScrollType)type
                     velocity:(CGFloat)velocity
                       option:(UIViewAnimationOptions)animationOptions
                       insets:(UIEdgeInsets)insets{
    if (self = [super init]){
        _scrollTitle = title;
        _scrollType = type;
        _scrollVelocity = velocity;
        _options = animationOptions;
        _scrollInsets = insets;
    }
    return self;
}
//MARK: 初始化方法
+ (instancetype)scrollLabelWithTitle:(NSString *)title
                                type:(WXScrollType)type
                            velocity:(CGFloat)velocity
                             options:(UIViewAnimationOptions)animationOptions
                              insets:(UIEdgeInsets)insets{
    return [[self alloc] initWithTitle:title
                                  type:type
                              velocity:velocity
                                option:animationOptions
                                insets:insets];
}

- (void)setupScrollLabel{
    WXSingleScrollLabel *upLabel = [WXSingleScrollLabel singleScrollLabel];
    WXSingleScrollLabel *downLabel = [WXSingleScrollLabel singleScrollLabel];
    UITapGestureRecognizer *tapUpLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel:)];
    UITapGestureRecognizer *tapDownLabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel:)];
    [upLabel addGestureRecognizer:tapUpLabelGesture];
    [downLabel addGestureRecognizer:tapDownLabelGesture];
    self.upLabel = upLabel;
    self.downLabel = downLabel;
    [self addSubview:upLabel];
    [self addSubview:downLabel];
}
- (void)setupSubviewsLayout {
    
}

- (void)beginScrolling{
    
}

- (void)endScrolling{
    
}

//MARK: tapGesture
- (void)tapLabel:(UITapGestureRecognizer *)tapGesture {
    UILabel *tapView = (UILabel *)tapGesture.view;
    if (!tapView || [tapView isKindOfClass:[UILabel class]]){
        return;
    }
    NSInteger index = 0;
    if(self.scrollArray.count) index = [self.scrollArray indexOfObject:tapView.text];
    if (self.scrollLabelDelegate && [self.scrollLabelDelegate respondsToSelector:@selector(scrollLabel:didClickWithText:atIndex:)]){
        [self.scrollLabelDelegate scrollLabel:self didClickWithText:tapView.text atIndex:index];
    }
}

//MARK: - set and get
- (void)setScrollTextFont:(UIFont *)scrollTextFont{
    _scrollTextFont = scrollTextFont;
    _upLabel.font = scrollTextFont;
    _downLabel.font = scrollTextFont;
    [self setupSubviewsLayout];
}

@end
