//
//  NSObject+Constant.m
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 29/12/17.
//  Copyright © 2017 Noval Agung Prayogo. All rights reserved.
//

#import "Constant.h"
#import "CalendarDataLoader.h"

@implementation Constant

+ (NSString *)getItmsUrl {
    return @"itms-apps://itunes.apple.com/app/id796222919";
}

+ (int)getCurrentYear {
    return 2026;
}

+ (NSDictionary *)currentMethodData {
    NSDictionary *methodData = [CalendarDataLoader methodDataForYear:[self getCurrentYear] methodId:nil];
    return methodData ?: @{};
}

+ (NSArray *)getYearsHijriyah {
    NSArray *hijriYears = [[self currentMethodData] valueForKey:@"hijriYears"];
    return [hijriYears isKindOfClass:[NSArray class]] ? hijriYears : @[];
}

+ (NSDictionary *)getMonthsMapping {
    NSMutableDictionary *months = [[NSMutableDictionary alloc] init];
    NSArray *monthsData = [[self currentMethodData] valueForKey:@"months"];
    if (![monthsData isKindOfClass:[NSArray class]]) {
        return months;
    }
    
    for (NSDictionary *monthData in monthsData) {
        NSString *monthName = [monthData valueForKey:@"name"];
        if (monthName.length == 0) {
            continue;
        }
        
        NSMutableDictionary *month = [NSMutableDictionary dictionaryWithDictionary:monthData];
        [month removeObjectForKey:@"id"];
        [month removeObjectForKey:@"nameKey"];
        months[monthName] = month;
    }
    
    return months;
}

+ (NSDictionary *)getFastingDates {
    NSMutableDictionary *fastingDates = [[NSMutableDictionary alloc] init];
    NSArray *fastingData = [[self currentMethodData] valueForKey:@"fastingDates"];
    if (![fastingData isKindOfClass:[NSArray class]]) {
        return fastingDates;
    }
    
    for (NSDictionary *fasting in fastingData) {
        NSString *category = [fasting valueForKey:@"category"];
        if (category.length == 0) {
            continue;
        }
        
        fastingDates[category] = fasting;
    }
    
    return fastingDates;
}

+ (NSArray *)getFastingNames {
    NSMutableArray *fastingNames = [NSMutableArray array];
    NSArray *fastingData = [[self currentMethodData] valueForKey:@"fastingDates"];
    if ([fastingData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *fasting in fastingData) {
            NSString *category = [fasting valueForKey:@"category"];
            if (category.length > 0) {
                [fastingNames addObject:category];
            }
        }
    }
    
    [fastingNames addObject:@"Puasa Senin Kamis"];
    return fastingNames;
}

+ (NSArray *)getFastingBaseColors {
    return @[@"ed962d", @"212429", @"99489a", @"f45d92", @"18a8df", @"5ca904"];
}

+ (NSArray *)getNumbersInArabic {
    return @[@"٠", @"١", @"٢", @"٣", @"٤", @"٥", @"٦", @"٧", @"٨", @"٩"];
}

+ (NSArray *)getMonthsName {
    NSMutableArray *monthNames = [NSMutableArray array];
    NSArray *monthsData = [[self currentMethodData] valueForKey:@"months"];
    if ([monthsData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *month in monthsData) {
            NSString *name = [month valueForKey:@"name"];
            if (name.length > 0) {
                [monthNames addObject:name];
            }
        }
    }
    
    return monthNames;
}

+ (NSArray *)getMonthsBaseColor {
    return  @[@"ef6a9b",
              @"f9a37d",
              @"feb51a",
              @"865ca5",
              @"ef6a9b",
              @"f9a37d",
              @"feb51a",
              @"865ca5",
              @"ef6a9b",
              @"f9a37d",
              @"feb51a",
              @"865ca5"];
}

+ (NSArray *)getDaysName {
    return @[@"Ahad",
             @"Senin",
             @"Selasa",
             @"Rabu",
             @"Kamis",
             @"Jum'at",
             @"Sabtu"];
}

@end
