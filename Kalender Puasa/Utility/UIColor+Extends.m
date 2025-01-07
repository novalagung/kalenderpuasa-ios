//
//  UIColor+Extends.m
//
//  Created by Noval Agung Prayogo on 4/18/13.
//  Copyright (c) 2013 Noval Agung Prayogo. All rights reserved.
//

#import "UIColor+Extends.h"

@implementation UIColor (Extends)

+ (UIColor *)withHexString:(NSString *)hex {
    return [self withHexString:hex andAlpha:1.];
}

+ (UIColor *)withHexString:(NSString *)hex andAlpha:(float)alpha {
    
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) return [UIColor grayColor];
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString length] != 6) return  [UIColor grayColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+ (UIColor *)withRGBA:(NSString *)color {
    NSArray *colors = [NSArray arrayWithArray:[color componentsSeparatedByString:@","]];
    return [UIColor colorWithRed:([[colors objectAtIndex:0] floatValue]/255.0f)
                           green:([[colors objectAtIndex:1] floatValue]/255.0f)
                            blue:([[colors objectAtIndex:2] floatValue]/255.0f)
                           alpha:[[colors objectAtIndex:3] floatValue]];
}

+ (UIColor *)random {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
