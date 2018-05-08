//
//  NSString+Regex.m
//  iOSDemo
//
//  Created by Wuxi on 2018/5/8.
//  Copyright © 2018年 Wuxi. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)

- (BOOL)regexMatchWithPattern:(NSString *)regex{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}
@end
