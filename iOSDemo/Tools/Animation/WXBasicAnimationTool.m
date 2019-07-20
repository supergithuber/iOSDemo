//
//  WXBasicAnimationTool.m
//  iOSDemo
//
//  Created by Wuxi on 2019/7/18.
//  Copyright © 2019 Wuxi. All rights reserved.
//

#import "WXBasicAnimationTool.h"
#import "AppDelegate.h"

typedef NS_ENUM(NSInteger, WXBasicAnimationState){
    WXBasicAnimationNone = 0,
    WXBasicAnimationStateStarted,
    WXBasicAnimationStateEnded
};

@interface WXBasicAnimationTool ()<CAAnimationDelegate>

@property (nonatomic, copy)AnimationFinisnBlock animationFinisnBlock;
@property (nonatomic, copy)CALayer *layer;
@property (nonatomic, assign)WXBasicAnimationState state;

@end

@implementation WXBasicAnimationTool

static WXBasicAnimationTool *_instance = nil;

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    });
    return _instance;
}

- (void)startAnimationandView:(UIView *)view
                      andRect:(CGRect)rect
                andFinisnRect:(CGRect)finishRect
               andFinishBlock:(AnimationFinisnBlock)completion {
    if (_state == WXBasicAnimationStateStarted) {return;}
    
    //图层
    CALayer* layer = [CALayer layer];
    layer.contents = view.layer.contents;// 可能没有，自己换成其他的
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.contentsGravity = kCAGravityResizeAspect;
    
    // 改变做动画图片的大小
    rect.size.width = rect.size.width * 0.9;
    rect.size.height = rect.size.height * 0.9;   //重置图层尺寸
    layer.bounds = rect;
    _layer = layer;
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [delegate.window.layer addSublayer:layer];
    
    layer.position = CGPointMake(rect.origin.x+view.frame.size.width/2, CGRectGetMidY(rect)); //a 点
    // 路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:layer.position];
    
    //确定抛物线的最高点位置  controlPoint
    [path addQuadCurveToPoint:CGPointMake(CGRectGetMidX(finishRect), CGRectGetMidY(finishRect)) controlPoint:CGPointMake(SCREEN_WIDTH/2 , rect.origin.y + rect.size.height / 2.0)];
    //关键帧动画
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.path = path.CGPath;
    
    //透明度变化
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:1];
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //size变化
    CABasicAnimation *sizeAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    sizeAnimation.toValue = [NSValue valueWithCGRect:finishRect];
    sizeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    //往下抛时旋转小动画
//    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
//    rotateAnimation.removedOnCompletion = YES;
//    rotateAnimation.fromValue = [NSNumber numberWithFloat:0];
//    rotateAnimation.toValue = [NSNumber numberWithFloat:3];
//
    
//    rotateAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[pathAnimation, opacityAnimation, sizeAnimation];
    groups.duration = 0.5f;
    
    //设置之后做动画的layer不会回到一开始的位置
    groups.removedOnCompletion = NO;
    groups.fillMode=kCAFillModeForwards;
    
    groups.delegate = self;
    [layer addAnimation:groups forKey:@"group"];
    if (completion) {
        _animationFinisnBlock = completion;
    }
}

- (void)animationDidStart:(CAAnimation *)anim{
    _state = WXBasicAnimationStateStarted;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (anim == [_layer animationForKey:@"group"]) {
        _state = WXBasicAnimationStateEnded;
        [_layer removeFromSuperlayer];
        _layer = nil;
        if (_animationFinisnBlock) {
            _animationFinisnBlock(YES);
        }
    }
}
@end
