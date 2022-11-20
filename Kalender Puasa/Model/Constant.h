//
//  NSObject+Constant.h
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 29/12/17.
//  Copyright © 2017 Noval Agung Prayogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface Constant: NSObject

+ (NSString *)getItmsUrl;
+ (NSString *)getAdMobAppID;
+ (NSString *)getAdMobPubID;
+ (BOOL)isAdsEnabled;
+ (int)getCurrentYear;
+ (NSArray *)getDaysName;
+ (NSArray *)getMonthsBaseColor;
+ (NSArray *)getMonthsName;
+ (NSDictionary *)getMonthsMapping;
+ (NSDictionary *)getFastingDates;
+ (NSArray *)getFastingNames;
+ (NSArray *)getFastingBaseColors;
+ (NSArray *)getYearsHijriyah;
+ (NSArray *)getNumbersInArabic;

@end

