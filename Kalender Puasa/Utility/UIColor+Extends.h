//
//  UIColor+Extends.h
//
//  Created by Noval Agung Prayogo on 4/18/13.
//  Copyright (c) 2013 Noval Agung Prayogo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extends)

+ (UIColor *)withHexString:(NSString *)hex;
+ (UIColor *)withHexString:(NSString *)hex andAlpha:(float)alpha;
+ (UIColor *)withRGBA:(NSString *)color;
+ (UIColor *)random;

@end
