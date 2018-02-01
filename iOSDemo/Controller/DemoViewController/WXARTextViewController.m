//
//  WXARTextViewController.m
//  iOSDemo
//
//  Created by wuxi on 2018/1/31.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXARTextViewController.h"
#import "UIViewController+Alert.h"
#import "WXARText.h"
#import "WXARTextNode.h"
#import <ARKit/ARKit.h>

@interface WXARTextViewController()<ARSCNViewDelegate>

@property (nonatomic, strong)ARSCNView *sceneView;
@property (nonatomic, strong)ARSession *arSession;

@end

@implementation WXARTextViewController

- (void)dealloc{
    NSLog(@"artextViewcontroller释放");
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self wx_showSingleInputTexFieldWithTitle:@"请输入文字" message:@"文字将以artext的方式显示" sureBlock:^(NSString *text) {
        [self showARText:text];
    } cancelBlock:^{
        
    }];
    [self setupSceneView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    configuration.planeDetection = ARPlaneDetectionHorizontal;
    [self.sceneView.session runWithConfiguration:configuration];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.sceneView.session pause];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
- (void)setupSceneView{
    self.arSession = [ARSession new];
    self.sceneView = [[ARSCNView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.sceneView.delegate = self;
    self.sceneView.session = self.arSession;
    self.sceneView.antialiasingMode = SCNAntialiasingModeMultisampling4X;//锯齿
    self.sceneView.automaticallyUpdatesLighting = YES;
    self.sceneView.contentScaleFactor = 1.1;
    self.sceneView.preferredFramesPerSecond = 60;
    self.sceneView.scene.lightingEnvironment.intensity = 25;
    self.sceneView.pointOfView.camera.wantsHDR = YES;
    self.sceneView.showsStatistics = YES;
    self.sceneView.debugOptions = ARSCNDebugOptionShowFeaturePoints;
    [self.view addSubview:self.sceneView];
}

- (void)showARText:(NSString *)text{
    if (!text || text.length == 0){
        return;
    }
    WXARText *arText = [[WXARText alloc] initWithString:text font:[UIFont systemFontOfSize:12] color:[UIColor redColor] depth:12];
    WXARTextNode *textNode = [[WXARTextNode alloc] initWithDistance:1 scnText:arText scnView:self.sceneView scale:1/100.0];
    [self.sceneView.scene.rootNode addChildNode:textNode];
}
//MARK: - ARSCNViewDelegate
- (void)session:(ARSession *)session didFailWithError:(NSError *)error{
    NSLog(@"session开启失败%@", error.localizedDescription);
}
- (void)sessionWasInterrupted:(ARSession *)session{
    NSLog(@"sessionWasInterrupted");
}
- (void)sessionInterruptionEnded:(ARSession *)session{
    NSLog(@"sessionInterruptionEnded");
}

@end
