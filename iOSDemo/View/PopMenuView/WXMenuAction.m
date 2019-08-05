//
//  WXMenuAction.m
//  Demo
//
//  Created by Sivanwu on 2019/5/28.
//  Copyright © 2019年 HFY All rights reserved.
//

#import "WXMenuAction.h"

//MARK: - WXMenuAction
@implementation WXMenuAction
+ (instancetype)actionWithTitle:(NSString *)title
                          image:(UIImage *)image
                 highlightImage:(UIImage *)highlightImage
                          count:(NSInteger)count
                        handler:(void (^)(WXMenuAction *, NSInteger))handler{
    WXMenuAction *action = [[WXMenuAction alloc] initWithTitle:title
                                                         image:image
                                                highlightImage:highlightImage
                                                         count:count
                                                       handler:handler];
    return action;
}
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
               highlightImage:(UIImage *)highlightImage
                        count:(NSInteger)count
                      handler:(void (^)(WXMenuAction *, NSInteger))handler{
    if (self = [super init]) {
        _title = [title copy];
        _image = image;
        _highlightImage = highlightImage;
        _count = count;
        _handler = [handler copy];
    }
    return self;
}
@end
