//
//  NSObject+RateHelper.h
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 4/4/17.
//  Copyright © 2017 Noval Agung Prayogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface RateHelper: NSObject

+ (void)rateNow:(void (^)(void))completion;
+ (void)dontRateToday;
+ (void)whenRateViewTimeDo:(void (^)(void))completion;

@end
