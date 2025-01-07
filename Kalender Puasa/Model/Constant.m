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
    return 2025;
}

+ (NSArray *)getYearsHijriyah {
    return @[@1446, @1447];
}

+ (NSDictionary *)getMonthsMapping {
    NSMutableDictionary *months = [[NSMutableDictionary alloc] init];
    [months setObject:@{@"name": @"JANUARI",
                        @"iname": @[
                            @"1 Rajab",
                            [NSString stringWithFormat:@"1 Sya'ban %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @3,
                        @"length": @31,
                        @"prevhijriyahstart": @28,
                        @"hijriyahday1": @[@1, @31]} forKey:@"JANUARI"];
    
    [months setObject:@{@"name": @"FEBRUARI",
                        @"iname": @[
                            @"2",
                            [NSString stringWithFormat:@"29 Sya'ban %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @6,
                        @"length": @28,
                        @"hijriyahday1": @[]} forKey:@"FEBRUARI"];
    
    [months setObject:@{@"name": @"MARET",
                        @"iname": @[
                            @"1 Ramadhan",
                            [NSString stringWithFormat:@"1 Syawal %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @6,
                        @"length": @31,
                        @"hijriyahday1": @[@1, @31]} forKey:@"MARET"];
    
    [months setObject:@{@"name": @"APRIL",
                        @"iname": @[
                            @"2 Syawal",
                            [NSString stringWithFormat:@"2 Dzulqa'dah %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @2,
                        @"length": @30,
                        @"hijriyahday1": @[@29]} forKey:@"APRIL"];
    
    [months setObject:@{@"name": @"MEI",
                        @"iname": @[
                            @"3 Dzulqa'dah",
                            [NSString stringWithFormat:@"4 Dzulhijjah %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @4,
                        @"length": @31,
                        @"hijriyahday1": @[@28]} forKey:@"MEI"];
    
    [months setObject:@{@"name": @"JUNI",
                        @"iname": @[
                            [NSString stringWithFormat:@"5 Dzulhijjah %@H", [self getYearsHijriyah][0]],
                            [NSString stringWithFormat:@"4 Muharram %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @0,
                        @"length": @30,
                        @"hijriyahday1": @[@27]} forKey:@"JUNI"];
    
    [months setObject:@{@"name": @"JULI",
                        @"iname": @[
                            @"5 Muharram",
                            [NSString stringWithFormat:@"6 Shafar %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @2,
                        @"length": @31,
                        @"hijriyahday1": @[@26]} forKey:@"JULI"];
    
    [months setObject:@{@"name": @"AGUSTUS",
                        @"iname": @[
                            @"7 Shafar",
                            [NSString stringWithFormat:@"7 Rabi'ul Awal %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @5,
                        @"length": @31,
                        @"hijriyahday1": @[@25]} forKey:@"AGUSTUS"];
    
    [months setObject:@{@"name": @"SEPTEMBER",
                        @"iname": @[
                            @"8 Rabi'ul Awal",
                            [NSString stringWithFormat:@"8 Rabi'ul Akhir %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @1,
                        @"length": @30,
                        @"hijriyahday1": @[@23]} forKey:@"SEPTEMBER"];
    
    [months setObject:@{@"name": @"OKTOBER",
                        @"iname": @[
                            @"9 Rabi'ul Akhir",
                            [NSString stringWithFormat:@"9 Jumadil Awal %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @3,
                        @"length": @31,
                        @"hijriyahday1": @[@23]} forKey:@"OKTOBER"];
    
    [months setObject:@{@"name": @"NOVEMBER",
                        @"iname": @[
                            @"10 Jumadil Awal",
                            [NSString stringWithFormat:@"9 Jumadil Akhir %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @6,
                        @"length": @30,
                        @"hijriyahday1": @[@22]} forKey:@"NOVEMBER"];
    
    [months setObject:@{@"name": @"DESEMBER",
                        @"iname": @[
                            @"10 Jumadil Akhir",
                            [NSString stringWithFormat:@"11 Rajab %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @1,
                        @"length": @31,
                        @"hijriyahday1": @[@21]} forKey:@"DESEMBER"];
    
    
    return months;
}

+ (NSDictionary *)getFastingDates {
    NSMutableDictionary *f = [[NSMutableDictionary alloc] init];
    [f setObject:@{@"category": @"Puasa Ramadhan",
                   @"month": @{@"MARET": @[@1, @30]}} forKey:@"Puasa Ramadhan"];

    [f setObject:@{@"category": @"Haram Berpuasa",
                   @"month": @{@"MARET": @31,
                               @"JUNI": @[@6, @9]}} forKey:@"Haram Berpuasa"];
   
    [f setObject:@{@"category": @"Puasa Arafah",
                   @"month": @{@"JUNI": @5}} forKey:@"Puasa Arafah"];
    
    [f setObject:@{@"category": @"Puasa Asyura dan Tasu'a",
                   @"month": @{@"JULI": @[@5, @6]}} forKey:@"Puasa Asyura dan Tasu'a"];
    
    [f setObject:@{@"category": @"Puasa Ayyamul Bidh",
                   @"month": @{@"JANUARI": @[@13, @15],
                               @"FEBRUARI": @[@12, @14],
                               @"APRIL": @[@12, @14],
                               @"MEI": @[@11, @13],
                               @"JUNI": @[@9, @11],
                               @"JULI": @[@9, @11],
                               @"AGUSTUS": @[@7, @9],
                               @"SEPTEMBER": @[@6, @8],
                               @"OKTOBER": @[@5, @7],
                               @"NOVEMBER": @[@4, @6],
                               @"DESEMBER": @[@4, @6]}} forKey:@"Puasa Ayyamul Bidh"];
    
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
