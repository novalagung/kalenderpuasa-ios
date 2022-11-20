//
//  UIDevice+Extends.h
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Extends)

+ (BOOL)isIPad;
+ (BOOL)isIphones_4_4s;
+ (BOOL)isIphones_5_5s_5c_SE;
+ (BOOL)isIphones_6_6s_7_8;
+ (CGFloat)statusBarHeight;

@end
