//
//  WXVolumeButtonHandler.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/18.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXVolumeButtonHandler.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

static NSString *const sessionVolumeKeyPath = @"outputVolume";
static void *sessionContext                 = &sessionContext;
static CGFloat maxVolume                    = 0.99999f;
static CGFloat minVolume                    = 0.00001f;

@interface WXVolumeButtonHandler()

@property (nonatomic, copy)WXVolumeButtonBlock upBlock;
@property (nonatomic, copy)WXVolumeButtonBlock downBlock;

@property (nonatomic, assign)CGFloat initialVolume;
@property (nonatomic, strong)AVAudioSession *audioSession;
@property (nonatomic, strong)MPVolumeView *volumeView;
@property (nonatomic, assign)BOOL isAppActive;

@end

@implementation WXVolumeButtonHandler

- (void)dealloc{
    [self.audioSession removeObserver:self forKeyPath:sessionVolumeKeyPath];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.volumeView removeFromSuperview];
}
//MARK: - init
- (instancetype)initWithUpBlock:(WXVolumeButtonBlock)upBlock downBlock:(WXVolumeButtonBlock)downBlock {
    if (self = [super init]){
        _upBlock = upBlock;
        _downBlock = downBlock;
        _isAppActive = YES;
        [self setupAudioSession];
        //监听APP是否活跃
        [self initNotification];
    }
    return self;
}

+ (instancetype)volumnButtonHandlerWithUpBlock:(WXVolumeButtonBlock)upBlock downBlock:(WXVolumeButtonBlock)downBlock {
    return [[WXVolumeButtonHandler alloc] initWithUpBlock:upBlock downBlock:downBlock];
}

//MARK: - setup
- (void)setupAudioSession {
    NSError *error = nil;
    _audioSession = [AVAudioSession sharedInstance];
    //AVAudioSessionCategoryPlayback: for music tracks
    //AVAudioSessionCategoryOptionMixWithOthers: 是否可以和其他的后台声音混音
    [_audioSession setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&error];
    if (error){
        NSLog(@"init audioSession error%@", error);
        return;
    }
    [_audioSession setActive:YES error:&error];
    if (error){
        NSLog(@"set audioSession active error%@", error);
        return;
    }
    //KVO:outputVolume
    [_audioSession addObserver:self forKeyPath:sessionVolumeKeyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:sessionContext];
    
}
- (void)initNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidChangeActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidChangeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    //这里不支持后台，APP退到后台以后，声音停止，回到前台后，重新设置为激活
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionInterrupt:) name:AVAudioSessionInterruptionNotification object:nil];
}
- (void)disableSystemVolumeHUDWithCompletion:(void(^)())completion{
    self.volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(MAXFLOAT, MAXFLOAT, 0, 0)];
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self.volumeView];
}
- (void)setInitialVolume {
    self.initialVolume = self.audioSession.outputVolume;
    if (self.initialVolume > maxVolume){
        self.initialVolume = maxVolume;
    }else if (self.initialVolume < minVolume){
        self.initialVolume = minVolume;
    }
}

//MARK: - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (context == sessionContext){
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
//MARK: - Notification
- (void)applicationDidChangeActive:(NSNotification *)notification {
    self.isAppActive = [notification.name isEqualToString:UIApplicationDidBecomeActiveNotification];
    if (_isAppActive){
        
    }
}
- (void)audioSessionInterrupt:(NSNotification *)notification{
    NSDictionary *interuptionDict = notification.userInfo;
    NSInteger interuptionType = [[interuptionDict valueForKey:AVAudioSessionInterruptionTypeKey] integerValue];
    switch (interuptionType) {
        case AVAudioSessionInterruptionTypeBegan:
            break;
        case AVAudioSessionInterruptionTypeEnded:
        {
            NSError *error = nil;
            [self.audioSession setActive:YES error:&error];
            if (error) {
                NSLog(@"re-active audioSession active %@", error);
            }
            break;
        }
        default:
            break;
    }
}
//MARK: - setSystemVolume
- (void)setSystemVolume:(CGFloat)volume{
    UISlider *volumeViewSlider = nil;
    for (UIView *view in self.volumeView.subviews) {
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    [volumeViewSlider setValue:volume animated:NO];
    [volumeViewSlider sendActionsForControlEvents:UIControlEventTouchUpInside];
}
@end
