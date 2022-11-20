//
//  UIDevice+Extends.m
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDevice+Extends.h"

@implementation UIDevice (Extends)

+ (BOOL)isIPad {
    return [(NSString*)[UIDevice currentDevice].model rangeOfString:@"iPad"].location != NSNotFound;
}

+ (BOOL)isIphones_4_4s {
    return (int)[[UIScreen mainScreen] nativeBounds].size.height == 960;
}

+ (BOOL)isIphones_5_5s_5c_SE {
    return (int)[[UIScreen mainScreen] nativeBounds].size.height == 1136;
}

+ (BOOL)isIphones_6_6s_7_8 {
    return (int)[[UIScreen mainScreen] nativeBounds].size.height == 1334;
}

+ (CGFloat)statusBarHeight {
    CGSize size = [[UIApplication sharedApplication] statusBarFrame].size;
    return MIN(size.width, size.height);
}

//case 960:
//           return .iPhones_4_4S
//       case 1136:
//           return .
//       case 1334:
//           return .
//       case 1920, 2208:
//           return .
//       case 2426:
//           return .
//       case 2436:
//           return .
//       case 2532:
//           return .
//       case 2688:
//           return .
//       case 2778:
//           return .
//       default:
//           return .unknown

@end
