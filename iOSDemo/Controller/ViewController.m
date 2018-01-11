//
//  ViewController.m
//  iOSTest
//
//  Created by Wuxi on 17/3/7.
//  Copyright © 2017年 Wuxi. All rights reserved.
//

#import "ViewController.h"
#import "TimerViewController.h"
#import "iOSDemo-Swift.h"


typedef void(^myBlock)();
@interface ViewController ()

@property (nonatomic, weak)NSTimer *timer;

@end

@implementation ViewController

- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addClosureInitView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)push:(UIButton *)button{
    TimerViewController *controller = [[TimerViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

//MARK: - pushButton
- (void)addPushButton{
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeSystem];
    pushButton.backgroundColor = [UIColor redColor];
    pushButton.frame = CGRectMake(100, 100, 100, 100);
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
