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
    return 2024;
}

+ (NSArray *)getYearsHijriyah {
    return @[@1445, @1446];
}

+ (NSDictionary *)getMonthsMapping {
    NSMutableDictionary *months = [[NSMutableDictionary alloc] init];
    [months setObject:@{@"name": @"JANUARI",
                        @"iname": @[
                            @"19 Jumadil Akhir",
                            [NSString stringWithFormat:@"19 Rajab %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @1,
                        @"length": @31,
                        @"prevhijriyahstart": @17,
                        @"hijriyahday1": @[@13]} forKey:@"JANUARI"];
    
    [months setObject:@{@"name": @"FEBRUARI",
                        @"iname": @[
                            @"20 Rajab",
                            [NSString stringWithFormat:@"19 Sya'ban %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @4,
                        @"length": @29,
                        @"hijriyahday1": @[@11]} forKey:@"FEBRUARI"];
    
    [months setObject:@{@"name": @"MARET",
                        @"iname": @[
                            @"20 Sya'ban",
                            [NSString stringWithFormat:@"20 Ramadhan %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @5,
                        @"length": @31,
                        @"hijriyahday1": @[@12]} forKey:@"MARET"];
    
    [months setObject:@{@"name": @"APRIL",
                        @"iname": @[
                            @"21 Ramadhan",
                            [NSString stringWithFormat:@"21 Syawal %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @1,
                        @"length": @30,
                        @"hijriyahday1": @[@10]} forKey:@"APRIL"];
    
    [months setObject:@{@"name": @"MEI",
                        @"iname": @[
                            @"22 Syawal",
                            [NSString stringWithFormat:@"23 Dzulqa'dah %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @3,
                        @"length": @31,
                        @"hijriyahday1": @[@10]} forKey:@"MEI"];
    
    [months setObject:@{@"name": @"JUNI",
                        @"iname": @[
                            @"24 Dzulqa'dah",
                            [NSString stringWithFormat:@"23 Dzulhijjah %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @6,
                        @"length": @30,
                        @"hijriyahday1": @[@8]} forKey:@"JUNI"];
    
    [months setObject:@{@"name": @"JULI",
                        @"iname": @[
                            [NSString stringWithFormat:@"24 Dzulhijjah %@H", [self getYearsHijriyah][0]],
                            [NSString stringWithFormat:@"25 Muharram %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @1,
                        @"length": @31,
                        @"hijriyahday1": @[@7]} forKey:@"JULI"];
    
    [months setObject:@{@"name": @"AGUSTUS",
                        @"iname": @[
                            @"26 Muharram",
                            [NSString stringWithFormat:@"26 Shafar %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @4,
                        @"length": @31,
                        @"hijriyahday1": @[@6]} forKey:@"AGUSTUS"];
    
    [months setObject:@{@"name": @"SEPTEMBER",
                        @"iname": @[
                            @"27 Shafar",
                            [NSString stringWithFormat:@"26 Rabi'ul Awal %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @0,
                        @"length": @30,
                        @"hijriyahday1": @[@5]} forKey:@"SEPTEMBER"];
    
    [months setObject:@{@"name": @"OKTOBER",
                        @"iname": @[
                            @"27 Rabi'ul Awal",
                            [NSString stringWithFormat:@"27 Rabi'ul Akhir %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @2,
                        @"length": @31,
                        @"hijriyahday1": @[@4]} forKey:@"OKTOBER"];
    
    [months setObject:@{@"name": @"NOVEMBER",
                        @"iname": @[
                            @"29 Rabi'ul Akhir",
                            [NSString stringWithFormat:@"28 Jumadil Awal %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @5,
                        @"length": @30,
                        @"hijriyahday1": @[@3]} forKey:@"NOVEMBER"];
    
    [months setObject:@{@"name": @"DESEMBER",
                        @"iname": @[
                            @"29 Jumadil Awal",
                            [NSString stringWithFormat:@"29 Jumadil Akhir %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @0,
                        @"length": @31,
                        @"hijriyahday1": @[@3]} forKey:@"DESEMBER"];
    
    
    return months;
}

+ (NSDictionary *)getFastingDates {
    NSMutableDictionary *f = [[NSMutableDictionary alloc] init];
    [f setObject:@{@"category": @"Puasa Ramadhan",
                   @"month": @{@"MARET": @[@12, @31],
                               @"APRIL": @[@1, @9]}} forKey:@"Puasa Ramadhan"];

    [f setObject:@{@"category": @"Haram Berpuasa",
                   @"month": @{@"APRIL": @10,
                               @"JUNI": @[@17, @20]}} forKey:@"Haram Berpuasa"];
   
    [f setObject:@{@"category": @"Puasa Arafah",
                   @"month": @{@"JUNI": @16}} forKey:@"Puasa Arafah"];
    
    [f setObject:@{@"category": @"Puasa Asyura dan Tasu'a",
                   @"month": @{@"JULI": @[@15, @16]}} forKey:@"Puasa Asyura dan Tasu'a"];
    
    [f setObject:@{@"category": @"Puasa Ayyamul Bidh",
                   @"month": @{@"JANUARI": @[@25, @27],
                               @"FEBRUARI": @[@23, @25],
                               @"APRIL": @[@22, @24],
                               @"MEI": @[@22, @24],
                               @"JUNI": @[@21, @23],
                               @"JULI": @[@19, @21],
                               @"AGUSTUS": @[@18, @20],
                               @"SEPTEMBER": @[@17, @19],
                               @"OKTOBER": @[@16, @18],
                               @"NOVEMBER": @[@15, @17],
                               @"DESEMBER": @[@15, @17]}} forKey:@"Puasa Ayyamul Bidh"];
    
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
    return @[@"ed962d", @"212429", @"99489a", @"f45d92", @"18a8df", @"c6e1a7"];
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
