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

+ (NSString *)getAdMobAppID {
    return @"ca-app-pub-1417781814120840~5229182600";
}

+ (NSString *)getAdMobPubID {
    return @"ca-app-pub-1417781814120840/6566315008";
}

+ (BOOL)isAdsEnabled {
    return false;
}

+ (int)getCurrentYear {
    return 2022;
}

+ (NSArray *)getYearsHijriyah {
    return @[@1443, @1444];
}

+ (NSDictionary *)getMonthsMapping {
    NSMutableDictionary *months = [[NSMutableDictionary alloc] init];
    [months setObject:@{@"name": @"JANUARI",
                        @"iname": @[
                            @"27 Jumadil Ula",
                            [NSString stringWithFormat:@"28 Jumadits Tsani %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @6,
                        @"length": @31,
                        @"prevhijriyahstart": @25,
                        @"hijriyahday1": @[@4]} forKey:@"JANUARI"];
    
    [months setObject:@{@"name": @"FEBRUARI",
                        @"iname": @[
                            @"29 Jumadits Tsani",
                            [NSString stringWithFormat:@"27 Rajab %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @2,
                        @"length": @28,
                        @"hijriyahday1": @[@2]} forKey:@"FEBRUARI"];
    
    [months setObject:@{@"name": @"MARET",
                        @"iname": @[
                            @"28 Rajab",
                            [NSString stringWithFormat:@"28 Sya'ban %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @2,
                        @"length": @31,
                        @"hijriyahday1": @[@4]} forKey:@"MARET"];
    
    [months setObject:@{@"name": @"APRIL",
                        @"iname": @[
                            @"29 Sya'ban",
                            [NSString stringWithFormat:@"29 Ramadhan %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @5,
                        @"length": @30,
                        @"hijriyahday1": @[@2]} forKey:@"APRIL"];
    
    [months setObject:@{@"name": @"MEI",
                        @"iname": @[
                            @"30 Ramadhan",
                            [NSString stringWithFormat:@"30 Syawal %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @0,
                        @"length": @31,
                        @"hijriyahday1": @[@2]} forKey:@"MEI"];
    
    [months setObject:@{@"name": @"JUNI",
                        @"iname": @[
                            @"1 Dzul Qa'dah",
                            [NSString stringWithFormat:@"1 Dzul Hijjah %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @3,
                        @"length": @30,
                        @"hijriyahday1": @[@1, @30]} forKey:@"JUNI"];
    
    [months setObject:@{@"name": @"JULI",
                        @"iname": @[
                            [NSString stringWithFormat:@"2 Dzul Hijjah %@H", [self getYearsHijriyah][0]],
                            [NSString stringWithFormat:@"2 Muharram %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @5,
                        @"length": @31,
                        @"hijriyahday1": @[@30]} forKey:@"JULI"];
    
    [months setObject:@{@"name": @"AGUSTUS",
                        @"iname": @[
                            @"3 Muharram",
                            [NSString stringWithFormat:@"2 Shafar %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @1,
                        @"length": @31,
                        @"hijriyahday1": @[@29]} forKey:@"AGUSTUS"];
    
    [months setObject:@{@"name": @"SEPTEMBER",
                        @"iname": @[
                            @"4 Shafar",
                            [NSString stringWithFormat:@"4 Rabi'ul Awal %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @4,
                        @"length": @30,
                        @"hijriyahday1": @[@27]} forKey:@"SEPTEMBER"];
    
    [months setObject:@{@"name": @"OKTOBER",
                        @"iname": @[
                            @"5 Rabi'ul Awwal",
                            [NSString stringWithFormat:@"5 Rabi'ul Akhir %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @6,
                        @"length": @31,
                        @"hijriyahday1": @[@27]} forKey:@"OKTOBER"];
    
    [months setObject:@{@"name": @"NOVEMBER",
                        @"iname": @[
                            @"6 Rabi'ul Akhir",
                            [NSString stringWithFormat:@"6 Jumadil Ula %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @2,
                        @"length": @30,
                        @"hijriyahday1": @[@25]} forKey:@"NOVEMBER"];
    
    [months setObject:@{@"name": @"DESEMBER",
                        @"iname": @[
                            @"7 Jumadil Ula",
                            [NSString stringWithFormat:@"7 Jumadits Tsani %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @4,
                        @"length": @31,
                        @"hijriyahday1": @[@25]} forKey:@"DESEMBER"];
    
    
    return months;
}

+ (NSDictionary *)getFastingDates {
    NSMutableDictionary *f = [[NSMutableDictionary alloc] init];
    [f setObject:@{@"category": @"Puasa Ramadhan",
                   @"month": @{@"APRIL": @[@2, @30],
                               @"MEI": @1}} forKey:@"Puasa Ramadhan"];

    [f setObject:@{@"category": @"Haram Berpuasa",
                   @"month": @{@"MEI": @2,
                               @"JULI": @[@9, @12]}} forKey:@"Haram Berpuasa"];
   
    [f setObject:@{@"category": @"Puasa Arafah",
                   @"month": @{@"JULI": @8}} forKey:@"Puasa Arafah"];
    
    [f setObject:@{@"category": @"Puasa Asyura dan Tasu'a",
                   @"month": @{@"AGUSTUS": @[@7, @8]}} forKey:@"Puasa Asyura dan Tasu'a"];
    
    [f setObject:@{@"category": @"Puasa Ayyamul Bidh",
                   @"month": @{@"JANUARI": @[@16, @18],
                               @"FEBRUARI": @[@14, @16],
                               @"MARET": @[@16, @18],
                               @"MEI": @[@14, @16],
                               @"JUNI": @[@13, @15],
                               @"JULI": @[@13, @14],
                               @"AGUSTUS": @[@11, @13],
                               @"SEPTEMBER": @[@10, @12],
                               @"OKTOBER": @[@9, @11],
                               @"NOVEMBER": @[@8, @10],
                               @"DESEMBER": @[@7, @9]}} forKey:@"Puasa Ayyamul Bidh"];
    
    return f;
}

+ (NSArray *)getFastingNames {
    return @[@"Puasa Ramadhan",
             @"Haram Berpuasa",
             @"Puasa Arafah",
             @"Puasa Asyura dan Tasu'a",
             @"Puasa Ayyamul Bidh",
             @"Puasa Senin Kamis"];
}

+ (NSArray *)getFastingBaseColors {
    return @[@"ed962d", @"212429", @"99489a", @"d31f5e", @"18a8df", @"3bb54a"];
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
    return  @[@"1aa8e0",
              @"95c73f",
              @"fcb03f",
              @"ef75a6",
              @"1f8fce",
              @"75b743",
              @"ec9520",
              @"ed3c84",
              @"1276b1",
              @"69a744",
              @"ef6328", 
              @"d22461"];
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
