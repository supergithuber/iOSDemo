//
//  WXCyclicScrollLabel.m
//  iOSDemo
//
//  Created by 吴浠 on 2018/3/15.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXCyclicScrollLabel.h"
#import "WXSingleScrollLabel.h"
#import "UIView+WXFrame.h"

@interface WXCyclicScrollLabel()

@property (nonatomic, weak)WXSingleScrollLabel *upLabel;
@property (nonatomic, weak)WXSingleScrollLabel *downLabel;
//文本行分割数组
@property (strong, nonatomic) NSArray *scrollArray;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) NSArray *scrollTexts;
//定时器
@property (strong, nonatomic) NSTimer *scrollTimer;
@property (strong, nonatomic) NSLock *timerLock;

@property (assign, nonatomic) UIViewAnimationOptions options;
//传入参数是否为数组
@property (assign, nonatomic) BOOL isArray;
//是否第一次开始计时
@property (assign, nonatomic, getter=isFirstTime) BOOL firstTime;


@end

@implementation WXCyclicScrollLabel

@synthesize scrollTextFont = _scrollTextFont;

- (void)dealloc {
    [self finishTimer];
}

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
                         font:(UIFont *)font
                  scrollSpace:(CGFloat)scrollSpace
                       insets:(UIEdgeInsets)insets{
    if (self = [super init]){
        _scrollTitle = title;
        _scrollType = type;
        self.scrollVelocity = velocity;
        _options = animationOptions;
        _scrollInsets = insets;
        _scrollSpace = scrollSpace;
        _scrollTextFont = font;
        [self setupSubviewsLayout];
    }
    return self;
}
//MARK: - 初始化方法
+ (instancetype)scrollLabelWithTitle:(NSString *)title
                                type:(WXScrollType)type
                            velocity:(CGFloat)velocity
                             options:(UIViewAnimationOptions)animationOptions
                                font:(UIFont *)font
                        scrolllSpace:(CGFloat)scrollSpace
                              insets:(UIEdgeInsets)insets{
    return [[self alloc] initWithTitle:title
                                  type:type
                              velocity:velocity
                                option:animationOptions
                                  font:font
                           scrollSpace:scrollSpace
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

- (void)setupScrollTitle:(NSString *)title{
    self.upLabel.text = title;
    self.downLabel.text = title;
}

- (void)resetScrollLabelView {
    [self endScrolling];
    [self setupSubviewsLayout];
    [self beginScrolling];
}
- (void)setupSubviewsLayout {
    switch (_scrollType) {
        case WXScrollTypeLeftRight:
            if (self.isArray){
                [self setupInitial];
            }else{
                [self setupSubviewsLayout_LeftRight];
            }
            break;
        case WXScrollTypeUpDown:
            if (self.isArray){
                [self setupInitial];
            }else{
                [self setupSubviewsLayout_UpDown];
            }
            break;
        case WXScrollTypeFlipRepeat:{
            [self setupSubviewsLayout_Flip];
            [self setupScrollTitle:_scrollTitle];
        }
            break;
        case WXScrollTypeFlipNoRepeat:{
            [self setupSubviewsLayout_Flip];
        }
            break;
        default:
            break;
    }
}
//MARK: - setup
- (void)setupSubviewsLayout_LeftRight {
    CGFloat labelMaxH = self.wx_height;//最大高度
    CGFloat labelMaxW = 0;
    CGFloat labelH = labelMaxH;//label实际高度
    __block CGFloat labelW = 0;//label宽度，有待计算
    self.contentOffset = CGPointZero;
    [self setupLRUDTypeLayoutWithMaxSize:CGSizeMake(labelMaxW, labelMaxH) width:labelW height:labelH completedHandler:^(CGSize size) {
        labelW = MAX(size.width, self.wx_width);
        //开始布局
        self.upLabel.frame = CGRectMake(_scrollInsets.left, 0, labelW, labelH);
        //由于 TXScrollLabelViewTypeLeftRight\UpDown 类型 X\Y 值均不一样，此处不再block中处理！
        self.downLabel.frame = CGRectMake(CGRectGetMaxX(self.upLabel.frame) + self.scrollSpace, 0, labelW, labelH);
    }];
}
- (void)setupSubviewsLayout_UpDown {
    CGFloat labelMaxH = 0;
    CGFloat labelMaxW = self.wx_width - _scrollInsets.left - _scrollInsets.right;
    CGFloat labelW = labelMaxW;
    __block CGFloat labelH = 0;
    
    [self setupLRUDTypeLayoutWithMaxSize:CGSizeMake(labelMaxW, labelMaxH) width:labelW height:labelH completedHandler:^(CGSize size) {
        labelH = MAX(size.height, self.wx_height);
        self.upLabel.frame = CGRectMake(_scrollInsets.left, 0, labelW, labelH);
        self.downLabel.frame = CGRectMake(_scrollInsets.left, CGRectGetMaxY(self.upLabel.frame) + self.scrollSpace, labelW, labelH);
    }];
}
- (void)setupSubviewsLayout_Flip {
    CGFloat labelW = self.wx_width - _scrollInsets.left - _scrollInsets.right;
    CGFloat labelX = _scrollInsets.left;
    self.upLabel.frame = CGRectMake(labelX, 0, labelW, self.wx_height);
    self.downLabel.frame = CGRectMake(labelX, CGRectGetMaxY(self.upLabel.frame), labelW, self.wx_height);
}

- (void)setupLRUDTypeLayoutWithMaxSize:(CGSize)size
                                 width:(CGFloat)width
                                height:(CGFloat)height
                      completedHandler:(void(^)(CGSize size))completedHandler {
    CGSize scrollLabelS = [_scrollTitle boundingRectWithSize:size
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:@{NSFontAttributeName: self.scrollTextFont} context:nil].size;
    //回调获取布局数据
    completedHandler(scrollLabelS);
    if (!self.isArray) {
        [self setupScrollTitle:_scrollTitle];
    }
}
//MARK: - begin animation
- (void)beginScrolling{
    self.currentIndex = 0;
    if (self.isArray){
        [self setupInitial];
    }
    [self startup];
}

- (void)endScrolling{
    [self finishTimer];
}

- (void)setupInitial {
    
}

- (void)startup {
    if (!self.scrollTitle.length && !self.scrollArray.count) return;
    [self endScrolling];
    
    if (self.scrollType == WXScrollTypeFlipRepeat || self.scrollType == WXScrollTypeFlipNoRepeat){
        _firstTime = YES;
        if (_scrollType == WXScrollTypeFlipNoRepeat) {
            [self setupScrollTitle:[self.scrollArray firstObject]];//初次显示
        }
        [self startScrollWithVelocity:1];
    }else{
        [self startScrollWithVelocity:self.scrollVelocity];
    }
}

- (void)startScrollWithVelocity:(CGFloat)velocity{
    if (!self.scrollTitle.length && self.scrollArray.count) return;
    
    [self.timerLock lock];
    WS(weakSelf);
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:velocity repeats:true block:^(NSTimer * _Nonnull timer) {
        [weakSelf updateScrolling];
    }];
    [[NSRunLoop mainRunLoop] addTimer:self.scrollTimer forMode:NSRunLoopCommonModes];
    [self.timerLock unlock];
}

- (void)updateScrolling {
    switch (self.scrollType) {
        case WXScrollTypeLeftRight:
            [self updateScrollingType_LeftRight];
            break;
        case WXScrollTypeUpDown:
            [self updateScrollingType_UpDown];
            break;
        case WXScrollTypeFlipRepeat:
            [self updateScrollingType_FlipRepeat];
            break;
        case WXScrollTypeFlipNoRepeat:
            [self updateScrollingType_FlipNoRepeat];
            break;
        default:
            break;
    }
}
//MARK: - updateScrolling
- (void)updateScrollingType_LeftRight{
    if (self.contentOffset.x >= (_scrollInsets.left + _upLabel.wx_width + _scrollSpace)){
        if ((self.contentOffset.x > (_scrollInsets.left + self.upLabel.wx_width) - self.wx_width) &&
            self.isArray) {
            
        }
        [self endScrolling];
        [self setContentOffset:CGPointMake(_scrollInsets.left + 1, 0)];
        [self startup];
    }else {
        self.contentOffset = CGPointMake(self.contentOffset.x + 1, self.contentOffset.y);
    }
}
- (void)updateScrollingType_UpDown{
    if (self.contentOffset.y >= (self.upLabel.wx_height + self.scrollSpace)) {
        /** 更新 Label.text */
        if ((self.contentOffset.y >= (self.upLabel.wx_height)) &&
            self.isArray) {
            
        }
        [self endScrolling];
        self.contentOffset = CGPointMake(0, 2);//y增加偏移量，防止卡顿
        [self startup];
    }else {
        self.contentOffset = CGPointMake(self.contentOffset.x, self.contentOffset.y + 1);
    }
}
- (void)updateScrollingType_FlipRepeat{
    [self updateRepeatTypeWithBlock:^(NSTimeInterval velocity) {
        [self flipAnimationWithDelay:velocity];
    }];
}
- (void)updateScrollingType_FlipNoRepeat{
    [self updateRepeatTypeWithBlock:^(NSTimeInterval velocity) {
        [self flipNoRepeatAnimationWithDelay:velocity];
    }];
}
- (void)flipNoRepeatAnimationWithDelay:(NSTimeInterval)delay{
    if (!self.scrollArray.count) return;
    
    [self updateScrollText];
    [self flipAnimationWithDelay:delay];
}
- (void)flipAnimationWithDelay:(NSTimeInterval)delay {
    [UIView transitionWithView:self.upLabel duration:delay * 0.5 options:self.options animations:^{
        self.upLabel.wx_bottom = 0;
        [UIView transitionWithView:self.upLabel duration:delay * 0.5 options:self.options animations:^{
            self.downLabel.wx_originY = 0;
        } completion:^(BOOL finished) {
            self.upLabel.wx_originY = self.wx_height;
            WXSingleScrollLabel *tempLabel = self.upLabel;
            self.upLabel = self.downLabel;
            self.downLabel = tempLabel;
        }];
    } completion:nil];
}
- (void)updateRepeatTypeWithBlock:(void(^)(NSTimeInterval))block {
    NSTimeInterval velocity = self.scrollVelocity;
    if (self.isFirstTime) {
        _firstTime = NO;
        [self endScrolling];
        [self startScrollWithVelocity:velocity];
    }
    block(velocity);
}
- (void)updateScrollText {
    
    NSInteger currentIndex = self.currentIndex;
    if (currentIndex >= self.scrollArray.count) currentIndex = 0;
    self.upLabel.text = self.scrollArray[currentIndex];
    currentIndex ++;
    if (currentIndex >= self.scrollArray.count) currentIndex = 0;
    self.downLabel.text = self.scrollArray[currentIndex];
    
    self.currentIndex = currentIndex;
}
- (void)finishTimer{
    [self.timerLock lock];
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
    self.scrollArray = nil;
    [self.timerLock unlock];
}
//MARK: - tapGesture
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
- (UIFont *)scrollTextFont{
    if (_scrollTextFont) return _scrollTextFont;
    return [UIFont systemFontOfSize:14];
}
- (void)setScrollSpace:(CGFloat)scrollSpace{
    _scrollSpace = scrollSpace;
    [self setupSubviewsLayout];
}
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setupSubviewsLayout];
}
- (void)setScrollTitle:(NSString *)scrollTitle{
    _scrollTitle = scrollTitle;
    _upLabel.text = scrollTitle;
    _downLabel.text = scrollTitle;
}
- (void)setScrollTitleColor:(UIColor *)scrollTitleColor{
    _scrollTitleColor = scrollTitleColor;
    _upLabel.textColor = scrollTitleColor;
    _downLabel.textColor = scrollTitleColor;
}
- (void)setScrollVelocity:(CGFloat)scrollVelocity{
    CGFloat velocity = scrollVelocity;
    if (velocity > 5){
        velocity = 5;
    }else if (velocity < 0.1){
        velocity = 0.1;
    }
    if (_scrollType == WXScrollTypeLeftRight || _scrollType == WXScrollTypeUpDown){
        _scrollVelocity = velocity / 30.0;
    }else{
        _scrollVelocity = velocity;
    }
    
}

@end
