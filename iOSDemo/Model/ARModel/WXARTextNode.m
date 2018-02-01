//
//  WXARTextNode.m
//  iOSDemo
//
//  Created by wuxi on 2018/2/1.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "WXARTextNode.h"
#import <ARKit/ARKit.h>

@interface WXARTextNode()<SCNBoundingVolume>
@end

@implementation WXARTextNode

- (instancetype)initWithDistance:(CGFloat)distance scnText:(SCNText *)scnText scnView:(SCNView *)scnView scale:(CGFloat)scale{
    if (self = [super init]){
        SCNNode *node = scnView.pointOfView;
        SCNMatrix4 matrix = node.transform;
        SCNVector3 vector = SCNVector3Make(-distance * matrix.m31, -distance * matrix.m32, -distance * matrix.m33);
        
        SCNVector3 currentPosition = SCNVector3Make(node.position.x + vector.x, node.position.y + vector.y, node.position.z + vector.z);
        
        self.geometry = scnText;
        self.position = currentPosition;
        self.simdRotation = node.simdRotation;
        [self resetPivot];
        self.scale = SCNVector3Make(scale, scale, scale);
    }
    return self;
}

- (void)resetPivot{
    SCNVector3 min;
    SCNVector3 max;
    [self getBoundingBoxMin:&min max:&max];
    SCNVector3 bound = SCNVector3Make(max.x - min.x, max.y - min.y, max.z - min.z);
    self.pivot = SCNMatrix4MakeTranslation(bound.x / 2, bound.y / 2, bound.z / 2);
}
@end
