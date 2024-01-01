//
//  NSObject+Constant.h
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 29/12/17.
//  Copyright © 2017 Noval Agung Prayogo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Constant: NSObject

+ (NSString *)getItmsUrl;
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

