//
//  NSObject+RateHelper.m
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 4/4/17.
//  Copyright © 2017 Noval Agung Prayogo. All rights reserved.
//

#import "RateHelper.h"
#import "Constant.h"

@implementation RateHelper

static NSString *rateKey = @"rate";
static NSString *rateTimeKey = @"rate-time";

+ (NSDateFormatter*)getFormatter {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierISO8601];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US_POSIX"];
    formatter.timeZone = [[NSTimeZone alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    return formatter;
}

+ (BOOL)isRated {
    return [NSUserDefaults.standardUserDefaults integerForKey:rateKey] == 2;
}

+ (BOOL)isShowingUpToday {
    return [NSUserDefaults.standardUserDefaults integerForKey:rateKey] == 1;
}

+ (void)setRateStatus:(int)status {
    NSString *nowString = [[self getFormatter] stringFromDate:[[NSDate alloc] init]];
    [NSUserDefaults.standardUserDefaults setInteger:status forKey:rateKey];
    [NSUserDefaults.standardUserDefaults setValue:nowString forKey:rateTimeKey];
    [NSUserDefaults.standardUserDefaults synchronize];
}

+ (void)resetIfDateIsChanged {
    NSString *nowString = [[self getFormatter] stringFromDate:[[NSDate alloc] init]];
    NSString *timeData = [NSUserDefaults.standardUserDefaults stringForKey:rateTimeKey];
    if (timeData == NULL) {
        [self setRateStatus:0];
    } else {
        if (![timeData isEqualToString:nowString]) {
            [self setRateStatus:0];
        }
    }
}

+ (void)rateNow:(void (^)(void))completion {
    [self setRateStatus:2];
    
    NSURL *url = [NSURL URLWithString:Constant.getItmsUrl];
    [UIApplication.sharedApplication openURL:url options:nil completionHandler:nil];
    
    completion();
}

+ (void)dontRateToday {
    [self setRateStatus:1];
}

+ (void)whenRateViewTimeDo:(void (^)(void))completion {
    if ([self isRated]) {
        return;
    }
    
    [self resetIfDateIsChanged];
    if ([self isShowingUpToday]) {
        return;
    }
    
    completion();
}

@end
