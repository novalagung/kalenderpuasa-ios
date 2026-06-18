//
//  NSObject+Constant.m
//  Kalender Puasa
//
//  Created by Noval Agung Prayogo on 29/12/17.
//  Copyright © 2017 Noval Agung Prayogo. All rights reserved.
//

#import "Constant.h"

@implementation Constant

+ (NSString *)getItmsUrl {
    return @"itms-apps://itunes.apple.com/app/id796222919";
}

+ (int)getCurrentYear {
    return 2026;
}

+ (NSArray *)getYearsHijriyah {
    return @[@1447, @1448];
}

+ (NSDictionary *)getMonthsMapping {
    NSMutableDictionary *months = [[NSMutableDictionary alloc] init];
    [months setObject:@{@"name": @"JANUARI",
                        @"iname": @[
                            @"12 Rajab",
                            [NSString stringWithFormat:@"12 Sya'ban %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @4,
                        @"length": @31,
                        @"prevhijriyahstart": @10,
                        @"hijriyahday1": @[@20]} forKey:@"JANUARI"];
    
    [months setObject:@{@"name": @"FEBRUARI",
                        @"iname": @[
                            @"13 Sya'ban",
                            [NSString stringWithFormat:@"10 Ramadhan %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @0,
                        @"length": @28,
                        @"hijriyahday1": @[@19]} forKey:@"FEBRUARI"];
    
    [months setObject:@{@"name": @"MARET",
                        @"iname": @[
                            @"11 Ramadhan",
                            [NSString stringWithFormat:@"11 Syawal %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @0,
                        @"length": @31,
                        @"hijriyahday1": @[@21]} forKey:@"MARET"];
    
    [months setObject:@{@"name": @"APRIL",
                        @"iname": @[
                            @"12 Syawal",
                            [NSString stringWithFormat:@"12 Dzulqa'dah %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @3,
                        @"length": @30,
                        @"hijriyahday1": @[@19]} forKey:@"APRIL"];
    
    [months setObject:@{@"name": @"MEI",
                        @"iname": @[
                            @"13 Dzulqa'dah",
                            [NSString stringWithFormat:@"14 Dzulhijjah %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @5,
                        @"length": @31,
                        @"hijriyahday1": @[@18]} forKey:@"MEI"];
    
    [months setObject:@{@"name": @"JUNI",
                        @"iname": @[
                            [NSString stringWithFormat:@"15 Dzulhijjah %@H", [self getYearsHijriyah][0]],
                            [NSString stringWithFormat:@"15 Muharram %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @1,
                        @"length": @30,
                        @"hijriyahday1": @[@16]} forKey:@"JUNI"];
    
    [months setObject:@{@"name": @"JULI",
                        @"iname": @[
                            @"16 Muharram",
                            [NSString stringWithFormat:@"@16 Shafar %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @3,
                        @"length": @31,
                        @"hijriyahday1": @[@16]} forKey:@"JULI"];
    
    [months setObject:@{@"name": @"AGUSTUS",
                        @"iname": @[
                            @"17 Shafar",
                            [NSString stringWithFormat:@"18 Rabi'ul Awal %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @6,
                        @"length": @31,
                        @"hijriyahday1": @[@14]} forKey:@"AGUSTUS"];
    
    [months setObject:@{@"name": @"SEPTEMBER",
                        @"iname": @[
                            @"19 Rabi'ul Awal",
                            [NSString stringWithFormat:@"18 Rabi'ul Akhir %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @2,
                        @"length": @30,
                        @"hijriyahday1": @[@13]} forKey:@"SEPTEMBER"];
    
    [months setObject:@{@"name": @"OKTOBER",
                        @"iname": @[
                            @"19 Rabi'ul Akhir",
                            [NSString stringWithFormat:@"20 Jumadil Awal %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @4,
                        @"length": @31,
                        @"hijriyahday1": @[@12]} forKey:@"OKTOBER"];
    
    [months setObject:@{@"name": @"NOVEMBER",
                        @"iname": @[
                            @"21 Jumadil Awal",
                            [NSString stringWithFormat:@"20 Jumadil Akhir %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @0,
                        @"length": @30,
                        @"hijriyahday1": @[@11]} forKey:@"NOVEMBER"];
    
    [months setObject:@{@"name": @"DESEMBER",
                        @"iname": @[
                            @"21 Jumadil Akhir",
                            [NSString stringWithFormat:@"22 Rajab %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @2,
                        @"length": @31,
                        @"hijriyahday1": @[@10]} forKey:@"DESEMBER"];
    
    
    return months;
}

+ (NSDictionary *)getFastingDates {
    NSMutableDictionary *f = [[NSMutableDictionary alloc] init];
    [f setObject:@{@"category": @"Puasa Ramadhan",
                   @"month": @{@"FEBRUARI": @[@19, @28],
                               @"MARET": @[@1, @20]}} forKey:@"Puasa Ramadhan"];

    [f setObject:@{@"category": @"Haram Berpuasa",
                   @"month": @{@"MARET": @21,
                               @"MEI": @[@27, @30]}} forKey:@"Haram Berpuasa"];
   
    [f setObject:@{@"category": @"Puasa Arafah",
                   @"month": @{@"MEI": @26}} forKey:@"Puasa Arafah"];
    
    [f setObject:@{@"category": @"Puasa Asyura & Tasu'a",
                   @"month": @{@"JUNI": @[@24, @25]}} forKey:@"Puasa Asyura & Tasu'a"];

    [f setObject:@{@"category": @"Puasa Ayyamul Bidh",
                   @"month": @{@"JANUARI": @[@2, @4],
                               @"FEBRUARI": @[@1, @3],
                               @"APRIL": @[@2, @4],
                               @"MEI": @[@1, @2, @3, @31],
                               @"JUNI": @[@1, @28, @29, @30],
                               @"JULI": @[@28, @30],
                               @"AGUSTUS": @[@26, @28],
                               @"SEPTEMBER": @[@25, @27],
                               @"OKTOBER": @[@24, @26],
                               @"NOVEMBER": @[@23, @25],
                               @"DESEMBER": @[@22, @24]}} forKey:@"Puasa Ayyamul Bidh"];
    
    return f;
}

+ (NSArray *)getFastingNames {
    return @[@"Puasa Ramadhan",
             @"Haram Berpuasa",
             @"Puasa Arafah",
             @"Puasa Asyura & Tasu'a",
             @"Puasa Ayyamul Bidh",
             @"Puasa Senin Kamis"];
}

+ (NSArray *)getFastingBaseColors {
    return @[@"ed962d", @"212429", @"99489a", @"f45d92", @"18a8df", @"5ca904"];
}

+ (NSArray *)getNumbersInArabic {
    return @[@"٠", @"١", @"٢", @"٣", @"٤", @"٥", @"٦", @"٧", @"٨", @"٩"];
}

+ (NSArray *)getMonthsName {
    return @[@"JANUARI",
             @"FEBRUARI",
             @"MARET",
             @"APRIL",
             @"MEI",
             @"JUNI",
             @"JULI",
             @"AGUSTUS",
             @"SEPTEMBER",
             @"OKTOBER",
             @"NOVEMBER",
             @"DESEMBER"];
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
