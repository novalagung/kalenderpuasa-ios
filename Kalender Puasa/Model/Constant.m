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
    return 2023;
}

+ (NSArray *)getYearsHijriyah {
    return @[@1444, @1445];
}

+ (NSDictionary *)getMonthsMapping {
    NSMutableDictionary *months = [[NSMutableDictionary alloc] init];
    [months setObject:@{@"name": @"JANUARI",
                        @"iname": @[
                            @"8 Jumadil Akhir",
                            [NSString stringWithFormat:@"9 Rajab %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @0,
                        @"length": @31,
                        @"prevhijriyahstart": @6,
                        @"hijriyahday1": @[@23]} forKey:@"JANUARI"];
    
    [months setObject:@{@"name": @"FEBRUARI",
                        @"iname": @[
                            @"10 Rajab",
                            [NSString stringWithFormat:@"7 Sya'ban %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @3,
                        @"length": @28,
                        @"hijriyahday1": @[@22]} forKey:@"FEBRUARI"];
    
    [months setObject:@{@"name": @"MARET",
                        @"iname": @[
                            @"8 Sya'ban",
                            [NSString stringWithFormat:@"9 Ramadhan %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @3,
                        @"length": @31,
                        @"hijriyahday1": @[@23]} forKey:@"MARET"];
    
    [months setObject:@{@"name": @"APRIL",
                        @"iname": @[
                            @"10 Ramadhan",
                            [NSString stringWithFormat:@"9 Syawal %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @6,
                        @"length": @30,
                        @"hijriyahday1": @[@22]} forKey:@"APRIL"];
    
    [months setObject:@{@"name": @"MEI",
                        @"iname": @[
                            @"10 Syawal",
                            [NSString stringWithFormat:@"11 Dzulqa'dah %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @1,
                        @"length": @31,
                        @"hijriyahday1": @[@21]} forKey:@"MEI"];
    
    [months setObject:@{@"name": @"JUNI",
                        @"iname": @[
                            @"12 Dzulqa'dah",
                            [NSString stringWithFormat:@"11 Dzulhijjah %@H", [self getYearsHijriyah][0]]
                        ],
                        @"left": @4,
                        @"length": @30,
                        @"hijriyahday1": @[@20]} forKey:@"JUNI"];
    
    [months setObject:@{@"name": @"JULI",
                        @"iname": @[
                            [NSString stringWithFormat:@"12 Dzulhijjah %@H", [self getYearsHijriyah][0]],
                            [NSString stringWithFormat:@"13 Muharram %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @6,
                        @"length": @31,
                        @"hijriyahday1": @[@19]} forKey:@"JULI"];
    
    [months setObject:@{@"name": @"AGUSTUS",
                        @"iname": @[
                            @"14 Muharram",
                            [NSString stringWithFormat:@"14 Shafar %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @2,
                        @"length": @31,
                        @"hijriyahday1": @[@18]} forKey:@"AGUSTUS"];
    
    [months setObject:@{@"name": @"SEPTEMBER",
                        @"iname": @[
                            @"15 Shafar",
                            [NSString stringWithFormat:@"14 Rabi'ul Awal %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @5,
                        @"length": @30,
                        @"hijriyahday1": @[@17]} forKey:@"SEPTEMBER"];
    
    [months setObject:@{@"name": @"OKTOBER",
                        @"iname": @[
                            @"15 Rabi'ul Awal",
                            [NSString stringWithFormat:@"16 Rabi'ul Akhir %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @0,
                        @"length": @31,
                        @"hijriyahday1": @[@16]} forKey:@"OKTOBER"];
    
    [months setObject:@{@"name": @"NOVEMBER",
                        @"iname": @[
                            @"17 Rabi'ul Akhir",
                            [NSString stringWithFormat:@"16 Jumadil Awal %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @3,
                        @"length": @30,
                        @"hijriyahday1": @[@15]} forKey:@"NOVEMBER"];
    
    [months setObject:@{@"name": @"DESEMBER",
                        @"iname": @[
                            @"17 Jumadil Awal",
                            [NSString stringWithFormat:@"18 Jumadil Akhir %@H", [self getYearsHijriyah][1]]
                        ],
                        @"left": @5,
                        @"length": @31,
                        @"hijriyahday1": @[@14]} forKey:@"DESEMBER"];
    
    
    return months;
}

+ (NSDictionary *)getFastingDates {
    NSMutableDictionary *f = [[NSMutableDictionary alloc] init];
    [f setObject:@{@"category": @"Puasa Ramadhan",
                   @"month": @{@"MARET": @[@23, @31],
                               @"APRIL": @[@1, @21]}} forKey:@"Puasa Ramadhan"];

    [f setObject:@{@"category": @"Haram Berpuasa",
                   @"month": @{@"APRIL": @22,
                               @"JUNI": @[@29, @30],
                               @"JULI": @[@1, @2]}} forKey:@"Haram Berpuasa"];
   
    [f setObject:@{@"category": @"Puasa Arafah",
                   @"month": @{@"JUNI": @28}} forKey:@"Puasa Arafah"];
    
    [f setObject:@{@"category": @"Puasa Asyura dan Tasu'a",
                   @"month": @{@"JULI": @[@27, @28]}} forKey:@"Puasa Asyura dan Tasu'a"];
    
    [f setObject:@{@"category": @"Puasa Ayyamul Bidh",
                   @"month": @{@"JANUARI": @[@6, @8],
                               @"FEBRUARI": @[@4, @6],
                               @"MARET": @[@6, @8],
                               @"MEI": @[@4, @6],
                               @"JUNI": @[@2, @4],
                               @"JULI": @[@3, @4, @31],
                               @"AGUSTUS": @[@1, @2, @30, @31],
                               @"SEPTEMBER": @[@1, @29, @30],
                               @"OKTOBER": @[@1, @28, @29, @30],
                               @"NOVEMBER": @[@27, @29],
                               @"DESEMBER": @[@26, @28]}} forKey:@"Puasa Ayyamul Bidh"];
    
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
    return  @[@"f58a78",
              @"f58a78",
              @"f58a78",
              @"f58a78",
              @"f58a78",
              @"f58a78",
              @"f58a78",
              @"f58a78",
              @"f58a78",
              @"f58a78",
              @"f58a78",
              @"f58a78"];
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
