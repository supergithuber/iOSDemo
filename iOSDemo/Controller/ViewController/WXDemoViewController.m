//
//  WXDemoViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/12.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXDemoViewController.h"
#import "TimerViewController.h"
#import "WXCyclicScrollLabel.h"
#import "WXWebBrowser.h"
#import "iOSDemo-Swift.h"

typedef void(^myBlock)();
@interface WXDemoViewController ()<WXCyclicScrollLabelDelegate>

@property (nonatomic, weak)NSTimer *timer;

@end

@implementation WXDemoViewController

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addPushButton];
//    [self setupScrollLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)push:(UIButton *)button{
//    TimerViewController *controller = [[TimerViewController alloc] init];
//    [self.navigationController pushViewController:controller animated:YES];
    WXWebBrowser *browser = [WXWebBrowser new];
    [browser loadRemoteURLString:@"https://www.baidu.com"];
    [self.navigationController pushViewController:browser animated:YES];
}
//MARK: - setupScrollLabel
- (void)setupScrollLabel{
//    WXCyclicScrollLabel *scrollLabel = [WXCyclicScrollLabel scrollLabelWithTitle:@"免费，不要钱，快来抢，带刀来，随便拿 ,快来看啊，难得的机会啊，我的存在就是为了凑字数，字数多一点就可以换行了" type:WXScrollTypeLeftRight velocity:1 options:UIViewAnimationOptionCurveEaseInOut font:[UIFont systemFontOfSize:12] scrolllSpace:10 insets:UIEdgeInsetsMake(0, 10 , 0, 10)];
//    scrollLabel.frame = CGRectMake(10, 100, 300, 30);
//    scrollLabel.scrollLabelDelegate = self;
//    [self.view addSubview:scrollLabel];
//    [scrollLabel beginScrolling];
//
//    WXCyclicScrollLabel *upDownLabel = [WXCyclicScrollLabel scrollLabelWithTitle:@"免费，不要钱，快来抢，带刀来，随便拿 ,快来看啊，难得的机会啊，我的存在就是为了凑字数，字数多一点就可以换行了" type:WXScrollTypeUpDown velocity:2 options:UIViewAnimationOptionCurveEaseInOut font:[UIFont systemFontOfSize:12] scrolllSpace:10 insets:UIEdgeInsetsMake(0, 10 , 0, 10)];
//    upDownLabel.frame = CGRectMake(10, 150, 300, 30);
//    upDownLabel.backgroundColor = [UIColor redColor];
//    upDownLabel.scrollTitleColor = [UIColor greenColor];
//    upDownLabel.scrollLabelDelegate = self;
//    [self.view addSubview:upDownLabel];
//    [upDownLabel beginScrolling];
    
    WXCyclicScrollLabel *flipLabel = [WXCyclicScrollLabel scrollLabelWithTitle:@"免费，不要钱，快来抢，带刀来，随便拿 ,快来看啊，难得的机会啊，我的存在就是为了凑字数，字数多一点就可以换行了" type:WXScrollTypeFlipRepeat velocity:1 options:UIViewAnimationOptionCurveEaseInOut font:[UIFont systemFontOfSize:12] scrolllSpace:10 insets:UIEdgeInsetsMake(0, 10 , 0, 10)];
    flipLabel.frame = CGRectMake(10, 200, 300, 30);
    flipLabel.backgroundColor = [UIColor blueColor];
    flipLabel.scrollTitleColor = [UIColor redColor];
    flipLabel.scrollLabelDelegate = self;
    [self.view addSubview:flipLabel];
//    [flipLabel beginScrolling];
    
//    WXCyclicScrollLabel *flipNoRepeatLabel = [WXCyclicScrollLabel scrollLabelWithTitle:@"免费，不要钱，快来抢，带刀来，随便拿 ,快来看啊，难得的机会啊，我的存在就是为了凑字数，字数多一点就可以换行了" type:WXScrollTypeFlipNoRepeat velocity:1 options:UIViewAnimationOptionCurveEaseInOut font:[UIFont systemFontOfSize:12] scrolllSpace:10 insets:UIEdgeInsetsMake(0, 10 , 0, 10)];
//    flipNoRepeatLabel.frame = CGRectMake(10, 250, 300, 30);
//    flipNoRepeatLabel.backgroundColor = [UIColor cyanColor];
//    flipNoRepeatLabel.scrollLabelDelegate = self;
//    [self.view addSubview:flipNoRepeatLabel];
//    [flipNoRepeatLabel beginScrolling];
    
}

//MARK: - pushButton
- (void)addPushButton{
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeSystem];
    pushButton.backgroundColor = [UIColor redColor];
    pushButton.frame = CGRectMake(100, 100, 100, 100);
    pushButton.layer.cornerRadius = 10;
    [pushButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:pushButton];
}
//MARK: - ClosureInitScrollView
- (void)addClosureInitView{
    CGRect rect = CGRectMake(0, 64, self.view.bounds.size.width, 44);
    ClosureInitScrollView * scrollView = [[ClosureInitScrollView alloc] initWithFrame:rect numberOfLabel:^NSInteger{
        return 10;
    } labelOfIndex:^UILabel * _Nonnull(NSInteger index) {
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"hello %li", (long)index];
        //先设置大字体，再调用sizeTofit，最后在修改字体，就实现了大标签中的小字体
        //        label.font = [UIFont systemFontOfSize:12];
        //        [label sizeToFit];
        //        label.font = [UIFont systemFontOfSize:10];
        return label;
    }];
    [self.view addSubview:scrollView];
}

//MARK: - SwipHintView
- (void)initSwipHintView{
    SwipHintView * view = [[SwipHintView alloc] initWithHintImage:[UIImage imageNamed:@"guide_img_drag"] hintText:@"Switch template, and each block supports sliding adjustment angle, two-finger zoom"];
    view.frame = CGRectMake(40, 254, 295, 178);
    [self.view addSubview:view];
}

//MARK: - timer带上block
- (void)startFetchingFacebookWithVideoID:(NSString *)videoID
                            timeInterval:(NSTimeInterval)timeInterval
                                comments:(myBlock)comments
                               reactions:(myBlock)reactions
{
    if (!self.timer)
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[comments copy] forKey:@"comments"];
        [dict setObject:[reactions copy] forKey:@"reactions"];
        self.timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(getFacebookData:) userInfo:dict repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
    }
}

- (void)getFacebookData:(NSTimer *)timer
{
    myBlock comments = [[timer userInfo]objectForKey:@"comments"];
    comments();
    
    myBlock reactions = [[timer userInfo]objectForKey:@"reactions"];
    reactions();
    
}

@end
